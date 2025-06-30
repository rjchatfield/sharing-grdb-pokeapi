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
struct PokeAPIPokemonHabitatTests {
    @Test
        func testPokeAPIPokemonHabitatBasicQuery() {
            Helper.assertQuery(
                PokeAPIPokemonHabitat.count()
            ) {
                """
                SELECT count(*)
                FROM "pokemon_habitats"
                """
            } results: {
                """
                ┌───┐
                │ 9 │
                └───┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIPokemonHabitat.limit(5)
            ) {
                """
                SELECT "pokemon_habitats"."id", "pokemon_habitats"."identifier"
                FROM "pokemon_habitats"
                LIMIT 5
                """
            } results: {
                """
                ┌────────────────────────────┐
                │ PokeAPIPokemonHabitat(     │
                │   id: Tagged(rawValue: 1), │
                │   identifier: "cave"       │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIPokemonHabitat(     │
                │   id: Tagged(rawValue: 2), │
                │   identifier: "forest"     │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIPokemonHabitat(     │
                │   id: Tagged(rawValue: 3), │
                │   identifier: "grassland"  │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIPokemonHabitat(     │
                │   id: Tagged(rawValue: 4), │
                │   identifier: "mountain"   │
                │ )                          │
                ├────────────────────────────┤
                │ PokeAPIPokemonHabitat(     │
                │   id: Tagged(rawValue: 5), │
                │   identifier: "rare"       │
                │ )                          │
                └────────────────────────────┘
                """
            }
        }
}
