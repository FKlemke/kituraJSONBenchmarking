import SwiftyJSON

#if os(Linux)
import SwiftGlibc
#else
import Darwin
#endif

struct JSONCreator {
    func generateJSON() -> [String: Int] {

        var rndJSON = [String: Int]()
        
        for i in 1...1000 {
            let randomNumber = Int(arc4random_uniform(UInt32(10)))
            rndJSON["Index \(i)"] = randomNumber
        }
        return rndJSON
    }
}
