# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/mauricio/openmc-qt/openmc

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/mauricio/openmc-qt/openmc/build

# Include any dependencies generated for this target.
include CMakeFiles/pugixml.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/pugixml.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/pugixml.dir/flags.make

CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o: CMakeFiles/pugixml.dir/flags.make
CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o: ../vendor/pugixml/pugixml.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mauricio/openmc-qt/openmc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o -c /home/mauricio/openmc-qt/openmc/vendor/pugixml/pugixml.cpp

CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mauricio/openmc-qt/openmc/vendor/pugixml/pugixml.cpp > CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.i

CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mauricio/openmc-qt/openmc/vendor/pugixml/pugixml.cpp -o CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.s

CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o.requires:

.PHONY : CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o.requires

CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o.provides: CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o.requires
	$(MAKE) -f CMakeFiles/pugixml.dir/build.make CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o.provides.build
.PHONY : CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o.provides

CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o.provides.build: CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o


# Object files for target pugixml
pugixml_OBJECTS = \
"CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o"

# External object files for target pugixml
pugixml_EXTERNAL_OBJECTS =

lib/libpugixml.a: CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o
lib/libpugixml.a: CMakeFiles/pugixml.dir/build.make
lib/libpugixml.a: CMakeFiles/pugixml.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mauricio/openmc-qt/openmc/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library lib/libpugixml.a"
	$(CMAKE_COMMAND) -P CMakeFiles/pugixml.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/pugixml.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/pugixml.dir/build: lib/libpugixml.a

.PHONY : CMakeFiles/pugixml.dir/build

CMakeFiles/pugixml.dir/requires: CMakeFiles/pugixml.dir/vendor/pugixml/pugixml.cpp.o.requires

.PHONY : CMakeFiles/pugixml.dir/requires

CMakeFiles/pugixml.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/pugixml.dir/cmake_clean.cmake
.PHONY : CMakeFiles/pugixml.dir/clean

CMakeFiles/pugixml.dir/depend:
	cd /home/mauricio/openmc-qt/openmc/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mauricio/openmc-qt/openmc /home/mauricio/openmc-qt/openmc /home/mauricio/openmc-qt/openmc/build /home/mauricio/openmc-qt/openmc/build /home/mauricio/openmc-qt/openmc/build/CMakeFiles/pugixml.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/pugixml.dir/depend

