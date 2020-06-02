package pizzeria.orders

import pizzeria.Pizza
import pizzeria.extra.PizzaDiscount
import pizzeria.extra.PizzaType.PizzaType

class Order(name: String,
            address: String,
            phone: String,
            pizzas: List[Pizza],
            drinks: Int,
            discount: Option[PizzaDiscount.PizzaDiscount],
            specialInfo: Option[String]) {
  require(phone.matches("""\d{9}"""), "invalid phone number format")

  override def toString: String = {
    "Customer: " + name + ", address: " + address + ", phone: " + phone + ", pizzas: " +
      pizzas.map(x => x.size + " " + x.typee).mkString(", ") + ", drinks: " +
      drinks + (if (discount.isEmpty) { "" } else {
                  ", discount: " + discount.getOrElse("")
                }) +
      (if (specialInfo.isEmpty) { "" } else {
         ", special info: " + specialInfo.getOrElse("")
       })
  }

  def extraMeatPrice: Option[Double] = {
    val x = pizzas.count(_.extraMeat == true).toDouble
    if (x == 0) {
      None
    } else {
      Some(x)
    }
  }

  def pizzasPrice: Option[Double] = {
    if (pizzas.isEmpty) {
      None
    } else {
      Some(pizzas.map(_.price).sum)
    }
  }

  def drinksPrice: Option[Double] = {
    if (drinks == 0) {
      None
    } else {
      Some(drinks * 2)
    }
  }

  def priceByType(typee: PizzaType): Option[Double] = {
    val x = pizzas.filter(_.typee == typee).map(x => x.price)
    if (x.isEmpty) {
      None
    } else {
      Some(x.sum)
    }
  }

  val price: Double = {
    discount match {
      case PizzaDiscount.student =>
        (extraMeatPrice.getOrElse(0.0) + pizzasPrice.getOrElse(0.0)) * 0.95 + drinksPrice
          .getOrElse(0.0)
      case PizzaDiscount.senior =>
        (extraMeatPrice.getOrElse(0.0) + pizzasPrice.getOrElse(0.0) + drinksPrice
          .getOrElse(0.0)) * 0.93
      case _ =>
        extraMeatPrice.getOrElse(0.0) + pizzasPrice.getOrElse(0.0) + drinksPrice
          .getOrElse(0.0)
    }
  }
}
