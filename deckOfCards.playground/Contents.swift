import UIKit

struct Card {
  var suit: String
  var value: String
}

class Deck {
  var cards = [Card]()
  init() {
    self.reset()
  }
  func deal() -> Card{
    return (self.cards.remove(at: self.cards.count-1))
  }
  func reset() {
    let values = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
    let suits = ["Clubs","Spades","Hearts","Diamonds"]
    for suit in suits {
      for val in values {
        self.cards.append(Card(suit: suit, value: val))
      }
    }
  }
  func shuffle() {
    for i in 0..<self.cards.count {
      var random = Int(arc4random_uniform(UInt32(self.cards.count)))
      while i == random {
        random = Int(arc4random_uniform(UInt32(self.cards.count)))
      }
      swap(&self.cards[i], &self.cards[random])
    }
  }
}

class Player {
  var name: String
  var hand = [Card]()
  init(name: String) {
    self.name = name
  }
  func draw(deck: Deck) -> Card {
    let card = deck.deal()
    self.hand.append(card)
    return card
  }
  func discard(suit: String, value: String) -> Bool {
    for i in 0..<self.hand.count {
      if (self.hand[i].suit == suit && self.hand[i].value == value) {
        self.hand.remove(at: i)
        return true
      }
    }
    return false
  }
}

let d1 = Deck()
let p1 = Player(name: "Erick")
p1.draw(deck: d1)
p1.draw(deck: d1)
p1.draw(deck: d1)
print(p1.hand)

p1.discard(suit: "Diamonds", value: "K")
print(p1.hand)