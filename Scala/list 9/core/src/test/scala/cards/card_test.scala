package cards

class card_test extends org.scalatest.funsuite.AnyFunSuite {

  test("is_equal_test") {
    val card1 = new Card("Hearts", "6")
    val card2 = new Card("Hearts", "7")
    assert(card1.is_equal(card1))
    assert(!card1.is_equal(card2))
  }

}
