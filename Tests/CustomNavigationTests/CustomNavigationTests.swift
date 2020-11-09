import XCTest
@testable import CustomNavigation

final class CustomNavigationTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CustomNavigation().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
