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
struct PokeAPIConquestMaxLinkTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestMaxLink.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_max_links"
            """
        } results: {
            """
            ┌───────┐
            │ 48400 │
            └───────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestMaxLink.limit(5)
        ) {
            """
            SELECT "conquest_max_links"."warrior_rank_id", "conquest_max_links"."pokemon_species_id", "conquest_max_links"."max_link"
            FROM "conquest_max_links"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────────────┐
            │ PokeAPIConquestMaxLink(                   │
            │   warriorRankId: Tagged(rawValue: 1),     │
            │   pokemonSpeciesId: Tagged(rawValue: 4),  │
            │   maxLink: 86                             │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestMaxLink(                   │
            │   warriorRankId: Tagged(rawValue: 1),     │
            │   pokemonSpeciesId: Tagged(rawValue: 5),  │
            │   maxLink: 90                             │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestMaxLink(                   │
            │   warriorRankId: Tagged(rawValue: 1),     │
            │   pokemonSpeciesId: Tagged(rawValue: 6),  │
            │   maxLink: 90                             │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestMaxLink(                   │
            │   warriorRankId: Tagged(rawValue: 1),     │
            │   pokemonSpeciesId: Tagged(rawValue: 15), │
            │   maxLink: 78                             │
            │ )                                         │
            ├───────────────────────────────────────────┤
            │ PokeAPIConquestMaxLink(                   │
            │   warriorRankId: Tagged(rawValue: 1),     │
            │   pokemonSpeciesId: Tagged(rawValue: 23), │
            │   maxLink: 80                             │
            │ )                                         │
            └───────────────────────────────────────────┘
            """
        }
    }
}