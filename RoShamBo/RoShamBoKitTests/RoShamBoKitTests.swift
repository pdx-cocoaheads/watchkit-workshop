//
//  RoShamBoKitTests.swift
//  RoShamBoKitTests
//
//  Created by Ryan Arana on 3/29/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import UIKit
import XCTest

import RoShamBoKit

class RoShamBoKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test__game_with_same_choices_should_be_a_draw() {
        let r = Game(player1: .Rock, player2: .Rock).play()
        XCTAssert(r.draw, "Rock vs Rock should be a draw")
    }
    
    func test__game_with_different_choices_should_not_be_a_draw() {
        let r = Game(player1: .Rock, player2: .Paper).play()
        XCTAssert(!r.draw, "Rock vs Paper should not be a draw")
    }
    
    var choiceUnderTest: Choice = .Rock
    func vs (c: Choice) -> Result {
        return Game(player1: choiceUnderTest, player2: c).play()
    }
    
    func test__rock_should_interact_with_other_choices_correctly() {
        choiceUnderTest = .Rock
        
        XCTAssert(vs(.Paper).winner != .Rock, "Rock should lose to Paper")
        XCTAssert(vs(.Spock).winner != .Rock, "Rock should lose to Spock")
        XCTAssert(vs(.Scissors).winner == .Rock, "Rock should defeat Scissors")
        XCTAssert(vs(.Lizard).winner == .Rock, "Rock should defeat Lizard")
    }
    
    func test__paper_should_interact_with_other_choices_correctly() {
        choiceUnderTest = .Paper
        
        XCTAssert(vs(.Scissors).winner != .Paper, "Paper should lose to Scissors")
        XCTAssert(vs(.Lizard).winner != .Paper, "Paper should lose to Lizard")
        XCTAssert(vs(.Rock).winner == .Paper, "Paper should defeat Rock")
        XCTAssert(vs(.Spock).winner == .Paper, "Paper should defeat Spock")
    }
    
    func test__scissors_should_interact_with_other_choices_correctly() {
        choiceUnderTest = .Scissors
        
        XCTAssert(vs(.Rock).winner != .Scissors, "Scissors should lose to Rock")
        XCTAssert(vs(.Spock).winner != .Scissors, "Scissors should lose to Spock")
        XCTAssert(vs(.Paper).winner == .Scissors, "Scissors should defeat Paper")
        XCTAssert(vs(.Lizard).winner == .Scissors, "Scissors should defeat Lizard")
    }
    
    func test__lizard_should_interact_with_other_choices_correctly() {
        choiceUnderTest = .Lizard
        
        XCTAssert(vs(.Rock).winner != .Lizard, "Lizard should lose to Rock")
        XCTAssert(vs(.Scissors).winner != .Lizard, "Lizard should lose to Scissors")
        XCTAssert(vs(.Paper).winner == .Lizard, "Lizard should defeat Paper")
        XCTAssert(vs(.Spock).winner == .Lizard, "Lizard should defeat Spock")
    }
    
    func test__spock_should_interact_with_other_choices_correctly() {
        choiceUnderTest = .Spock
        
        XCTAssert(vs(.Paper).winner != .Spock, "Spock should lose to Paper")
        XCTAssert(vs(.Lizard).winner != .Spock, "Spock should lose to Lizard")
        XCTAssert(vs(.Scissors).winner == .Spock, "Spock should defeat Scissors")
        XCTAssert(vs(.Rock).winner == .Spock, "Spock should defeat Rock")
    }

}
