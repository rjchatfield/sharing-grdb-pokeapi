import Testing
import StructuredQueries
import StructuredQueriesSQLite
import StructuredQueriesTestSupport
import SnapshotTesting
import InlineSnapshotTesting
import PokeAPIDatabase

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct PokeAPIConquestKingdomTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestKingdom.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_kingdoms"
            """
        } results: {
            """
            ┌────┐
            │ 17 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestKingdom.limit(5)
        ) {
            """
            SELECT "conquest_kingdoms"."id", "conquest_kingdoms"."identifier", "conquest_kingdoms"."type_id"
            FROM "conquest_kingdoms"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────┐
            │ PokeAPIConquestKingdom(        │
            │   id: Tagged(rawValue: 1),     │
            │   identifier: "aurora",        │
            │   typeId: Tagged(rawValue: 1)  │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIConquestKingdom(        │
            │   id: Tagged(rawValue: 2),     │
            │   identifier: "ignis",         │
            │   typeId: Tagged(rawValue: 10) │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIConquestKingdom(        │
            │   id: Tagged(rawValue: 3),     │
            │   identifier: "fontaine",      │
            │   typeId: Tagged(rawValue: 11) │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIConquestKingdom(        │
            │   id: Tagged(rawValue: 4),     │
            │   identifier: "violight",      │
            │   typeId: Tagged(rawValue: 13) │
            │ )                              │
            ├────────────────────────────────┤
            │ PokeAPIConquestKingdom(        │
            │   id: Tagged(rawValue: 5),     │
            │   identifier: "greenleaf",     │
            │   typeId: Tagged(rawValue: 12) │
            │ )                              │
            └────────────────────────────────┘
            """
        }
    }
}