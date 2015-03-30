//
//  ResultsController.swift
//  RoShamBo
//
//  Created by Ryan Arana on 3/29/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import Foundation
import WatchKit

import RoShamBoKit

class ResultsController: WKInterfaceController {
    @IBOutlet weak var winnerImage: WKInterfaceImage!
    @IBOutlet weak var winnerLabel: WKInterfaceLabel!

    @IBOutlet weak var verbLabel: WKInterfaceLabel!

    @IBOutlet weak var loserLabel: WKInterfaceLabel!
    @IBOutlet weak var loserImage: WKInterfaceImage!

    @IBOutlet weak var summaryLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        if let rw = context as? ResultWrapper {
            let r = rw.result
            if r.draw {
                winnerImage.setImageNamed(rw.player.name)
                winnerLabel.setText(rw.player.name.capitalizedString)

                verbLabel.setText("==")

                loserImage.setImageNamed(rw.player.name)
                loserLabel.setText(rw.player.name)

                summaryLabel.setText("It's a Draw!")
            } else {
                let playerWon = r.winner == rw.player
                let winnerImageName = playerWon ? "\(r.winner.name)-highlighted" : r.winner.name
                let loserImageName = playerWon ? r.loser.name : "\(r.loser.name)-highlighted"
                winnerImage.setImageNamed(winnerImageName)
                winnerLabel.setText(r.winner.name.capitalizedString)

                verbLabel.setText(r.winner.verb(r.loser))

                loserImage.setImageNamed(loserImageName)
                loserLabel.setText(r.loser.name.capitalizedString)

                summaryLabel.setText(playerWon ? "You win!" : "You lose!")
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}