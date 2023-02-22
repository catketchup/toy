#include "inparam.h"
#include "pspec.h"
#include "math.h"

double add (
  double a, double b) {
  double c = a+b;
  return c;
}


int calculate_pspec (
  struct inparam * pinparam,
  struct pspec * ppspec
  ) {
  int cl_size = pinparam->cl_size;
  double norm = pinparam->norm;
  double factor = pinparam->factor;

  int i;
  double * cl = malloc(cl_size);
  ppspec->cl = malloc(cl_size);

  ppspec->cl_size = cl_size;

  for (i=0; i<cl_size; i++) {
    /* cl[i] = norm*exp(factor*i); */
    cl[i] = norm*factor*i;
  }
  for (i=0; i<cl_size; i++) {
    ppspec->cl[i] = cl[i];
  }

  free(cl);

  return 0;
}
