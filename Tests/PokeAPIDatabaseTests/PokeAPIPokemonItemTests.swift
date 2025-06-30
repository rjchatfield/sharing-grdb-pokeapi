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
struct PokeAPIPokemonItemTests {
    @Test
        func testPokemonItemBasicQuery() {
            Helper.assertQuery(
                PokeAPIPokemonItem.count()
            ) {
                """
                SELECT count(*)
                FROM "pokemon_items"
                """
            } results: {
                """
                ┌──────┐
                │ 5413 │
                └──────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIPokemonItem.limit(5)
            ) {
                """
                SELECT "pokemon_items"."pokemon_id", "pokemon_items"."version_id", "pokemon_items"."item_id", "pokemon_items"."rarity"
                FROM "pokemon_items"
                LIMIT 5
                """
            } results: {
                """
                ┌────────────────────────────────────┐
                │ PokeAPIPokemonItem(                │
                │   pokemonId: Tagged(rawValue: 12), │
                │   versionId: Tagged(rawValue: 7),  │
                │   itemId: Tagged(rawValue: 199),   │
                │   rarity: 5                        │
                │ )                                  │
                ├────────────────────────────────────┤
                │ PokeAPIPokemonItem(                │
                │   pokemonId: Tagged(rawValue: 12), │
                │   versionId: Tagged(rawValue: 8),  │
                │   itemId: Tagged(rawValue: 199),   │
                │   rarity: 5                        │
                │ )                                  │
                ├────────────────────────────────────┤
                │ PokeAPIPokemonItem(                │
                │   pokemonId: Tagged(rawValue: 12), │
                │   versionId: Tagged(rawValue: 9),  │
                │   itemId: Tagged(rawValue: 199),   │
                │   rarity: 5                        │
                │ )                                  │
                ├────────────────────────────────────┤
                │ PokeAPIPokemonItem(                │
                │   pokemonId: Tagged(rawValue: 12), │
                │   versionId: Tagged(rawValue: 10), │
                │   itemId: Tagged(rawValue: 199),   │
                │   rarity: 5                        │
                │ )                                  │
                ├────────────────────────────────────┤
                │ PokeAPIPokemonItem(                │
                │   pokemonId: Tagged(rawValue: 12), │
                │   versionId: Tagged(rawValue: 11), │
                │   itemId: Tagged(rawValue: 199),   │
                │   rarity: 5                        │
                │ )                                  │
                └────────────────────────────────────┘
                """
            }
        }
}
