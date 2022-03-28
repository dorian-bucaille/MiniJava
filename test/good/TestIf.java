class TestIf {
  public static void main(String[] args) {
    System.out.println(new Main().test());
  }
}
class Main {
  public int test() {
    int a;
    int b;
    a = 10;
    b = 10;
    
    if(a == b) {
      System.out.println("a == b");
    }
    
    if(a != b) {
      System.out.println("a != b");
    }
    
    return 0;
  }
}