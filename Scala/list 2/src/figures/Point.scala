package figures

import numbers.Rational

class Point(var x: Rational, var y: Rational) {
  override def toString: String =
    s"($x, $y)"
}
