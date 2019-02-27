//
//  ViewController.swift
//  concentration
//
//  Created by sasithorn wu on 8/30/18.
//  Copyright © 2018 boblancer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func ResetUI(_ sender: Any) {
        reset_game()
    }
    
    var emojiChoices: [String] = []
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2, list: [emojiChoices] )
    let all_emoji = [["🐟", "🐳" , "🦈", "🐋", "🦀", "🐠"]
        ,["🍏", "🍎" , "🍉", "🥑", "🍓", "🍋"]
        ,["⚽️", "🏀" , "🏈", "⚾️", "🎾", "🏐"]
        ,["🇯🇵", "🇹🇭" , "🇺🇸", "🇻🇳", "🇨🇦", "🇹🇩"]
        ,["🍗", "🍖" , "🌭", "🍔", "🍟", "🍕"]
        ,["🍣", "🍤" , "🍙", "🍘", "🍥", "🍡"]]
    
    override func viewDidLoad() {
        emojiChoices = all_emoji[Int(arc4random_uniform(UInt32(all_emoji.count)))] + all_emoji[Int(arc4random_uniform(UInt32(all_emoji.count)))]
    }

    
   // game.flipCount{ didSet { flipCountLabel.text = "Flips: \(flipCount)"} }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.lastIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        
    }
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.2413560912, green: 0.4975744645, blue: 0.9468911917, alpha: 0) : #colorLiteral(red: 0.9809193336, green: 0.4699669618, blue: 0.1460537282, alpha: 1)
            }
        }
        flipCountLabel.text = "Flip: \(game.flipCount)"
    }
    
    func reset_game(){
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2, list: [emojiChoices] )
        for button in cardButtons{
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9809193336, green: 0.4699669618, blue: 0.1460537282, alpha: 1)
            flipCountLabel.text = "Flip:"
        }
        emojiChoices = all_emoji[Int(arc4random_uniform(UInt32(all_emoji.count)))] + all_emoji[Int(arc4random_uniform(UInt32(all_emoji.count)))]
    }
    var emoji = [Int:String]()
    
    func emoji(for card: Card)-> String{
        if emoji[card.identifier] == nil{
            if emojiChoices.count > 0{
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

