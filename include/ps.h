#ifndef __PS__
#define __PS__

struct ps {
  int cl_size;
  double * cl;
}

#ifdef __cplusplus
extern "C" {
#endif
  double add (
    int a, int b);

  int calculate_ps (
    struct param * pparam,
    struct ps * pps
    );
#ifdef __cplusplus
}
#endif

#endif
