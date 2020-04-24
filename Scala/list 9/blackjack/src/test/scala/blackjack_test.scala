import cards.Card
import deck.Deck

class blackjack_test extends org.scalatest.funsuite.AnyFunSuite {

  val test_deck1 = Deck()
  val test_game1 = Blackjack(1)
  val test_card1 = new Card("Clubs", "2")
  val test_card2 = new Card("Clubs", "8")
  val test_card3 = new Card("Clubs", "Ace")
  val test_card4 = new Card("Clubs", "King")
  val test_game2 = new Blackjack(
    new Deck(
      List(
        test_card1,
        test_card2,
        test_card3,
        test_card4
      )
    )
  )

  test("get_cards_test") {
    assert(new Deck(List()).get_cards() == List())
    assert(test_deck1.get_cards().length == 52)
  }

  test("points_test") {
    assert(test_game1.points(new Card("Hearts", "6")) == 6)
    assert(test_game1.points(new Card("Hearts", "King")) == 10)
    assert(test_game1.points(new Card("Hearts", "Ace")) == 11)
  }

  test("play_test") {
    val play_deck = new Blackjack(new Deck(test_game2.get_cards()))
    play_deck.play(2)
    assert(test_game2.get_cards().length == play_deck.get_cards().length + 2)
    assert(play_deck.get_cards() == List(test_card3, test_card4))
    play_deck.play(1)
    assert(play_deck.get_cards() == List(test_card4))
  }

  test("all21_test") {
    assert(
      test_game2.all21.toSet == List(
        List(
          test_card1,
          test_card2,
          test_card3
        ),
        List(test_card3, test_card4)
      ).toSet
    )
  }

}
