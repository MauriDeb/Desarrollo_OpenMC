#include "openmc/physics_common.h"

#include "openmc/settings.h"
#include "openmc/random_lcg.h"

namespace openmc {

//==============================================================================
// RUSSIAN_ROULETTE
//==============================================================================
/*
void russian_roulette(Particle* p)
{
  if (p->wgt_ < settings::weight_cutoff) {
    if (prn() < p->wgt_ / settings::weight_survive) {
      p->wgt_ = settings::weight_survive;
      p->wgt_last_ = p->wgt_;
    } else {
      p->wgt_ = 0.;
      p->wgt_last_ = 0.;
      p->alive_ = false;
    }
  }
}
*/

//Ruleta rusa para control poblacional.
void russian_roulette(Particle* p)
{
  if (p->wgt_ < settings::weight_cutoff / p->imp_ ) {
    if (prn() < p->wgt_ * p->imp_ / settings::weight_survive) {
      p->wgt_last_ = p->wgt_;
      p->wgt_ = settings::weight_survive / p->imp_ ;
    } else {
      p->wgt_ = 0.;
      p->wgt_last_ = 0.;
      p->lower_weight_ = -1;
      p->upper_weight_ = -1;
      p->survival_weight_ = -1;
      p->imp_ = -1;
      p->imp_last_ = -1;
      p->alive_ = false;
    }
  }
}

void russian_roulette_weight_window(Particle* p)
{
    if (prn() < p->wgt_ / p->survival_weight_) {
      p->wgt_last_ = p->wgt_;
      p->wgt_ = p->survival_weight_;
    } else {
      //std::cout<<"It's dead, Jim.\n";
      p->wgt_ = 0.;
      p->wgt_last_ = 0.;
      p->lower_weight_ = -1;
      p->upper_weight_ = -1;
      p->survival_weight_ = -1;
      p->imp_ = -1;
      p->imp_last_ = -1;
      p->alive_ = false;
    } 
}

} //namespace openmc
