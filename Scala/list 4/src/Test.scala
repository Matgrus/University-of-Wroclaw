import cards.Card
import deck.Deck
import games.Blackjack

object Test extends App {

  val card1 = new Card("Hearts", "Queen")
  val card2 = new Card("Hearts", "King")
  val card3 = new Card("Hearts", "Ace")

  val card4 = new Card("Clubs", "10")
  val card5 = new Card("Diamonds", "6")

  var deck1 = new Deck(List(card1, card2, card3))

  println("Cards: ")
  println(deck1.get_cards())

  println("Pull: ")
  deck1 = deck1.pull()
  println(deck1.get_cards())

  println("Push " + card2 + ":")
  deck1 = deck1.push(card2)
  println(deck1.get_cards())

  println("Push queen of spades: " )
  deck1 = deck1.push("Spades", "Queen")
  println(deck1.get_cards())

  println("Duplicates of " + card2 + ":")
  println(deck1.duplicatesOfCard(card2))

  println("Hearts: ")
  println(deck1.amountOfColor("Hearts"))

  println("Numerical (10): ")
  println(deck1.amountOfNumerical("10"))

  println("All numerical cards: ")
  println(deck1.amountWithNumerical)

  println("Amount of kings: ")
  println(deck1.amountOfFace("King"))

  println("Amount of all face cards: ")
  println(deck1.amountWithFace)

  println("Push " + card4 + " and " + card5)
  deck1 = deck1.push(card4)
  deck1 = deck1.push(card5)

  println(deck1.get_cards())

  println("Numerical (10): ")
  println(deck1.amountOfNumerical("10"))

  println("All numerical cards: ")
  println(deck1.amountWithNumerical)

  println("===================")

  println("Standard deck: ")
  val good_deck = Deck()

  println(good_deck.get_cards())

  println(good_deck.get_cards().length)

  println(good_deck.isStandard)

  println("===================")

  println("Blackjack with 1 deck: ")
  val game = Blackjack(1)
  println(game.get_cards().length)
  println(game.get_cards())

  println("Take 4 cards: ")
  game.play(4)

  println(game.get_cards())
  println(game.get_cards().length)

  println("===================")

/*
  game.play(36)
  println(game.get_cards())
  println(game.all21)
  game.first21()
*/

}
