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
struct PokeAPIPokemonMoveMethodTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonMoveMethod.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_move_methods"
            """
        } results: {
            """
            ┌────┐
            │ 11 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonMoveMethod.limit(5)
        ) {
            """
            SELECT "pokemon_move_methods"."id", "pokemon_move_methods"."identifier"
            FROM "pokemon_move_methods"
            LIMIT 5
            """
        } results: {
            """
            ┌─────────────────────────────────────────┐
            │ PokeAPIPokemonMoveMethod(               │
            │   id: Tagged(rawValue: 1),              │
            │   identifier: "level-up"                │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPIPokemonMoveMethod(               │
            │   id: Tagged(rawValue: 2),              │
            │   identifier: "egg"                     │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPIPokemonMoveMethod(               │
            │   id: Tagged(rawValue: 3),              │
            │   identifier: "tutor"                   │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPIPokemonMoveMethod(               │
            │   id: Tagged(rawValue: 4),              │
            │   identifier: "machine"                 │
            │ )                                       │
            ├─────────────────────────────────────────┤
            │ PokeAPIPokemonMoveMethod(               │
            │   id: Tagged(rawValue: 5),              │
            │   identifier: "stadium-surfing-pikachu" │
            │ )                                       │
            └─────────────────────────────────────────┘
            """
        }
    }
}