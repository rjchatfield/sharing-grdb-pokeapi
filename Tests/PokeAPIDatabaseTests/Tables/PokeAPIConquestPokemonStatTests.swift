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
struct PokeAPIConquestPokemonStatTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestPokemonStat.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_pokemon_stats"
            """
        } results: {
            """
            ┌──────┐
            │ 1000 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestPokemonStat.limit(5)
        ) {
            """
            SELECT "conquest_pokemon_stats"."pokemon_species_id", "conquest_pokemon_stats"."conquest_stat_id", "conquest_pokemon_stats"."base_stat"
            FROM "conquest_pokemon_stats"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────────┐
            │ PokeAPIConquestPokemonStat(              │
            │   pokemonSpeciesId: Tagged(rawValue: 4), │
            │   conquestStatId: Tagged(rawValue: 1),   │
            │   baseStat: 188                          │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestPokemonStat(              │
            │   pokemonSpeciesId: Tagged(rawValue: 4), │
            │   conquestStatId: Tagged(rawValue: 2),   │
            │   baseStat: 125                          │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestPokemonStat(              │
            │   pokemonSpeciesId: Tagged(rawValue: 4), │
            │   conquestStatId: Tagged(rawValue: 3),   │
            │   baseStat: 97                           │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestPokemonStat(              │
            │   pokemonSpeciesId: Tagged(rawValue: 4), │
            │   conquestStatId: Tagged(rawValue: 4),   │
            │   baseStat: 135                          │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIConquestPokemonStat(              │
            │   pokemonSpeciesId: Tagged(rawValue: 4), │
            │   conquestStatId: Tagged(rawValue: 5),   │
            │   baseStat: 4                            │
            │ )                                        │
            └──────────────────────────────────────────┘
            """
        }
    }
}