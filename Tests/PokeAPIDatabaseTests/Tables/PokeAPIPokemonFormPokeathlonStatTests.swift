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
struct PokeAPIPokemonFormPokeathlonStatTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonFormPokeathlonStat.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_form_pokeathlon_stats"
            """
        } results: {
            """
            ┌──────┐
            │ 2770 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonFormPokeathlonStat.limit(5)
        ) {
            """
            SELECT "pokemon_form_pokeathlon_stats"."pokemon_form_id", "pokemon_form_pokeathlon_stats"."pokeathlon_stat_id", "pokemon_form_pokeathlon_stats"."minimum_stat", "pokemon_form_pokeathlon_stats"."base_stat", "pokemon_form_pokeathlon_stats"."maximum_stat"
            FROM "pokemon_form_pokeathlon_stats"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────────────┐
            │ PokeAPIPokemonFormPokeathlonStat(        │
            │   pokemonFormId: Tagged(rawValue: 1),    │
            │   pokeathlonStatId: Tagged(rawValue: 1), │
            │   minimumStat: 2,                        │
            │   baseStat: 2,                           │
            │   maximumStat: 3                         │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIPokemonFormPokeathlonStat(        │
            │   pokemonFormId: Tagged(rawValue: 1),    │
            │   pokeathlonStatId: Tagged(rawValue: 2), │
            │   minimumStat: 2,                        │
            │   baseStat: 2,                           │
            │   maximumStat: 3                         │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIPokemonFormPokeathlonStat(        │
            │   pokemonFormId: Tagged(rawValue: 1),    │
            │   pokeathlonStatId: Tagged(rawValue: 3), │
            │   minimumStat: 1,                        │
            │   baseStat: 3,                           │
            │   maximumStat: 4                         │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIPokemonFormPokeathlonStat(        │
            │   pokemonFormId: Tagged(rawValue: 1),    │
            │   pokeathlonStatId: Tagged(rawValue: 4), │
            │   minimumStat: 1,                        │
            │   baseStat: 3,                           │
            │   maximumStat: 4                         │
            │ )                                        │
            ├──────────────────────────────────────────┤
            │ PokeAPIPokemonFormPokeathlonStat(        │
            │   pokemonFormId: Tagged(rawValue: 1),    │
            │   pokeathlonStatId: Tagged(rawValue: 5), │
            │   minimumStat: 3,                        │
            │   baseStat: 3,                           │
            │   maximumStat: 3                         │
            │ )                                        │
            └──────────────────────────────────────────┘
            """
        }
    }
}