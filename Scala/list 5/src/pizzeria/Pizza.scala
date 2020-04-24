package pizzeria

import pizzeria.extra._

case class Pizza(typee: PizzaType.PizzaType,
                 size: PizzaSize.PizzaSize,
                 crust: PizzaCrust.PizzaCrust,
                 extraMeat: Boolean,
                 extraTopping: Option[PizzaTopping.PizzaTopping]) {

  override def toString: String = {
    "Pizza " + typee + ", size: " + size + ", crust: " + crust + (if (extraMeat) {
                                                                    ", with extra meat"
                                                                  } else { "" }) +
      (if (extraTopping.isEmpty) { "" } else {
         ", with extra " + extraTopping.getOrElse("")
       })
  }

  val price: Double = {
    val type_price: Double = {
      typee match {
        case PizzaType.Margarita => 5
        case PizzaType.Pepperoni => 6.5
        case PizzaType.Funghi    => 7
      }
    }
    val size_price: Double = {
      size match {
        case PizzaSize.small   => 0.9
        case PizzaSize.regular => 1
        case PizzaSize.large   => 1.5
      }
    }
    //val meat_price: Double = if(extraMeat == None){0}else{1}
    val meat_price: Double = if (extraMeat) { 1 } else { 0 }
    val topping_price: Double = if (extraTopping.isEmpty) { 0 } else { 0.5 }

    (type_price + topping_price + meat_price) * size_price
  }

}
