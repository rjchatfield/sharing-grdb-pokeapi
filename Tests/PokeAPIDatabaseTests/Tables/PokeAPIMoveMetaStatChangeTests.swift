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
struct PokeAPIMoveMetaStatChangeTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveMetaStatChange.count()
        ) {
            """
            SELECT count(*)
            FROM "move_meta_stat_changes"
            """
        } results: {
            """
            ┌─────┐
            │ 223 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIMoveMetaStatChange.limit(5)
        ) {
            """
            SELECT "move_meta_stat_changes"."move_id", "move_meta_stat_changes"."stat_id", "move_meta_stat_changes"."change"
            FROM "move_meta_stat_changes"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────────┐
            │ PokeAPIMoveMetaStatChange(      │
            │   moveId: Tagged(rawValue: 14), │
            │   statId: .attack,              │
            │   change: 2                     │
            │ )                               │
            ├─────────────────────────────────┤
            │ PokeAPIMoveMetaStatChange(      │
            │   moveId: Tagged(rawValue: 28), │
            │   statId: .accuracy,            │
            │   change: -1                    │
            │ )                               │
            ├─────────────────────────────────┤
            │ PokeAPIMoveMetaStatChange(      │
            │   moveId: Tagged(rawValue: 39), │
            │   statId: .defense,             │
            │   change: -1                    │
            │ )                               │
            ├─────────────────────────────────┤
            │ PokeAPIMoveMetaStatChange(      │
            │   moveId: Tagged(rawValue: 43), │
            │   statId: .defense,             │
            │   change: -1                    │
            │ )                               │
            ├─────────────────────────────────┤
            │ PokeAPIMoveMetaStatChange(      │
            │   moveId: Tagged(rawValue: 45), │
            │   statId: .attack,              │
            │   change: -1                    │
            │ )                               │
            └─────────────────────────────────┘
            """
        }
    }
}