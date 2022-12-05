import Foundation

public struct PartTwo {
    
    public struct Rucksack {
        static let itemTypes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        public let items: String
        
        public init(_ input: String) {
            self.items = input
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
        
        let allRucksacks: [PartTwo.Rucksack] = fileContents
                            .split(separator: "\n")
                            .compactMap { Rucksack(String($0)) }
        
        let elfGroups: [(PartTwo.Rucksack, PartTwo.Rucksack, PartTwo.Rucksack)] = stride(from: 0, to: allRucksacks.endIndex, by: 3).map { i in
            return (allRucksacks[i], allRucksacks[i+1], allRucksacks[i+2])
        }
        
        return elfGroups.map { group in
            let badge: Character = Set(group.0.items).intersection(Set(group.1.items)).intersection(Set(group.2.items)).first!
            return PartTwo.Rucksack.itemTypePriority(badge)
        }
        .reduce(0, +)
    }
}
