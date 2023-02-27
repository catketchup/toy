#include "inparam.h"
#include "pspec.h"
#include "math.h"

int calculate_pspec (
  struct inparam * pinparam,
  struct pspec * ppspec
  ) {
  int cl_size = pinparam->cl_size;
  double norm = pinparam->norm;
  double factor = pinparam->factor;

  int i;
  double * cl = malloc(cl_size*sizeof(double));

  ppspec->cl = malloc(cl_size*sizeof(double));
  ppspec->cl_size = cl_size;

  for (i=0; i<cl_size; i++) {
    cl[i] = norm*exp(factor*i);
    /* cl[i] = norm*factor*i; */
  }

  for (i=0; i<cl_size; i++) {
    ppspec->cl[i] = cl[i];
  }

  free(cl);

  return 0;
}

int calculate_exp_pspec (struct inparam * pinparam,
                         double * incl,
                         struct pspec * ppspec
  ) {
  int cl_size = pinparam->cl_size;
  double norm = pinparam->norm;
  double factor = pinparam->factor;

  int i;

  ppspec->cl = malloc(cl_size*sizeof(double));
  ppspec->cl_size = cl_size;

  for (i=0; i<cl_size; i++) {
    ppspec->cl[i] = norm*exp(factor*incl[i]);
  }

  return 0;
}

int test_ndarray(struct inparam * pinparam,
                 int nmap,
                 double * incl,
                 struct pspec * ppspec
  ) {
  ppspec->cl_size = pinparam->cl_size;
  ppspec->nmap = nmap;

  ppspec->cl = malloc(nmap*nmap*ppspec->cl_size*sizeof(double));
  int i;
  for(i=0; i<nmap*nmap*ppspec->cl_size; i++){
    ppspec->cl[i] = incl[i];
  }

  return 0;
}
