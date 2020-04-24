import figures._
import numbers._

  var rat1 = new Rational(50, 6)

  val rat_add = rat1.+(rat1)

  val rat_sub = rat1.-(rat1)

  val rat_mult = rat1.*(rat1)

  val rat_div = rat1.+(rat1)./(rat1)

  val zero = Rational.zero()

  val one = Rational.one()

  val ttt = new Rational(4)

  val p1 = new Point(new Rational(0,1), new Rational(0, 1))
  val p2 = new Point(new Rational(3,1), new Rational(0, 1))
  val p3 = new Point(new Rational(0,1), new Rational(3, 1))
  val p4 = new Point(new Rational(3,1), new Rational(3, 1))

  val t1 = new Triangle(p1, p2, p3)
t1.area
  val r1 = new Rectangle(p1, p2, p3, p4)
r1.area
  val s1 = new Square(p1, p4)
s1.area

  val ll = List(t1, r1, s1)

  singleton.areaSum(ll)
  singleton.printAll(ll)

