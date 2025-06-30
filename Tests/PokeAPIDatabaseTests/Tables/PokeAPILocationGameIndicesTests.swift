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
struct PokeAPILocationGameIndicesTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPILocationGameIndices.count()
        ) {
            """
            SELECT count(*)
            FROM "location_game_indices"
            """
        } results: {
            """
            ┌─────┐
            │ 767 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPILocationGameIndices.limit(5)
        ) {
            """
            SELECT "location_game_indices"."location_id", "location_game_indices"."generation_id", "location_game_indices"."game_index"
            FROM "location_game_indices"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPILocationGameIndices(          │
            │   locationId: Tagged(rawValue: 1),   │
            │   generationId: Tagged(rawValue: 4), │
            │   gameIndex: 7                       │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPILocationGameIndices(          │
            │   locationId: Tagged(rawValue: 2),   │
            │   generationId: Tagged(rawValue: 4), │
            │   gameIndex: 9                       │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPILocationGameIndices(          │
            │   locationId: Tagged(rawValue: 3),   │
            │   generationId: Tagged(rawValue: 4), │
            │   gameIndex: 11                      │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPILocationGameIndices(          │
            │   locationId: Tagged(rawValue: 4),   │
            │   generationId: Tagged(rawValue: 4), │
            │   gameIndex: 13                      │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPILocationGameIndices(          │
            │   locationId: Tagged(rawValue: 5),   │
            │   generationId: Tagged(rawValue: 4), │
            │   gameIndex: 15                      │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
}