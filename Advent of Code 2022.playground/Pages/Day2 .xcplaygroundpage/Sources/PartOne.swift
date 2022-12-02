import Foundation

public struct PartOne {
    enum Hand {
        case rock
        case paper
        case scissors
        
        init?(rawValue: String) {
            switch rawValue {
            case "A", "X":
                self = .rock
            case "B", "Y":
                self = .paper
            case "C", "Z":
                self = .scissors
            default:
                return nil
            }
        }
        
        func match(against opponent: Hand) -> MatchResult {
            switch (opponent, self) {
            case (.rock, .paper):
                return .win
            case (.rock, .scissors):
                return .lose
            case (.paper, .rock):
                return .lose
            case (.paper, .scissors):
                return .win
            case (.scissors, .rock):
                return .win
            case (.scissors, .paper):
                return .lose
            default:
                return .tie
            }
        }
        
        var scoreValue: Int {
            switch self {
            case .rock:
                return 1
            case .paper:
                return 2
            case .scissors:
                return 3
            }
        }
    }

    enum MatchResult {
        case win
        case lose
        case tie
        
        var matchValue: Int {
            switch self {
            case .win:
                return 6
            case .lose:
                return 0
            case .tie:
                return 3
            }
        }
    }
    
    public static func answer() -> Int {
        let file = Bundle.main.path(forResource: "input", ofType: "txt")!
        let fileContents = try! String(contentsOfFile: file)
        let matches: [[Hand]] = fileContents
                                        .split(separator: "\n")
                                        .map { round in
                                            round
                                                .split(separator: " ")
                                                .compactMap { handStr in
                                                    Hand(rawValue: String(handStr))
                                                }
                                        }
        let matchScores = matches
            .map { hands in
                let opponentHand: Hand = hands.first!
                let playerHand: Hand = hands.last!
                let matchScore = playerHand.match(against: opponentHand).matchValue
                return matchScore + playerHand.scoreValue
            }

        return matchScores.reduce(0, +)
    }
}

