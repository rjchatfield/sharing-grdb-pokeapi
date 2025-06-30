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
struct PokeAPIVersionGroupTests {
    @Test
        func testVersionGroupBasicQuery() {
            Helper.assertQuery(
                PokeAPIVersionGroup.count()
            ) {
                """
                SELECT count(*)
                FROM "version_groups"
                """
            } results: {
                """
                ┌────┐
                │ 29 │
                └────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIVersionGroup.limit(5)
            ) {
                """
                SELECT "version_groups"."id", "version_groups"."identifier", "version_groups"."generation_id", "version_groups"."order"
                FROM "version_groups"
                LIMIT 5
                """
            } results: {
                """
                ┌──────────────────────────────────────┐
                │ PokeAPIVersionGroup(                 │
                │   id: Tagged(rawValue: 1),           │
                │   identifier: "red-blue",            │
                │   generationId: Tagged(rawValue: 1), │
                │   order: 3                           │
                │ )                                    │
                ├──────────────────────────────────────┤
                │ PokeAPIVersionGroup(                 │
                │   id: Tagged(rawValue: 2),           │
                │   identifier: "yellow",              │
                │   generationId: Tagged(rawValue: 1), │
                │   order: 4                           │
                │ )                                    │
                ├──────────────────────────────────────┤
                │ PokeAPIVersionGroup(                 │
                │   id: Tagged(rawValue: 3),           │
                │   identifier: "gold-silver",         │
                │   generationId: Tagged(rawValue: 2), │
                │   order: 5                           │
                │ )                                    │
                ├──────────────────────────────────────┤
                │ PokeAPIVersionGroup(                 │
                │   id: Tagged(rawValue: 4),           │
                │   identifier: "crystal",             │
                │   generationId: Tagged(rawValue: 2), │
                │   order: 6                           │
                │ )                                    │
                ├──────────────────────────────────────┤
                │ PokeAPIVersionGroup(                 │
                │   id: Tagged(rawValue: 5),           │
                │   identifier: "ruby-sapphire",       │
                │   generationId: Tagged(rawValue: 3), │
                │   order: 7                           │
                │ )                                    │
                └──────────────────────────────────────┘
                """
            }
        }
}
