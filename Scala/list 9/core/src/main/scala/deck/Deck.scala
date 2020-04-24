package deck

import cards._
import scala.util.Random

class Deck(cards: List[Card]) {

  def get_cards(): List[Card] = {
    cards
  }

  def pull(): Deck = {
    require(this.get_cards().nonEmpty, "deck should have at least 1 element")
    if (this.get_cards().length == 1) {
      new Deck(List())
    } else {
      new Deck(cards.tail)
    }
  }

  def push(c: Card): Deck = {
    new Deck(c :: cards)
  }

  def push(color: String, value: String): Deck = {
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
    new Deck(new Card(color, value) :: cards)
  }

  val isStandard: Boolean = {
    this.get_cards().distinct.length == 52
  }

  def duplicatesOfCard(card: Card): Int = {
    cards.count(_.is_equal(card))
  }

  def amountOfColor(color: String): Int = {
    require(
      List("Diamonds", "Spades", "Hearts", "Clubs").contains(color),
      "wrong color"
    )
    cards.count(_.get_color() == color)
  }

  def amountOfNumerical(numerical: String): Int = {
    require(
      List("2", "3", "4", "5", "6", "7", "8", "9", "10").contains(numerical),
      "wrong numerical"
    )
    cards.count(_.get_value() == numerical)
  }

  val amountWithNumerical: Int = {
    cards.count(x =>
      List("2", "3", "4", "5", "6", "7", "8", "9", "10").contains(x.get_value())
    )
  }

  def amountOfFace(face: String): Int = {
    require(List("King", "Queen", "Jack").contains(face), "wrong face")
    cards.count(_.get_value() == face)
  }

  val amountWithFace: Int = {
    cards.count(x => List("Jack", "Queen", "King").contains(x.get_value()))
  }

}

object Deck {

  def apply(): Deck = {
    val colors = List("Diamonds", "Spades", "Hearts", "Clubs")
    val vals = List(
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "Jack",
      "Queen",
      "King",
      "Ace"
    )
    var res = new Deck(List())

    for (i <- 0 to 3; j <- 0 to 12) {
      res = res.push(new Card(colors(i), vals(j)))
    }

    new Deck(Random.shuffle(res.get_cards()))
  }
}
