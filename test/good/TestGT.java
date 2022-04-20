class TestGT {
  public static void main(String[] args) {
      System.out.println(new Main().test());          
  }
}

class Main {
  public int test(){
      int a ;
      int res;
      a = 5;

      if(a > 6) {
          res = 1;
      } else {
          res = 0;
      }

      System.out.println(res);
 
      return 0;
  }
}