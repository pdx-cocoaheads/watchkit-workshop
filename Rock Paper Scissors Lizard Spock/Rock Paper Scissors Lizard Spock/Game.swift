//
//  Choice.swift
//  Rock Paper Scissors Lizard Spock
//
//  Created by Ryan Arana on 3/26/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import Foundation

enum Choice: Int {
    case Rock = 1
    case Paper
    case Scissors
    case Spock
    case Lizard

    var name: String {
        switch self {
        case .Rock:
            return "rock"
        case .Paper:
            return "paper"
        case .Scissors:
            return "scissors"
        case .Spock:
            return "spock"
        case .Lizard:
            return "lizard"
        }
    }

    static func all() -> [Choice] {
        return [.Rock, .Paper, .Scissors, .Spock, .Lizard]
    }

    static func random() -> Choice {
        var c = Int(arc4random_uniform(UInt32(5))) + 1
        return Choice(rawValue: c)!
    }

    func verb(other: Choice) -> String {
        if other == self {
            return ""
        }

        switch self {
        case .Rock:
            switch other {
            case .Scissors, .Lizard:
                return "crushes"
            default:
                return other.verb(self)
            }
        case .Paper:
            switch other {
            case .Spock:
                return "disproves"
            case .Rock:
                return "covers"
            default:
                return other.verb(self)
            }
        case .Scissors:
            switch other {
            case .Paper:
                return "cuts"
            case .Lizard:
                return "decapitates"
            default:
                return other.verb(self)
            }
        case .Spock:
            switch other {
            case .Rock, .Scissors:
                return "vaporizes"
            default:
                return other.verb(self)
            }
        case .Lizard:
            switch other {
            case .Paper:
                return "eats"
            case .Spock:
                return "poisons"
            default:
                return other.verb(self)
            }
        }
    }
}

struct Result {
    let winner: Choice!
    let loser: Choice!
    let draw: Bool = false

    init(choices p1: Choice, p2: Choice) {
        draw = p1 == p2

        if !draw {
            let higher = p1.rawValue > p2.rawValue ? p1 : p2
            let lower = higher == p1 ? p2 : p1

            if p1.rawValue % 2 == p2.rawValue % 2 {
                // If both are odd or both are even, the lower one wins
                winner = lower
                loser = higher
            } else {
                // Otherwise the higher one wins
                winner = higher
                loser = lower
            }
        }
    }

    var summary: String {
        return "\(winner.name.capitalizedString) \(winner.verb(loser)) \(loser.name.capitalizedString)."
    }
}

struct Game {
    let player1: Choice
    let player2: Choice

    init(player1: Choice, player2: Choice) {
        self.player1 = player1
        self.player2 = player2
    }

    func play() -> Result {
        return Result(choices: player1, p2: player2)
    }
}