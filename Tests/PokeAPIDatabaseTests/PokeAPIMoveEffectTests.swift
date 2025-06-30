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
struct PokeAPIMoveEffectTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIMoveEffect.count()
        ) {
            """
            SELECT count(*)
            FROM "move_effects"
            """
        } results: {
            """
            ┌─────┐
            │ 431 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIMoveEffect.limit(5)
        ) {
            """
            SELECT "move_effects"."id"
            FROM "move_effects"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────┐
            │ PokeAPIMoveEffect(        │
            │   id: Tagged(rawValue: 1) │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIMoveEffect(        │
            │   id: Tagged(rawValue: 2) │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIMoveEffect(        │
            │   id: Tagged(rawValue: 3) │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIMoveEffect(        │
            │   id: Tagged(rawValue: 4) │
            │ )                         │
            ├───────────────────────────┤
            │ PokeAPIMoveEffect(        │
            │   id: Tagged(rawValue: 5) │
            │ )                         │
            └───────────────────────────┘
            """
        }
    }
}
