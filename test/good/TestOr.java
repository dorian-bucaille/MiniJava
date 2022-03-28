class TestOr {
  public static void main(String[] args) {
    System.out.println(new Main().test());          
  }
}

class Main {
  public int test(){
      boolean a;
      boolean b;

      a = true;
      b = false;
      if (a || b) {
          System.out.println(1);
      }else{
        System.out.println(0);
      }
      return 0;
  }
}