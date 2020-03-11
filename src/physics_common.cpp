#include "openmc/physics_common.h"

#include "openmc/settings.h"
#include "openmc/random_lcg.h"

namespace openmc {

//==============================================================================
// RUSSIAN_ROULETTE
//==============================================================================

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

void russian_roulette_importance(Particle* p)
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

void russian_roulette_weight_window(Particle* p, double weight_cutoff, double weight_survive)
{
  if (p->wgt_ < weight_cutoff) {
    if (prn() < p->wgt_ / weight_survive) {
      p->wgt_ = weight_survive;
      p->wgt_last_ = p->wgt_;
    } else {
      p->wgt_ = 0.;
      p->wgt_last_ = 0.;
      p->alive_ = false;
    }
  }
}

} //namespace openmc
