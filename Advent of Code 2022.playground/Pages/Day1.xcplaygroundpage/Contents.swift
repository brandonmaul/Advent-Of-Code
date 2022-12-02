//: [Previous](@previous)

import Foundation

let filePath = Bundle.main.path(forResource:"day1-input", ofType: "txt")!
let fileContents = try! String(contentsOfFile: filePath, encoding: .utf8)


var sortedFoodWeights = fileContents
    .split(separator: "\n\n")       // Split up by double newlines
    .map { elfFoods in              // For each collection of elf foods...
        elfFoods                    //
            .split(separator: "\n")     // Break up the string
            .map { Int($0)! }           // Convert to an Int
            .reduce(0, +)               // And add them up
    }
    .sorted()

print(sortedFoodWeights.last!)                      // Return the most weight
print(sortedFoodWeights.suffix(3).reduce(0, +))     // Return sum of the highest 3 weights

//: [Next](@next)
