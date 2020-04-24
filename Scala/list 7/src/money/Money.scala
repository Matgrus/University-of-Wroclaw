package money


case class Money(amount: BigDecimal, currency: Currency)
                (implicit currencyConverter: CurrencyConverter) {

  def as(y: Currency): Money = Money(currencyConverter.convert(this, y), y)

  def +(y: Money): Money = Money(this.amount + y.as(this.currency).amount, this.currency)

  def -(y: Money): Money = Money(this.amount - y.as(this.currency).amount, this.currency)

  def *(y: BigDecimal): Money = Money(this.amount * y, this.currency)

  def >(y: Money): Boolean = this.amount > currencyConverter.convert(y, this.currency)

  def <(y: Money): Boolean = this.amount < currencyConverter.convert(y, this.currency)

  override def toString: String = this.amount.toString() + "(" + this.currency + ")"

}
