package deck
import cards.Card

class deck_test extends org.scalatest.funsuite.AnyFunSuite {
  val test_deck1 = new Deck(List())
  val test_deck2 = Deck()
  val test_card1 = new Card("Spades", "10")

  test("get_cards_test") {
    assert(test_deck1.get_cards() == List())
    assert(test_deck2.get_cards().length == 52)
  }

  test("pull_test") {
    val pulled_card = test_deck2.get_cards().head
    assert(
      test_deck2.pull().get_cards().length == test_deck2.get_cards().length - 1
    )
    assert(!test_deck2.pull().get_cards().contains(pulled_card))
    assert(
      new Deck(List(pulled_card)).pull().get_cards().isEmpty
    )
  }

  test("push_card_test") {
    assert(test_deck1.push(test_card1).get_cards().contains(test_card1))
    assert(
      test_deck2
        .push(test_card1)
        .get_cards()
        .count(_.is_equal(test_card1)) == test_deck2
        .get_cards()
        .count(_.is_equal(test_card1)) + 1
    )
  }

  test("push_colandval_test") {
    assert(
      test_deck1
        .push("Spades", "Ace")
        .get_cards()
        .count(x => x.get_color() == "Spades" && x.get_value() == "Ace") == 1
    )
    assert(
      test_deck2
        .push("Spades", "Ace")
        .get_cards()
        .count(_.is_equal(new Card("Spades", "Ace"))) == test_deck2
        .get_cards()
        .count(_.is_equal(new Card("Spades", "Ace"))) + 1
    )
  }

  test("duplicatesOfCard_test") {
    assert(test_deck1.duplicatesOfCard(test_card1) == 0)
    assert(test_deck2.duplicatesOfCard(test_card1) == 1)
  }

  test("isStandard_test") {
    assert(!test_deck1.isStandard)
    assert(test_deck2.isStandard)
  }

  test("amountOfColor_test") {
    assert(test_deck1.amountOfColor("Hearts") == 0)
    assert(test_deck2.amountOfColor("Hearts") == 13)
  }

  test("amountOfNumerical_test") {
    assert(test_deck1.amountOfNumerical("10") == 0)
    assert(test_deck2.amountOfNumerical("10") == 4)
  }

  test("amountWithNumerical_test") {
    assert(test_deck1.amountWithNumerical == 0)
    assert(test_deck2.amountWithNumerical == 36)
  }

  test("amountOfFace_test") {
    assert(test_deck1.amountOfFace("King") == 0)
    assert(test_deck2.amountOfFace("King") == 4)
  }

  test("amountWithFace_test") {
    assert(test_deck1.amountWithFace == 0)
    assert(test_deck2.amountWithFace == 12)
  }

}
