import Foundation
import Theo

public final class Neo4jDataCore {
    
    private var hostname: String = "localhost"
    private var username: String = "neo4j"
    private var password: String = "9999"
    private var label: String = "Person"
    
    lazy var client = try BoltClient(hostname: self.hostname,
                                     username: self.username,
                                     password: self.password)
    
    public init() throws {}
    public func run() throws {}
    
}

extension Neo4jDataCore {
    
    func createNodes(_ people: [String]) {
        let result = client.connectSync()
        switch result {
        case .failure(_): return
        case .success(_):
            defer { client.disconnect() }
            let nodes = people.map{ Node(label: label, properties: ["name": $0]) }
            let createResult = client.createAndReturnNodesSync(nodes: nodes)
            switch createResult {
            case .failure(_): return
            case .success(_): print("Node saved successfully")
            }
        }
    }
    
    func deleteNodes() {
        let result = client.connectSync()
        switch result {
        case .failure(_): return
        case .success(_):
            defer { client.disconnect() }
            client.nodesWith(label: label){ [weak self] searchResult in
                guard let nodes = searchResult.value, nodes.count > 0 else { return }
                let deleteResult = self!.client.deleteNodesSync(nodes: nodes)
                switch deleteResult {
                case .failure(_): break
                case .success(_): print("delete nodes")
                }
            }
        }
    }
    
    func matchNodes() -> [Node]? {
        let result = client.connectSync()
        switch result {
        case .failure(_): return nil
        case .success(_):
            defer { client.disconnect() }
            let executeResult = client.executeCypherSync("MATCH (n:\(label)) RETURN n")
            switch executeResult {
            case .failure(_): return nil
            case let .success(queryResult): return queryResult.nodes.values.map{ $0 }
            }
        }
    }
        
}
