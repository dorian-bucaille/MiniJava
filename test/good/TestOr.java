public class TestOr {
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
          System.out.println("a or b");
      }
      return 0;
  }
}