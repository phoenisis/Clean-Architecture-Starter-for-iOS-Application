import XCTest
@testable import DomainLayer

final class DomainLayerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DomainLayer().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
