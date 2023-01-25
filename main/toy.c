#include "toy.h"

int main(int argc, char **argv) {
  int a = 1;
  int b = 1;
  int c;

  c = toy_function(a,b);
  printf("\n");
  printf("%d", c);
  return 0;
}
