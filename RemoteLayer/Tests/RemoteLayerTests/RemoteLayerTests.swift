import XCTest
@testable import RemoteLayer

final class RemoteLayerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RemoteLayer().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
