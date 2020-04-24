package cards

class Card(color: String, value: String) {
  require(
    List(
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "King",
      "Queen",
      "Ace",
      "Jack"
    ).contains(value) &&
      List("Diamonds", "Spades", "Hearts", "Clubs").contains(color),
    "card error"
  )

  override def toString: String =
    s"[$color, $value]"

  def is_equal(card: Card): Boolean = {
    this.get_color() == card.get_color() && this.get_value() == card.get_value()
  }

  def get_color(): String = {
    color
  }

  def get_value(): String = {
    value
  }
}
