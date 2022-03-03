public class EqualCheck {

      public static void main(String[] args) {
        System.out.println(new C().test());
    }
}

class C {
  public boolean test() {
      int a = 1;
      int b = 1;
      boolean res = a==b;
      return res;
  }
}