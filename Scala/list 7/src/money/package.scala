package object money {

  implicit class BigDecimals(val value: BigDecimal){
    def apply(currency: Currency)(implicit converter: CurrencyConverter): Money = Money(value, currency)
  }

  implicit class Doubles(val value: Double){
    def apply(currency: Currency)(implicit converter: CurrencyConverter): Money = Money(value, currency)
  }

  implicit class Ints(val value: Int){
    def apply(currency: Currency)(implicit converter: CurrencyConverter): Money = Money(value, currency)
  }

}
