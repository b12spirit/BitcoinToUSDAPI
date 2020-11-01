class Calculations {
  // Input: number of cups (positive integer)
  // Output: number of ounces in a cup
  static double usdtobtc(double dollar) {
    double bitcoin = 0.000072;
    return dollar * bitcoin;
  }

  static double btctousd(double bitcoin) {
    double dollar = 13804.60;
    return bitcoin * dollar;
  }
}
