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
    case Lizard
    case Spock

    var name: String {
        switch self {
        case Rock:
            return "rock"
        case Paper:
            return "paper"
        case Scissors:
            return "scissors"
        case Lizard:
            return "lizard"
        case Spock:
            return "spock"
        }
    }

    static func all() -> [Choice] {
        return [.Rock, .Paper, .Scissors, .Lizard, .Spock]
    }

    static func random() -> Choice {
        var c = Int(arc4random_uniform(UInt32(5))) + 1
        return Choice(rawValue: c)!
    }

    func versus(other: Choice) -> Result {
        return Result(choices: self, second: other)
    }
}

struct Result {
    let winner: Choice!
    let loser: Choice!
    let verb: String!
    let draw: Bool = false

    init(winner: Choice, loser: Choice, verb: String) {
        self.winner = winner
        self.loser = loser
        self.verb = verb
    }

    init(choices first: Choice, second: Choice) {
        let win = { (verb: String) -> Result in
            return Result(winner: first, loser: second, verb: verb)
        }
        let lose = { () -> Result in
            let reversed = Result(choices: second, second: first)
            return Result(winner: second, loser: first, verb: reversed.verb)
        }

        draw = first == second

        if !draw {
            var r: Result
            
            switch first {
            case .Rock:
                switch second {
                case .Scissors, .Lizard:
                    r = win("crushes")
                default:
                    r = lose()
                }
            case .Paper:
                switch second {
                case .Spock:
                    r = win("disproves")
                case .Rock:
                    r = win("covers")
                default:
                    r = lose()
                }
            case .Scissors:
                switch second {
                case .Paper:
                    r = win("cuts")
                case .Lizard:
                    r = win("decapitates")
                default:
                    r = lose()
                }
            case .Lizard:
                switch second {
                case .Paper:
                    r = win("eats")
                case .Spock:
                    r = win("poisons")
                default:
                    r = lose()
                }
            case .Spock:
                switch second {
                case .Rock, .Scissors:
                    r = win("vaporizes")
                default:
                    r = lose()
                }
            }
            
            winner = r.winner
            loser = r.loser
            verb = r.verb
        }
    }

    var summary: String {
        return "\(winner.name.capitalizedString) \(verb) \(loser.name.capitalizedString)."
    }
}