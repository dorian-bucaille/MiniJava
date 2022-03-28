class TestMoinsEqual {
  public static void main(String[] args) {
      System.out.println(new Main().test());          
  }
}

class Main {
  public int test(){
      int a ;
      a = 10;
      a-=5;

      System.out.println(a);
      a -=3;
      System.out.println(a);

      return 0;
  }
}