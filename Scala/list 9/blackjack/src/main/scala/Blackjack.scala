import cards.Card
import deck.Deck

class Blackjack(var deck: Deck) {

  def get_cards(): List[Card] = {
    deck.get_cards()
  }

  def points(x: Card): Int = {
    if (List("2", "3", "4", "5", "6", "7", "8", "9", "10").contains(
          x.get_value()
        )) {
      x.get_value().toInt
    } else if (List("Jack", "Queen", "King").contains(x.get_value())) {
      10
    } else {
      11
    }
  }

  def play(n: Int): Unit = {
    require(n <= deck.get_cards().length, "Too little cards in the deck")
    var sum = 0
    for (_ <- 0 until n) {
      val card = deck.get_cards()(0)
      if (card.get_value() == "Ace") {
        sum += 11
        //println(card + ": 11")  // scalafix
        println(card.toString + ": 11")
      } else {
        sum += this.points(card)
        //println(card + ": " + this.points(card)) // scalafix
        println(card.toString + ": " + this.points(card))
      }
      deck = deck.pull()
    }
    println("Sum of points: " + sum)
  }

  lazy val all21: List[List[Card]] = {

    def points_sum(ls: List[Card]): Int = {
      ls.map(x => this.points(x)).sum
    }

    (0 to deck.get_cards().length).iterator
      .flatMap(i => deck.get_cards().combinations(i))
      .filter(x => points_sum(x) == 21)
      .toList
  }

  def first21(): Unit = {
    if (all21.nonEmpty) {
      println(all21(0))
    } else {
      println("no subsequences with 21 points")
    }
  }

}
object Blackjack {
  def apply(numOfDecks: Int): Blackjack = {
    var res = Deck()
    for (_ <- 0 to numOfDecks - 2) {
      res = new Deck(res.get_cards() ::: Deck().get_cards())
    }
    new Blackjack(res)
  }

}
