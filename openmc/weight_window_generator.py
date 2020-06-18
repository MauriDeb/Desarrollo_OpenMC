import builtins
import openmc
import openmc.lib
import random
import math
import numpy as np

class weight_window_generator:
    """Weight windows are generated for every cell by using importance sampling.
    Return a diccionary of every cell importance. Key's are the cell's id and
    value is a list of the importance and its standard deviation.

    Parameters
    ----------
    universe : openmc.Universe variable
        Indicates the region wich is going to be analized.

    mesh : List
        Contains all the point to analyze.

    rel_err : float
        Determines the relative error for wich the importances are going to be determined.

    important_cell_id : int
        Indicate the cell wich is going to be the cell of maximum importance.

    Attributes
    ----------
    cell_dicc : Diccionary
        Contains the information of the importances of every cell. The keys are the cell's id.

    """

    def __init__(self, geometry, mesh, rel_err, important_cell_id, source_position = None, mgxs_lib = None, max_imp = 1500, type = 'difusion'):
        self.cell_dicc = {}
        self.rel_err = rel_err
        self.mesh = list.copy(mesh)
        self.geometry = geometry
        self.important_cell_id = important_cell_id
        self.imp_cell_importance = max_imp
        self.distances = []
        self.mgxs_info = mgxs_lib.all_mgxs
        self.mgxs = {}
        self.importance_aux = 0
        self.bank_importance = []
        self.accepted_rel_err = False
        self.source_position = source_position
        self.type = type
        self.rescale = rescale

        self.all_cells = self.geometry.get_all_cells().values()

        ############Ejecucion de funciones#############
        self.get_all_cells_info()
        self.mesh_definition()
        self.simulation()
        self.weight_window_setter()
        ############Fin ejecucion de funciones########

    def get_all_cells_info(self):
        for cell in self.all_cells:
            self.cell_dicc[cell.id] = [] ##Diccionario con todos los puntos que hay en cada celda.

            self.get_mgxs_data(cell.id)  ##Carga el diccionario "self.mgxs" con las secciones eficaces y las importancias.


    def get_mgxs_data(self, cell_id):
        cell_mgxs_data_total = self.mgxs_info[cell_id]['total']
        cell_get_mean_Xtotal = cell_mgxs_data_total.get_pandas_dataframe().mean()
        Xtotal = cell_get_mean_Xtotal.get('mean')

        cell_mgxs_data_abs = self.mgxs_info[cell_id]['absorption']
        cell_get_mean_Xabs = cell_mgxs_data_abs.get_pandas_dataframe().mean()
        Xabs = cell_get_mean_Xabs.get('mean')

        if (self.type == 'difusion'):
            if (Xabs == 0):
                L = math.inf
            else:
                L = (1/Xtotal) * np.sqrt(((Xtotal/Xabs)-1)/3)

        elif (self.type == 'total'):
            L = Xtotal

        else:
            msg = 'Importance aproximation type is not \'total\' or \'difusion\'.'
            raise ValueError(msg)


        if cell_id == self.important_cell_id:
            self.mgxs[cell_id] = [L, self.imp_cell_importance]

        else:
            self.mgxs[cell_id] = [L, None] #El None es para guardar las importancias.


    def which_cell(self, position):
        try:
            cell_id = openmc.lib.find_cell(position)[0].id
        except:
            cell_id = -1
        return cell_id


    def modulo(self, v):
        return np.sqrt((v[0])**2 + (v[1])**2 + (v[2])**2)

    def distance(self, punto_inicial, punto_final):
        v = [punto_final[0]-punto_inicial[0] , punto_final[1]-punto_inicial[1], punto_final[2]-punto_inicial[2]]
        return self.modulo(v)


    def versor(self, punto_inicial, punto_final):
        v = [punto_final[0]-punto_inicial[0] , punto_final[1]-punto_inicial[1], punto_final[2]-punto_inicial[2]]
        R = self.modulo(v)

        cosx = v[0]/R
        cosy = v[1]/R
        cosz = v[2]/R

        versor = [cosx, cosy, cosz]

        return versor

    def traslation(self, punto_actual, versor, paso):

        nuevo_punto = [None] * 3
        nuevo_punto[0] = paso * versor[0] + punto_actual[0]
        nuevo_punto[1] = paso * versor[1] + punto_actual[1]
        nuevo_punto[2] = paso * versor[2] + punto_actual[2]

        return nuevo_punto

    def mesh_definition(self):
        """Search for all the point that are in a cell.

        Return
        ----------
        mesh : list
            All the point with that are inside a cell and the cell id
            of the cell they were found in.

        """

        for i in range (0, len(self.mesh)):

            position = self.mesh[i]
            cell_id = self.which_cell(position)

            if (cell_id != -1):
                self.cell_dicc[cell_id].append(position)

        for key in self.cell_dicc:
            random.shuffle(self.cell_dicc[key])


    def simulation(self):
        len_important_cell = len(self.cell_dicc[self.important_cell_id])
        important_position_cell = self.cell_dicc[self.important_cell_id]

        #Recorro todos los key del diccionario, que son los ids de las celdas
        for cell_id in self.cell_dicc:
            print("simulation",cell_id)

            if cell_id == self.important_cell_id: #No analizo el caso en el que la celda sea la importante
                continue

            if len(self.cell_dicc[cell_id])==0: #En caso de que no haya puntos en una celda que no analice
                msg = 'Cell doesnt have any point inside for the simulation.'
                print('Cell', cell_id,'\n')
                raise ValueError(msg)

            end_positions_cell = self.cell_dicc[cell_id]
            len_end_positions_cell = len(self.cell_dicc[cell_id])
            self.accepted_rel_err = False
            #f = 0
            #print("Celda numero", cell_id," afuera while. Accepted?: ", self.accepted_rel_err)

            while self.accepted_rel_err == False:

                comparator = 0.25

                #print("Celda numero", cell_id, ", iteracion= ", f)

                if len_end_positions_cell > len_important_cell:
                    print("celda final: ", len_end_positions_cell)
                    print("celda importante: ", len_important_cell)
                    for i in range(0, len_end_positions_cell):

                        if i>=len_important_cell-1:

                            random_pos = random.randrange(len_important_cell)
                            initial_position = important_position_cell[random_pos - 1]

                        else:
                            initial_position = important_position_cell[i]

                        final_position = end_positions_cell[i]

                        versor = self.versor(initial_position, final_position)
                        total_distance = self.distance(initial_position, final_position)

                        self.transport(versor, initial_position, final_position)

                        if (i == len_end_positions_cell * comparator and i!= len_end_positions_cell-1):
                            value = self.bank_statistics()
                            print(i)
                            if self.accepted_rel_err == False:
                                comparator = comparator + 0.25
                            else:
                                break


                else:
                    print("celda final: ", len_end_positions_cell)
                    print("celda importante: ", len_important_cell)

                    for i in range(0, len_important_cell):

                        if i>=len_end_positions_cell-1:

                            random_pos = random.randrange(len_end_positions_cell)
                            final_position = end_positions_cell[random_pos - 1]

                        else:
                            final_position = end_positions_cell[i]

                        initial_position = important_position_cell[i]

                        versor = self.versor(initial_position, final_position)
                        total_distance = self.distance(initial_position, final_position)

                        self.transport(versor, initial_position, final_position)

                        if (i == len_important_cell * comparator and i!= len_important_cell-1):
                            value = self.bank_statistics()
                            print(i)
                            if self.accepted_rel_err == False:
                                comparator = comparator + 0.25
                            else:
                                break

                value = self.bank_statistics()
                #f = f + 1
                if self.accepted_rel_err == False:
                    #print("hizo un shuffle")
                    random.shuffle(end_positions_cell)


            #print("sali del while", value, cell_id)
            self.bank_importance.clear()
            self.mgxs[cell_id][1] = value

    def transport(self, versor, initial_position, final_position):
        """Receives inicial point and versor

        Returns
        --------

        distances : list
            A list of lists, which each one have the distance and the cell id.
        """
        try:
            distance_to_boundary = openmc.lib.distance_to_boundary(initial_position, versor)
            distance_to_final_position = self.distance(initial_position, final_position)

            if (distance_to_final_position > distance_to_boundary):

                if len(self.distances) == 0:
                    self.distances.append([distance_to_boundary, self.which_cell(initial_position)])

                else:
                    self.distances[-1][1]= self.which_cell(initial_position)
                    self.distances.append([distance_to_boundary, None])

                initial_position = self.traslation(initial_position, versor, distance_to_boundary)

                self.transport(versor, initial_position, final_position)

            else:
                #Esto quiere decir que el punto final esta mas cerca que la otra sup.
                #Hay un problema a veces con identificar la ultima celda antes de la final, por
                #algun motivo que no logro entender. Por eso mando un if preguntando si es la misma
                #que la final y si es asi, la retrocedo un pendejecimo y tomo la celda.

                almost_last_cell = self.which_cell(initial_position)
                last_cell = self.which_cell(final_position)

                if last_cell == almost_last_cell:
                    initial_position = self.traslation(initial_position, versor, -1e-6)
                    self.distances[-1][1]= self.which_cell(initial_position)

                else:
                    self.distances[-1][1]= self.which_cell(initial_position)

                self.distances.append([distance_to_final_position, last_cell])
                self.importance_calculator()
                self.distances.clear()

        except:
            self.distances.clear()


    ##step[0] es la distancia
    ##step[1] es el id de la celda
    def importance_calculator(self):
        self.importance_aux = self.imp_cell_importance
        for step in self.distances:
            if (step[1] != -1):#Esto es si recorre una distancia en vacio, porque no va a encontrar en una celda.
                self.importance_aux = self.importance_aux * np.exp(-self.mgxs[step[1]][0]/step[0]) / step[0]#exponencial

            if self.importance_aux < 1e-8:
                #print("estoy aca")
                self.importance_aux = 0
                break

        if self.importance_aux !=0:
            self.bank_importance.append(self.importance_aux)


    def bank_statistics(self):
        n = len(self.bank_importance)
        suma = builtins.sum(self.bank_importance)

        if n==0:
            print("Nada en la bolsa")
            mean= 0
            rel_err = 0

        else:
            print("Se encontraron valores en la bolsa")
            mean = suma/n
            sum_sq = builtins.sum(i*i for i in self.bank_importance)
            std_dev = np.sqrt((sum_sq/n - mean*mean) / (n-1)) if n!= 0 else 0
            rel_err = std_dev / np.abs(mean) if mean != 0 else 0

        if (rel_err <=self.rel_err):
            self.accepted_rel_err = True
            print("Es verdadero el error: ", rel_err)
        else:
            self.accepted_rel_err = False
            print("Es falso el error: ", rel_err)

        return mean

    def window_rescale(self):
        """Because the particle source generate unitary weighted particles
        we need to rescale all the window so all the newborn particles
        are within the window where the source is defined."""

        if (self.source_position != None):
            source_cell_id = self.which_cell(self.source_position)
            source_cell_importance = self.mgxs[source_cell_id][1]

            if (source_cell_importance != 0):
                factor = round(1/source_cell_importance, 4)
            else:
                msg = 'Source cell definition has zero importance.'
                raise ValueError(msg)

            for key in self.mgxs:
                if (key != source_cell_id and self.mgxs[key][1]==self.mgxs[key][1]):
                    self.mgxs[key][1] = self.mgxs[key][1] * factor
                else:
                    self.mgxs[key][1] = 1.0



    def weight_window_setter(self):
        self.window_rescale()
        all_cells = self.geometry.get_all_cells().values()

        print(self.mgxs)

        for cell in all_cells:
            importance = round(self.mgxs[cell.id][1],4)

            if importance == 0:
                cell.lower_weight = 1e4
            else:
                cell.lower_weight = round(1/importance,4)
            cell.upper_weight = 5 * cell.lower_weight
            cell.survival_weight = 2.5 * cell.lower_weight
            cell.importance = importance

    def results(self):
        all_cells = self.geometry.get_all_cells().values()

        results = []

        for cell in all_cells:
            results.append([cell.id, cell.importance, cell.lower_weight, cell.upper_weight, cell.survival_weight])

        return results

class points_generator:
    def __init__(self, sup_der= None, inf_izq= None, nx= 1, ny= 1, nz= 1):
            self.inf_izq = inf_izq
            self.sup_der = sup_der
            self.ladox = self.sup_der[0] - self.inf_izq[0]
            self.ladoy = self.sup_der[1] - self.inf_izq[1]
            self.ladoz = self.sup_der[2] - self.inf_izq[2]
            self.nx = nx
            self.ny = ny
            self.nz = nz
            self.dx = self.ladox/self.nx
            self.dy = self.ladoy/self.ny
            self.dz = self.ladoz/self.nz
            self.mesh = []
            self.cont = 0

    def generator(self):
            for i in range(0, self.nx+1):
                for j in range(0, self.ny+1):
                    for k in range(0, self.nz+1):
                        self.mesh.append([self.inf_izq[0] + i * self.dx, self.inf_izq[1] + j * self.dy, self.inf_izq[2] + k * self.dz])
                        self.cont+=1

            return self.mesh
