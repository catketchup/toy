#include "inparam.h"
#include "pspec.h"
#include "stdio.h"

/* gcc -g toy.c ../source/pspec.c -o toy -I ../include/ */

int main(){
  int cl_size = 10;
  double norm = 2.0;
  double factor = 3.0;
  double a = 1;
  double b = 2;

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


  calculate_pspec(pinparam, ppspec);

  int i;
  for(i=0; i<cl_size; i++) {
    printf("%f \n", ppspec->cl[i]);
  }

  printf("\n");
  double c = add(a, b);
  printf("%f \n", c);

  return 0;
}
