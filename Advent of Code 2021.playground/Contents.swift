import Foundation

// Setup

struct DepthReadings: Decodable {
    var readings: [Int]
}

func loadJson() -> DepthReadings? {
    if let url = Bundle.main.url(forResource: "input", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(DepthReadings.self, from: data)
            
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

var input = loadJson()

// Part 1

func calculateIncreases(readings: [Int]) -> Int {
    var retVal = 0
    
    var prevReading = 0
    
    for r in readings {
        if readings.first! != r {
            if r > prevReading {
                retVal += 1
            }
        }
        
        prevReading = r
    }
    
    return retVal
}

calculateIncreases(readings: input!.readings)

// Part 2

func calculateIncreasesWithSums(readings: [Int]) -> Int {
    var retVal = 0

    var prevReading = 0
    
    for r in readings {
        if readings.first! != r {
            if r > prevReading {
                retVal += 1
            }
        }
        
        prevReading = r
    }
    
    return retVal
}
