import Neo4jDataCore

do {
    try Neo4jDataCore().run()
} catch (let e) {
    print(e)
}
