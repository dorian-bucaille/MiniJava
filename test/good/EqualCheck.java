class EqualCheck {
  public static void main(String[] args) {
      System.out.println(new TestEqual().test());
  }
}
class ClasseAlpha {

}
class ClasseBeta extends ClasseAlpha {

}
class ClasseCharlie extends ClasseAlpha {

}
class TestEqual {
  public int test() {
      ClasseBeta beta;
      ClasseAlpha betaToAlpha;
      ClasseAlpha alpha;
      int resultat;
      beta = new ClasseBeta();
      betaToAlpha = beta;
      alpha = new ClasseAlpha();

      if (!(alpha == beta) && 1 == 1 && (beta == betaToAlpha) && !(alpha == betaToAlpha)) {
          resultat = 1;
      } else {
          resultat = 0;
      }
      return resultat;
  }
}