class TestPlusPlus {
  public static void main(String[] args) {
      System.out.println(new Main().test());          
  }
}

class Main {
  public int test(){
      int res ;
      res = 5;

      System.out.println(res);
      res--;
      System.out.println(res);
  
      return 0;
  }
}