class TestLEQ {
  public static void main(String[] args) {
      System.out.println(new Main().test());          
  }
}

class Main {
  public int test(){
      int a ;
      int b ;
      boolean res;
      a = 5;
      b = 6;
      res = a <= b;

      System.out.println(res);
 
      return 0;
  }
}