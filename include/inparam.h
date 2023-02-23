#ifndef __INPARAM__
#define __INPARAM__

struct inparam {
  int cl_size;
  double norm;
  double factor;
};

#ifdef __cplusplus
extern "C" {
#endif
  double add (
    double a, double b);
#ifdef __cplusplus
}
#endif

#endif
