#include "input.h"
#include "ps.h"
#include "stdio.h"

double add (
  double a, double b) {
  double c = a+b;
  return c;
}


int calculate_ps (
  struct input * pinput,
  struct ps * pps
  ) {
  pps->cl_size = pinput->cl_size;
  int i;
  double *cl = malloc(pinput->cl_size);

  for (i=0; i<pinput->cl_size; i++) {
    
  }
}
