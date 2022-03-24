class DoubleEqual {
    public static void main(String[] args) {
        System.out.println(new I().run(42));
    }
}

class I {
    public int run(int n) {
        int res;
        if (n == 0) {
            res = 0;
        } else {
            res = 1;
        }
        return res;
    }
}