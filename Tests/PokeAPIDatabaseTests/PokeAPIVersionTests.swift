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
struct PokeAPIVersionTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIVersion.count()
        ) {
            """
            SELECT count(*)
            FROM "versions"
            """
        } results: {
            """
            ┌────┐
            │ 46 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIVersion.limit(5)
        ) {
            """
            SELECT "versions"."id", "versions"."identifier", "versions"."version_group_id"
            FROM "versions"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────┐
            │ PokeAPIVersion(                       │
            │   id: Tagged(rawValue: 1),            │
            │   identifier: "red",                  │
            │   versionGroupId: Tagged(rawValue: 1) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIVersion(                       │
            │   id: Tagged(rawValue: 2),            │
            │   identifier: "blue",                 │
            │   versionGroupId: Tagged(rawValue: 1) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIVersion(                       │
            │   id: Tagged(rawValue: 3),            │
            │   identifier: "yellow",               │
            │   versionGroupId: Tagged(rawValue: 2) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIVersion(                       │
            │   id: Tagged(rawValue: 4),            │
            │   identifier: "gold",                 │
            │   versionGroupId: Tagged(rawValue: 3) │
            │ )                                     │
            ├───────────────────────────────────────┤
            │ PokeAPIVersion(                       │
            │   id: Tagged(rawValue: 5),            │
            │   identifier: "silver",               │
            │   versionGroupId: Tagged(rawValue: 3) │
            │ )                                     │
            └───────────────────────────────────────┘
            """
        }
    }
}
