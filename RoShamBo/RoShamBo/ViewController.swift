//
//  ViewController.swift
//  RoShamBo
//
//  Created by Ryan Arana on 3/25/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import UIKit

import RoShamBoKit

class ViewController: UIViewController {

    var playerChoice: Choice? {
        didSet {
            if let prev = oldValue {
                getButtonForChoice(prev).selected = false
            }

            if let val = playerChoice {
                getButtonForChoice(val).selected = true
            }
        }
    }

    @IBOutlet weak var winnerImage: UIImageView!
    @IBOutlet weak var loserImage: UIImageView!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var verbLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        verbLabel.text = ""
        for c in Choice.all() {
            let btn: UIButton = getButtonForChoice(c)
            btn.setImage(UIImage(named: "\(c.name)-highlighted"), forState: UIControlState.Highlighted)
            btn.setImage(UIImage(named: "\(c.name)-highlighted"), forState: UIControlState.Selected)
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playerButtonTapped(sender: UIButton) {
        playerChoice = Choice(rawValue: sender.tag)
        playGame()
    }

    func getButtonForChoice(choice: Choice) -> UIButton! {
        return view.viewWithTag(choice.rawValue) as UIButton!
    }

    func playGame() {
        let compChoice = Choice.random()

        var txt: String
        let r = Game(player1: playerChoice!, player2: compChoice).play()

        if r.draw {
            txt = "It's a draw. Try again!"

            winnerImage.image = UIImage(named: "\(compChoice.name)-highlighted")
            loserImage.image = UIImage(named: compChoice.name)
            verbLabel.text = "=="
        } else {
            let playerWon = r.winner == playerChoice!
            txt = playerWon ? "You win!" : "You lose!"

            var winnerImageName = r.winner.name
            var loserImageName = r.loser.name
            if playerWon {
                winnerImageName = "\(winnerImageName)-highlighted"
            } else {
                loserImageName = "\(loserImageName)-highlighted"
            }
            winnerImage.image = UIImage(named: winnerImageName)
            loserImage.image = UIImage(named: loserImageName)
            verbLabel.text = r.winner.verb(r.loser)
        }

        resultsLabel.text = txt
    }

}
