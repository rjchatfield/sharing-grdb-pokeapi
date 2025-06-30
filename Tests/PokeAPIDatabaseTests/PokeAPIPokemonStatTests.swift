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
struct PokeAPIPokemonStatTests {
    @Test
        func testPokemonStatBasicQuery() {
            Helper.assertQuery(
                PokeAPIPokemonStat.count()
            ) {
                """
                SELECT count(*)
                FROM "pokemon_stats"
                """
            } results: {
                """
                ┌──────┐
                │ 7812 │
                └──────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIPokemonStat.limit(5)
            ) {
                """
                SELECT "pokemon_stats"."pokemon_id", "pokemon_stats"."stat_id", "pokemon_stats"."base_stat", "pokemon_stats"."effort"
                FROM "pokemon_stats"
                LIMIT 5
                """
            } results: {
                """
                ┌───────────────────────────────────┐
                │ PokeAPIPokemonStat(               │
                │   pokemonId: Tagged(rawValue: 1), │
                │   statId: .hp,                    │
                │   baseStat: 45,                   │
                │   effort: 0                       │
                │ )                                 │
                ├───────────────────────────────────┤
                │ PokeAPIPokemonStat(               │
                │   pokemonId: Tagged(rawValue: 1), │
                │   statId: .attack,                │
                │   baseStat: 49,                   │
                │   effort: 0                       │
                │ )                                 │
                ├───────────────────────────────────┤
                │ PokeAPIPokemonStat(               │
                │   pokemonId: Tagged(rawValue: 1), │
                │   statId: .defense,               │
                │   baseStat: 49,                   │
                │   effort: 0                       │
                │ )                                 │
                ├───────────────────────────────────┤
                │ PokeAPIPokemonStat(               │
                │   pokemonId: Tagged(rawValue: 1), │
                │   statId: .specialAttack,         │
                │   baseStat: 65,                   │
                │   effort: 1                       │
                │ )                                 │
                ├───────────────────────────────────┤
                │ PokeAPIPokemonStat(               │
                │   pokemonId: Tagged(rawValue: 1), │
                │   statId: .specialDefense,        │
                │   baseStat: 65,                   │
                │   effort: 0                       │
                │ )                                 │
                └───────────────────────────────────┘
                """
            }
        }
}
