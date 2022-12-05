import Foundation

public struct PartOne {
    
    public struct Rucksack {
        static let itemTypes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        public let compartmentOne: String
        public let compartmentTwo: String
        
        public init(_ input: String) {
            let halfway = input.count/2
            self.compartmentOne = String(input.prefix(halfway))
            self.compartmentTwo = String(input.suffix(halfway))
        }
        
        public func uniqueItem() -> Character {
            let intersection = Set(compartmentOne).intersection(Set(compartmentTwo))
            return intersection.first!
        }
        
        public static func itemTypePriority(_ itemType: Character) -> Int {
            let index = itemTypes.firstIndex(of: itemType)!
            let priority = itemTypes.distance(from: itemTypes.startIndex, to: index)
            return priority + 1
        }
    }
    
    static public func answer() -> Int {
        let file = Bundle.main.path(forResource: "input", ofType: "txt")!
        let fileContents = try! String(contentsOfFile: file)
        
        let rucksacks: [PartOne.Rucksack] = fileContents
                            .split(separator: "\n")
                            .compactMap { Rucksack(String($0)) }
        
        return rucksacks
            .map { PartOne.Rucksack.itemTypePriority($0.uniqueItem()) }
            .reduce(0, +)
    }
}
