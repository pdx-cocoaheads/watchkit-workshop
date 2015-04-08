//
//  InterfaceController.swift
//  RoShamBo WatchKit Extension
//
//  Created by Ryan Arana on 3/29/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import WatchKit
import Foundation

import RoShamBoKit

class ResultWrapper {
    let result: Result
    let player: Choice

    init(_ result: Result, player: Choice) {
        self.result = result
        self.player = player
    }
}

class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func rockTapped() {
        play(.Rock)
    }
    @IBAction func paperTapped() {
        play(.Paper)
    }
    @IBAction func scissorsTapped() {
        play(.Scissors)
    }
    @IBAction func lizardTapped() {
        play(.Lizard)
    }
    @IBAction func spockTapped() {
        play(.Spock)
    }

    func play(c: Choice) {
        let r = Game(player1: c, player2: Choice.random()).play()

        presentControllerWithName("results", context: ResultWrapper(r, player: c))
    }
}
