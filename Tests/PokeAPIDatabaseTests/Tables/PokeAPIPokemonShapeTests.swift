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
struct PokeAPIPokemonShapeTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonShape.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_shapes"
            """
        } results: {
            """
            ┌────┐
            │ 14 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonShape.limit(5)
        ) {
            """
            SELECT "pokemon_shapes"."id", "pokemon_shapes"."identifier"
            FROM "pokemon_shapes"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIPokemonShape(       │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "ball"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonShape(       │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "squiggle"   │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonShape(       │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "fish"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonShape(       │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "arms"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonShape(       │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "blob"       │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}
