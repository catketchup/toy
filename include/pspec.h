#ifndef __PSPEC__
#define __PSPEC__

#include "stdio.h"
#include "stdlib.h"

struct pspec {
  int cl_size;
  double * cl;
};

#ifdef __cplusplus
extern "C" {
#endif
  double add (
    double a, double b);

  int calculate_pspec (
    struct inparam * pinparam,
    struct pspec * ppspec
    );

  int calculate_exp_pspec (
    struct inparam * pinparam,
    int ncl,
    double * incl,
    struct pspec * ppspec
    );
#ifdef __cplusplus
}
#endif

#endif
