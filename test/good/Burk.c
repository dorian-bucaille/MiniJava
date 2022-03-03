/*
class Burk {
  public static void main(String[] args) {
    System.out.println(new One().start());
  }
}
class One {
  int tag;
  int it;
  public int setTag() {
    tag = 1;
    return 0;
  }
  public int getTag() {
    return tag;
  }
  public int setIt(int i) {
    it = i;
    return 0;
  }
  public int getIt() {
    return it;
  }
  public int start() {
    int ignore;
    Two two;
    One one;
    two = new Two();
    one = two;
    ignore = one.setTag();
    System.out.println(one.getTag());
    ignore = one.setIt(17);
    ignore = two.setTag();
    System.out.println(two.getIt());
    System.out.println(two.getThat());
    ignore = two.resetIt();
    System.out.println(two.getIt());
    System.out.println(two.getThat());
    return 0;
  }
}
class Two extends One {
  int it;
  public int setTag() {
    tag = 2;
    it = 3;
    return 0;
  }
  public int getThat() {
    return it;
  }
  public int resetIt() {
    return this.setIt(42);
  }
}*/
#include <stdio.h>
#include <stdlib.h>
#include "tgc.h"
#pragma GCC diagnostic ignored "-Wpointer-to-int-cast"
#pragma GCC diagnostic ignored "-Wint-to-pointer-cast"
struct array { int* array; int length; };
tgc_t gc;
struct One;
struct Two;
void* One_setTag(struct One* this);
void* One_getTag(struct One* this);
void* One_setIt(struct One* this, int i);
void* One_getIt(struct One* this);
void* One_start(struct One* this);
void* Two_setTag(struct Two* this);
void* Two_getThat(struct Two* this);
void* Two_resetIt(struct Two* this);
struct One {
  void* (**vtable)();
  int One_it;
  int One_tag;
};
struct Two {
  void* (**vtable)();
  int One_it;
  int One_tag;
  int Two_it;
};
void* (*One_vtable[])() = { One_setTag, One_getTag, One_setIt, One_getIt, One_start };
void* (*Two_vtable[])() = { Two_setTag, One_getTag, One_setIt, One_getIt, One_start, Two_getThat, Two_resetIt };
void* One_setTag(struct One* this) {
  this->One_tag = 1;
  return (void*)(0);
}
void* One_getTag(struct One* this) {
  return (void*)(this->One_tag);
}
void* One_setIt(struct One* this, int i) {
  this->One_it = i;
  return (void*)(0);
}
void* One_getIt(struct One* this) {
  return (void*)(this->One_it);
}
void* One_start(struct One* this) {
  int ignore;
  struct Two* two;
  struct One* one;
  two = ({ struct Two* res = tgc_calloc(({ extern tgc_t gc; &gc; }), 1, sizeof(*res)); res->vtable = Two_vtable; res; });
  one = (struct One*) two;
  ignore = ({ struct One* tmp1 = one; (int) tmp1->vtable[0](tmp1); });
  printf("%d\n", ({ struct One* tmp1 = one; (int) tmp1->vtable[1](tmp1); }));
  ignore = ({ struct One* tmp1 = one; (int) tmp1->vtable[2](tmp1, 17); });
  ignore = ({ struct Two* tmp1 = two; (int) tmp1->vtable[0](tmp1); });
  printf("%d\n", ({ struct Two* tmp1 = two; (int) tmp1->vtable[3](tmp1); }));
  printf("%d\n", ({ struct Two* tmp1 = two; (int) tmp1->vtable[5](tmp1); }));
  ignore = ({ struct Two* tmp1 = two; (int) tmp1->vtable[6](tmp1); });
  printf("%d\n", ({ struct Two* tmp1 = two; (int) tmp1->vtable[3](tmp1); }));
  printf("%d\n", ({ struct Two* tmp1 = two; (int) tmp1->vtable[5](tmp1); }));
  return (void*)(0);
}
void* Two_setTag(struct Two* this) {
  this->One_tag = 2;
  this->Two_it = 3;
  return (void*)(0);
}
void* Two_getThat(struct Two* this) {
  return (void*)(this->Two_it);
}
void* Two_resetIt(struct Two* this) {
  return (void*)(({ struct Two* tmp1 = this; (int) tmp1->vtable[2](tmp1, 42); }));
}
int main(int argc, char *argv[]) {
  tgc_start(&gc, &argc);
  printf("%d\n", ({ struct One* tmp1 = ({ struct One* res = tgc_calloc(({ extern tgc_t gc; &gc; }), 1, sizeof(*res)); res->vtable = One_vtable; res; }); (int) tmp1->vtable[4](tmp1); }));
  tgc_stop(&gc);

  return 0;
}
