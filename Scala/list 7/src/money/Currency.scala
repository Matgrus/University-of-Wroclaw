package money


trait Currency

object USD extends Currency {
  override val toString: String = "USD"
}

object $ extends Currency {
  override val toString: String = "$"
}

object EUR extends Currency {
  override val toString: String = "EUR"
}

object ee extends Currency {
  override val toString: String = "ee"
}

object PLN extends Currency {
  override val toString: String = "PLN"
}

object zl extends Currency {
  override val toString: String = "zl"
}