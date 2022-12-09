//: [Previous](@previous)

import Foundation

let file = Bundle.main.path(forResource: "input", ofType: "txt")!
let fileContents = try! String(contentsOfFile: file)


func findRepeatedCharacterIndex(in str: String, withSubstringRangeOf i: Int) -> Int {
    var index = i
    while index < str.count {
        let start = str.index(str.startIndex, offsetBy: index-i)
        let end = str.index(str.startIndex, offsetBy: index)
        let scan = str[start..<end]
        
        if Set(scan).count == i {
            return index
        }
        
        index += 1
    }
    
    return -1
}

print(findRepeatedCharacterIndex(in: fileContents, withSubstringRangeOf: 4))
print(findRepeatedCharacterIndex(in: fileContents, withSubstringRangeOf: 14))

//: [Next](@next)
