class Operations {

  static Sum(double a, double b){
    return (a + b).toString();
  }

  static Difference(double a, double b) {
    return (a - b).toString();
  }

  static Multiply(double a, double b){
    return (a * b).toString();
  }

  static Divide(double a, double b){
    if (b == 0) return "Infinity";
    return (a / b).toString();
  }

  static Pow(double a, double b){

    if (b == 0) return "1";

    double result = a;

    for (int i = 1; i < b; i++ ) {
        result *= a;
    }

    return result.toString();
  }
}