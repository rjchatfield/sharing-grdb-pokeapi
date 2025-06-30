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
struct PokeAPIItemGameIndicesTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIItemGameIndices.count()
        ) {
            """
            SELECT count(*)
            FROM "item_game_indices"
            """
        } results: {
            """
            ┌──────┐
            │ 4711 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIItemGameIndices.limit(5)
        ) {
            """
            SELECT "item_game_indices"."item_id", "item_game_indices"."generation_id", "item_game_indices"."game_index"
            FROM "item_game_indices"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPIItemGameIndices(              │
            │   itemId: Tagged(rawValue: 1),       │
            │   generationId: Tagged(rawValue: 3), │
            │   gameIndex: 1                       │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIItemGameIndices(              │
            │   itemId: Tagged(rawValue: 1),       │
            │   generationId: Tagged(rawValue: 4), │
            │   gameIndex: 1                       │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIItemGameIndices(              │
            │   itemId: Tagged(rawValue: 1),       │
            │   generationId: Tagged(rawValue: 5), │
            │   gameIndex: 1                       │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIItemGameIndices(              │
            │   itemId: Tagged(rawValue: 1),       │
            │   generationId: Tagged(rawValue: 6), │
            │   gameIndex: 1                       │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPIItemGameIndices(              │
            │   itemId: Tagged(rawValue: 1),       │
            │   generationId: Tagged(rawValue: 7), │
            │   gameIndex: 1                       │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
}