import Utils._

final case class MyException(private val message: String) extends Exception

object Main extends App{

  // issorted, isascsorted and isdescsorted
  println("=============")

  val result = isSorted(List(1, 2, 3, 4, 5), (x: Int, y: Int) => x <= y)
  println(result)
  println(isAscSorted(List(1, 2, 3, 4, 5)))
  println(isDescSorted(List(1, 2, 3, 4, 5)))

  // fold, sum and length
  println("=============")

  val ls = List(1,2,3,4)
  val res1 = length(ls)
  val res2 = sum(ls)
  println(res1)
  println(res2)

  // repeated
  println("=============")

  def inc(x: Int) = x + 1

  def square(x: Int):Int = x * x

  val ff = repeated(inc, 3)
  val res3 = inc(2)
  println(res3)
  val res4 = ff(2)
  println(res4)

  // compose
  println("=============")

  val ff2 = compose(inc, square)
  val ff3 = compose(square, inc)

  println(ff2(3))
  println(ff3(3))

  // curry and uncurry
  println("============")

  def add(a: Int, b: Int) = a + b

  val ff4 = curry(add)
  println(ff4(3)(4))

  val ff5 = uncurry(ff4)
  println(ff5(3, 4))

  // unsafe

  unSafe(MyException("Could not run command")){
    if( 2 / 0 == 2){
      println("ok")
    }else{
      println("not ok")
    }
  }

}
