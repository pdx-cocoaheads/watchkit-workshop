//
//  ViewController.swift
//  Rock Paper Scissors Lizard Spock
//
//  Created by Ryan Arana on 3/25/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import UIKit

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

    @IBOutlet weak var computerChoiceImage: UIImageView!
    @IBOutlet weak var resultsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

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
        computerChoiceImage.image = UIImage(named: "\(compChoice.name)-highlighted")

        var txt: String
        let r = Game(player1: playerChoice!, player2: compChoice).play()

        if r.draw {
            txt = "It's a draw. Try again!"
        } else {
            let winStatement = r.winner == playerChoice ? "You win!" : "You lose!"
            txt = "\(r.summary) \(winStatement)"
        }

        resultsLabel.text = txt
    }

}
