import pizzeria.Pizza
import pizzeria.extra._, PizzaType._, PizzaSize._, PizzaCrust._, PizzaTopping._, PizzaDiscount._
import pizzeria.orders.Order


object Main extends App{

  val pizza1 = Pizza(Margarita, large, thick, extraMeat = true, Some(ketchup))
  val pizza2 = Pizza(Margarita, small, thin, extraMeat = false, Some(garlic))
  val pizza3 = Pizza(Funghi, regular, thick, extraMeat = true, None)
  val pizza4 = Pizza(Pepperoni, large, thick, extraMeat = true, Some(ketchup))

  //println(pizza1)
  //println(pizza2)
  //println(pizza3)
  //println(pizza4)

  val order1 = new Order("Matthew", "Wroclaw", "123456789", List(pizza1, pizza2, pizza3, pizza4),
  4, Some(student), Some("Ring doesnt work, please knock"))


  println(order1.drinksPrice)
  println(order1.extraMeatPrice)
  println(order1.priceByType(Margarita))
  println(order1.priceByType(Funghi))
  println(order1.priceByType(Pepperoni))
  println(order1.pizzasPrice)
  println(order1.price)

  println(order1)

}
