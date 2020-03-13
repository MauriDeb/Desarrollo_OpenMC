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

void russian_roulette(Particle* p)
{
  if (p->wgt_ < settings::weight_cutoff / p->imp_ ) {
    if (prn() < p->wgt_ * p->imp_ / settings::weight_survive) {
      p->wgt_ = settings::weight_survive / p->imp_ ;
      p->wgt_last_ = p->wgt_;
    } else {
      p->wgt_ = 0.;
      p->wgt_last_ = 0.;
      p->alive_ = false;
    }
  }
}

void russian_roulette_weight_window(Particle* p)
{
  if (p->wgt_ < p->lower_weight_) {
    if (prn() < p->wgt_ / p->survival_weight_) {
      p->wgt_last_ = p->wgt_;
      p->wgt_ = p->survival_weight_;
    } else {
      p->wgt_ = 0.;
      p->wgt_last_ = 0.;
      p->alive_ = false;
    }
  }
}

} //namespace openmc
