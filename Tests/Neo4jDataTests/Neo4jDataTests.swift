import XCTest
@testable import Neo4jDataCore

class Neo4jDataTests: XCTestCase {
    
    let core: Neo4jDataCore = try! Neo4jDataCore()
    let people = ["Jacob", "Mason", "Ethan", "Noah", "William"]
    
    func testCreate() {
        core.createNodes(people)
    }
    
    func testDelete() {
        core.deleteNodes()
    }
    
    func testMatch() {
        guard let nodes = core.matchNodes() else { return XCTAssert(false) }
        XCTAssertEqual(nodes.count, people.count)
    }
    
}

extension Neo4jDataTests {
    static let allTests = [
        ("testCreate", testCreate)
    ]
}
