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
struct PokeAPIContestTypeTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIContestType.count()
        ) {
            """
            SELECT count(*)
            FROM "contest_types"
            """
        } results: {
            """
            ┌───┐
            │ 5 │
            └───┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIContestType.limit(5)
        ) {
            """
            SELECT "contest_types"."id", "contest_types"."identifier"
            FROM "contest_types"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIContestType(        │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "cool"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIContestType(        │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "beauty"     │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIContestType(        │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "cute"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIContestType(        │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "smart"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIContestType(        │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "tough"      │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}