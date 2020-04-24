package plugins

trait text_manipulations {
  def Reverting(x: String): String = {
    x.reverse
  }

  def LowerCasing(x: String): String = {
    x.toLowerCase
  }

  def SingleSpacing(x: String): String = {
    x.replaceAll(" +", " ")
  }

  def NoSpacing(x: String): String = {
    x.replaceAll("\\s", "")
  }

  def DuplicateRemoval(x: String): String = {
    @scala.annotation.tailrec
    def help(s: String, i: Int): String = {
      if (i == s.length) {
        s
      } else if (s.count(_ == s(i)) > 1) {
        help(s.replaceAll(s(i).toString, ""), i)
      } else {
        help(s, i + 1)
      }
    }
    help(x, 0)
  }

  def Rotating(x: String): String = {
    x(x.length - 1).toString + x.dropRight(1)
  }

  def Doubling(x: String): String = {
    @scala.annotation.tailrec
    def help(acc: String, i: Int): String = {
      if (i == x.length) {
        acc
      } else if (i % 2 == 0) {
        help(acc + x(i), i + 1)
      } else {
        help(acc + x(i) + x(i), i + 1)
      }
    }
    help("", 0)
  }

  def Shortening(x: String): String = {
    @scala.annotation.tailrec
    def help(acc: String, i: Int): String = {
      if (i == x.length) {
        acc
      } else if (i % 2 == 0) {
        help(acc + x(i), i + 1)
      } else {
        help(acc, i + 1)
      }
    }
    help("", 0)
  }

}

object Actions extends text_manipulations {

  val text = "abcd AAA      YTiop    "

  val actionA: String = Shortening(Doubling(SingleSpacing(text)))
  val actionB: String = Doubling(Shortening(NoSpacing(text)))
  val actionC: String = Doubling(LowerCasing(text))
  val actionD: String = Rotating(DuplicateRemoval(text))
  val actionE: String = Reverting(Doubling(Shortening(NoSpacing(text))))
  val actionF: String = Rotating(Rotating(Rotating(Rotating(Rotating(text)))))
  val actionG: String = actionA

}
