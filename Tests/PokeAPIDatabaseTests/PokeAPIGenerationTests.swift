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
struct PokeAPIGenerationTests {
    @Test
        func testGenerationBasicQuery() {
            Helper.assertQuery(
                PokeAPIGeneration.count()
            ) {
                """
                SELECT count(*)
                FROM "generations"
                """
            } results: {
                """
                ┌───┐
                │ 9 │
                └───┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIGeneration.limit(5)
            ) {
                """
                SELECT "generations"."id", "generations"."identifier", "generations"."main_region_id"
                FROM "generations"
                LIMIT 5
                """
            } results: {
                """
                ┌─────────────────────────────────────┐
                │ PokeAPIGeneration(                  │
                │   id: Tagged(rawValue: 1),          │
                │   identifier: "generation-i",       │
                │   mainRegionId: Tagged(rawValue: 1) │
                │ )                                   │
                ├─────────────────────────────────────┤
                │ PokeAPIGeneration(                  │
                │   id: Tagged(rawValue: 2),          │
                │   identifier: "generation-ii",      │
                │   mainRegionId: Tagged(rawValue: 2) │
                │ )                                   │
                ├─────────────────────────────────────┤
                │ PokeAPIGeneration(                  │
                │   id: Tagged(rawValue: 3),          │
                │   identifier: "generation-iii",     │
                │   mainRegionId: Tagged(rawValue: 3) │
                │ )                                   │
                ├─────────────────────────────────────┤
                │ PokeAPIGeneration(                  │
                │   id: Tagged(rawValue: 4),          │
                │   identifier: "generation-iv",      │
                │   mainRegionId: Tagged(rawValue: 4) │
                │ )                                   │
                ├─────────────────────────────────────┤
                │ PokeAPIGeneration(                  │
                │   id: Tagged(rawValue: 5),          │
                │   identifier: "generation-v",       │
                │   mainRegionId: Tagged(rawValue: 5) │
                │ )                                   │
                └─────────────────────────────────────┘
                """
            }
        }
}
