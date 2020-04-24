package numbers

class Rational(num: Int, den: Int =1) {
  require(den > 0, "den must be greater than 0")

  def gcd(a: Int, b: Int): Int = {
    if (b == 0) a else gcd(b, a % b)
  }

  val res_gcd: Int = gcd(num, den)
  num /= res_gcd
  den /= res_gcd

  def to_double(): Double ={
    num/den
  }

  def +(other: Rational): Rational = {
    val res_num = other.num * den + num * other.den
    val res_den = den * other.den
    new Rational(res_num, res_den)
  }

  def -(other: Rational): Rational = {
    val res_num = other.num * den - num * other.den
    val res_den = den * other.den
    new Rational(res_num, res_den)
  }

  def *(other: Rational): Rational = {
    val res_num = num * other.num
    val res_den = den * other.den
    new Rational(res_num, res_den)
  }

  def /(other: Rational): Rational = {
    require(other.num > 0, "division by 0")
    val res_num = num * other.den
    val res_den = den * other.num
    new Rational(res_num, res_den)
  }

  override def toString: String = {
    val res_int: Int = num / den
    val res_num: Int = num - res_int * den
    if (res_int > 0 && res_num != 0){
      s"$res_int $res_num/$den"
    } else if(res_int > 0){
      s"$res_int"
    }else if(res_num !=0){
      s"$res_num/$den"
    }else{
      "0"
    }
  }

}

object Rational{
  //def apply(num: Int): Rational = new Rational(num)
  def zero(): Rational ={
    new Rational(0, 1)
  }
  def one(): Rational ={
    new Rational(1, 1)
  }
}

