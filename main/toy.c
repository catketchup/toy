#include "inparam.h"
#include "pspec.h"
#include "stdio.h"

/* gcc -g toy.c ../source/pspec.c ../source/inparam.c -o toy -I ../include/ -lm */

int main(){
  int cl_size = 10;
  double norm = 2.0;
  double factor = 3.0;
  double a = 1;
  double b = 2;

  /* test add(a, b) */
  double c = add(a, b);
  printf("%f \n", c);

  struct inparam * pinparam;
  struct pspec * ppspec;

  /* alloc memeory for structures */
  pinparam = (struct inparam*) malloc(sizeof(struct inparam));
  ppspec = (struct pspec*) malloc(sizeof(struct pspec));

  printf("%ld \n", sizeof(struct inparam));
  printf("%ld \n", sizeof(struct pspec));

  pinparam->cl_size = cl_size;
  pinparam->norm = norm;
  pinparam->factor = factor;

  int i;

  /* test calculate_pspec(pinparam, ppspec) */
  calculate_pspec(pinparam, ppspec);
  for(i=0; i<cl_size; i++) {
    printf("%f \n", ppspec->cl[i]);
  }

  printf("\n");

  /* test calculate_pspec(pinparam, ppspec) */
  /* create an input cl */
  double * incl = malloc(cl_size*sizeof(double));

  for(i=0; i<cl_size; i++) {
    incl[i] = 2*i;
  }

  calculate_exp_pspec (pinparam, 1, incl, ppspec);
  for(i=0; i<cl_size; i++) {
    printf("%f \n", ppspec->cl[i]);
  }

  printf("\n");

  return 0;
}
