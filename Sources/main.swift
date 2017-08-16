import Kitura
import SwiftyJSON


#if os(Linux)
    import SwiftGlibc
#else
    import Darwin
#endif

// Create a new router
let router = Router()

func getJSON() -> [String: Int] {
    var rndJSON = [String: Int]()
    for i in 1...1000 {
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        rndJSON["Index \(i)"] = randomNumber
    }
    return rndJSON
}


// Handle HTTP GET requests to /
router.get("/") {
    request, response, next in
    response.send("Kitura / Benchmarking")
    next()
}

router.get("/json") { _, response, next in
    let json = JSON(getJSON())
    try response.send(json: json).end()
}



// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8080, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
