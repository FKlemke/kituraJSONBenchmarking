import Kitura
import SwiftyJSON
import KituraMustache


#if os(Linux)
    import SwiftGlibc
#else
    import Darwin
#endif

// Create a new router
let router = Router()
router.add(templateEngine: MustacheTemplateEngine())


func getJSON() -> [String: Int] {
    var rndJSON = [String: Int]()
    for i in 1...1000 {
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        rndJSON["Index \(i)"] = randomNumber
    }
    return rndJSON
}


// Handle HTTP GET requests to /
router.get("/plaintextKitura") {
    request, response, next in
    response.send("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
    next()
}

router.get("/jsonKitura") { _, response, next in
    let json = JSON(getJSON())
    try response.send(json: json).end()
}

router.get("/jsonShortKitura") { _, response, next in
    let jsonDic: [String: Int] = [
        "Vapor":941,
        "Kitura":1337,
        "Perfect":42]
    let json = JSON(jsonDic)
    try response.send(json: json).end()
}

router.get(middleware: StaticFileServer(path: "./public"))

router.get("/htmlKitura") { _, response, next in
    response.headers["Content-Type"] = "text/html; charset=utf-8"
    let htmlPage = "<!DOCTYPE html><html lang=\"en\"><body><h1>Benchmarking Server Side Swift Frameworks</h1><p style=\"color:red;\">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p> <img src=\"/img/swfit-background.jpg\" alt=\"Benchmark values for wrk test\"> <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p></body></html>"
    try response.send(htmlPage).end()
}

router.get("/htmlLargeKitura") { _, response, next in
    response.headers["Content-Type"] = "text/html; charset=utf-8"
    let htmlPage = "<!DOCTYPE html><html lang=\"en\"><body><h1>Benchmarking Server Side Swift Frameworks</h1><p style=\"color:red;\">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p> <img src=\"/img/swfit-background-GL.jpg\" alt=\"Benchmark values for wrk test\"> <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p></body></html>"
    try response.send(htmlPage).end()
}





// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8080, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()

