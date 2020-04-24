package money


case class CurrencyConverter(conversion: Map[(Currency, Currency), BigDecimal]) {
  def convert(from: Money, to: Currency): BigDecimal = {
    if (from.currency == to){
      from.amount
    }else{
      from.amount * this.conversion((from.currency, to))
    }
  }

}
