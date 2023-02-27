#ifndef __PSPEC__
#define __PSPEC__

#include "stdio.h"
#include "stdlib.h"

struct pspec {int cl_size;
  int nmap;
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
    double * incl,
    struct pspec * ppspec
    );

  int test_ndarray(struct inparam * pinparam,
                   int nmap,
                   double * incl,
                   struct pspec * ppspec
    );
#ifdef __cplusplus
}
#endif

#endif
