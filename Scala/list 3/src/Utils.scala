object Utils {

  def isSorted(as: List[Int], ordering: (Int, Int) => Boolean): Boolean = {
    @scala.annotation.tailrec
    def loop(n: Int, acc: Boolean): Boolean = {
      if (n + 1 >= as.length)
        acc
      else
        loop(n + 1, acc && ordering(as(n), as(n + 1)))
    }
    loop(0, true)
  }

  def isAscSorted(as: List[Int]): Boolean = {
    isSorted(as, (x: Int, y: Int) => x <= y)
  }

  def isDescSorted(as: List[Int]): Boolean = {
    isSorted(as, (x: Int, y: Int) => x >= y)
  }

  @scala.annotation.tailrec
  def foldLeft[A, B](l: List[A], z: B)(f: (B, A) => B): B = {
    l match {
      case Nil    => z
      case x :: y => foldLeft(y, f(z, x))(f)
    }
  }

  def sum(l: List[Int]): Int = {
    foldLeft(l, 0)((x, y) => x + y)
  }

  def length[A](l: List[A]): Int = {
    foldLeft(l, 0)((x, _) => x + 1)
  }

  def compose[A, B, C](f: B => C, g: A => B): A => C = { a: A =>
    f(g(a))
  }

  def repeated[A, B](f: A => A, n: Int): A => A = {
    /*
    var res: A => A = f
    for ( i<- 1 to n){
      res = compose(f, res)
    }
    res
     */

    @scala.annotation.tailrec
    def help(f: A => A, acc: A => A, n: Int): A => A = {
      if (n <= 0) {
        acc
      } else {
        help(f, compose(f, acc), n - 1)
      }
    }

    help(f, f, n)
  }

  def curry[A, B, C](f: (A, B) => C): A => B => C = { a: A => (b: B) =>
    f(a, b)
  }

  def uncurry[A, B, C](f: A => B => C): (A, B) => C = { (a: A, b: B) =>
    f(a)(b)
  }

  def unSafe[T](ex: Exception)(code: => T): T = {
    try {
      code
    } catch {
      case x: Throwable => println(x); throw ex
    }
  }

}
