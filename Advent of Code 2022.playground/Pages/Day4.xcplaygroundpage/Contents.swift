//: [Previous](@previous)
import Foundation

let file = Bundle.main.path(forResource: "input", ofType: "txt")!
let fileContents = try! String(contentsOfFile: file)

let allNumbers = fileContents
                            .components(separatedBy: CharacterSet(charactersIn: "-,\n"))
                            .filter { !$0.isEmpty }
                            .compactMap { Int($0) }

var partOneCount = 0
var partTwoCount = 0

for i in stride(from: 0, to: allNumbers.endIndex, by: 4) {
    let range1 = Set(allNumbers[i]...allNumbers[i+1])
    let range2 = Set(allNumbers[i+2]...allNumbers[i+3])
    
    
    if range1.isSubset(of: range2) || range1.isSuperset(of: range2) {
        partOneCount += 1
    }
    
    if range1.intersection(range2).count > 0 {
        partTwoCount += 1
    }
}

// Part 1
print(partOneCount)
print(partTwoCount)



//: [Next](@next)
