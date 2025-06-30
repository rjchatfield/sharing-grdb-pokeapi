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
struct PokeAPITypeGameIndicesTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPITypeGameIndices.count()
        ) {
            """
            SELECT count(*)
            FROM "type_game_indices"
            """
        } results: {
            """
            ┌─────┐
            │ 104 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPITypeGameIndices.limit(5)
        ) {
            """
            SELECT "type_game_indices"."type_id", "type_game_indices"."generation_id", "type_game_indices"."game_index"
            FROM "type_game_indices"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────┐
            │ PokeAPITypeGameIndices(              │
            │   typeId: Tagged(rawValue: 1),       │
            │   generationId: Tagged(rawValue: 1), │
            │   gameIndex: 0                       │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeGameIndices(              │
            │   typeId: Tagged(rawValue: 1),       │
            │   generationId: Tagged(rawValue: 2), │
            │   gameIndex: 0                       │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeGameIndices(              │
            │   typeId: Tagged(rawValue: 1),       │
            │   generationId: Tagged(rawValue: 3), │
            │   gameIndex: 0                       │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeGameIndices(              │
            │   typeId: Tagged(rawValue: 1),       │
            │   generationId: Tagged(rawValue: 4), │
            │   gameIndex: 0                       │
            │ )                                    │
            ├──────────────────────────────────────┤
            │ PokeAPITypeGameIndices(              │
            │   typeId: Tagged(rawValue: 1),       │
            │   generationId: Tagged(rawValue: 5), │
            │   gameIndex: 0                       │
            │ )                                    │
            └──────────────────────────────────────┘
            """
        }
    }
}