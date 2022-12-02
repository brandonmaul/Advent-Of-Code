import Foundation

public struct PartTwo {
    enum Hand: String {
        case rock = "A"
        case paper = "B"
        case scissors = "C"
        
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

    enum MatchResult: String {
        case win = "Z"
        case lose = "X"
        case tie = "Y"
        
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
        
        func determinePlay(against hand: Hand) -> Hand {
            switch (self, hand) {
            case (.win, .rock):
                return .paper
            case (.lose, .rock):
                return .scissors
            case (.win, .paper):
                return .scissors
            case (.lose, .paper):
                return .rock
            case (.win, .scissors):
                return .rock
            case (.lose, .scissors):
                return .paper
            case (.tie, _):
                    return hand
            }
        }
    }

    public static func answer() -> Int {
        let file = Bundle.main.path(forResource: "input", ofType: "txt")!
        let fileContents = try! String(contentsOfFile: file)
        let matchStrings: [[String]] = fileContents
                                        .split(separator: "\n")
                                        .map { round in
                                            round
                                                .split(separator: " ")
                                                .compactMap { String($0) }
                                        }
        
        var matchScores: [Int] = []
        for match in matchStrings {
            let opponentHand = Hand(rawValue: String(match.first!))!
            let matchResult = MatchResult(rawValue: String(match.last!))!
            let handToPlay = matchResult.determinePlay(against: opponentHand)
            matchScores.append(matchResult.matchValue + handToPlay.scoreValue)
        }

        return matchScores.reduce(0, +)
    }
}

