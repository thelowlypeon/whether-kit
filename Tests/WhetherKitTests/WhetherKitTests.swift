import XCTest
@testable import WhetherKit

final class WhetherKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WhetherKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
