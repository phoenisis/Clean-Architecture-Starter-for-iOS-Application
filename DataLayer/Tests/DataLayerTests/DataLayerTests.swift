import XCTest
@testable import DataLayer

final class DataLayerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DataLayer().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
