import money._

object Main extends App{

  implicit val converter: CurrencyConverter = CurrencyConverter(Map (
    (USD, EUR) -> 0.907799, (EUR, USD) -> 1.10157, (EUR, PLN) -> 4.30062,
    (PLN, EUR) -> 0.232525, (PLN, USD) -> 0.256152, (USD, PLN) -> 3.90394))

  val sum1: Money = 100.01(USD) + 200(EUR)
  val sum2: Money = 100.01(PLN) + 200(USD)
  val sum3: Money = 5(PLN) + 3(PLN) + 20.5(USD)

  println(sum1)
  println(sum2)
  println(sum3)
  println("================")

  val sub: Money = 300.01(USD) - 200(EUR)

  println(sub)
  println("================")

  val mult1: Money = 30(PLN) * 20
  val mult2: Money = 20(USD) * 11

  println(mult1)
  println(mult2)
  println("================")

  val conv1: Money = 150.01(USD) as PLN
  val conv2: Money = 120.01(USD) as EUR

  println(conv1)
  println(conv2)
  println("================")

  val compare1: Boolean = 300.30(USD) > 200(EUR)
  val compare2: Boolean = 300.30(USD) < 200(EUR)

  println(compare1)
  println(compare2)
  println("================")

}
