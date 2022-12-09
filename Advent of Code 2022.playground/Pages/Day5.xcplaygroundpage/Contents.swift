//: [Previous](@previous)

import Foundation
import RegexBuilder

extension String {
    subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }

    subscript (range: Range<Int>) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
        return self[startIndex..<stopIndex]
    }

}

let file = Bundle.main.path(forResource: "input", ofType: "txt")!
let fileContents = try! String(contentsOfFile: file)

let stages = fileContents.split(separator: "\n\n")

// MARK:- Step 1: Parse the inital state of the stacks
var setup = String(stages[0]).components(separatedBy: "\n")

var stackArray = Array.init(repeating: [String](), count: 9)

for line in setup {
    let hasLetterRegex = Regex {
        Capture {
            One("A"..."Z")
        }
    }
    
    var currColumn = 0
    var currIndex = 0
    
    while currIndex < line.count {
        let endIndex = min(currIndex+4,currIndex + (line.count-currIndex))
        let scan = line[currIndex..<endIndex]
        if let (_, letter) = try? hasLetterRegex.firstMatch(in: scan)?.output {
            stackArray[currColumn].append(String(letter))
        }
        
        currIndex+=4
        currColumn+=1
    }
}

stackArray = stackArray.map { column in
    column.reversed()
}

for column in stackArray {
    print(column)
}

// MARK:- Step 2: Follow the instructions
let instructions = String(stages[1]).components(separatedBy: "\n")

let instructionRegex = Regex {
    "move "
    TryCapture {
        OneOrMore(.digit)
    } transform: { move in
        Int(move)
    }
    " from "
    TryCapture {
        OneOrMore(.digit)
    } transform: { from in
        Int(Int(from)! - 1)
    }
    " to "
    TryCapture {
        OneOrMore(.digit)
    } transform: { to in
        Int(Int(to)! - 1)
    }
}

var part1Stack = stackArray
for line in instructions {
    if let (_, move, from, to) = try? instructionRegex.firstMatch(in: line)?.output {
        for _ in 1...move {
            let item = part1Stack[from].popLast()!
            part1Stack[to].append(item)
        }
    }
}

print("\nPart One ----------------------")

var part1: String = ""
for column in part1Stack {
    print(column)
    part1.append(column.last!)
}

print("Part1 Answer: \(part1)")

print("\nPart Two ----------------------")

var part2Stack = stackArray
for line in instructions {
    if let (_, move, from, to) = try? instructionRegex.firstMatch(in: line)?.output {
        part2Stack[to].append(contentsOf: part2Stack[from].suffix(move))
        part2Stack[from].removeLast(move)
    }
}


var part2: String = ""
for column in part2Stack {
    print(column)
    part2.append(column.last!)
}

print("Part2 Answer: \(part2)")
//: [Next](@next)
