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
struct PokeAPIPokedexVersionGroupTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokedexVersionGroup.count()
        ) {
            """
            SELECT count(*)
            FROM "pokedex_version_groups"
            """
        } results: {
            """
            ┌────┐
            │ 39 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokedexVersionGroup.limit(5)
        ) {
            """
            SELECT "pokedex_version_groups"."pokedex_id", "pokedex_version_groups"."version_group_id"
            FROM "pokedex_version_groups"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────────┐
            │ PokeAPIPokedexVersionGroup(            │
            │   pokedexId: Tagged(rawValue: 2),      │
            │   versionGroupId: Tagged(rawValue: 1)  │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIPokedexVersionGroup(            │
            │   pokedexId: Tagged(rawValue: 2),      │
            │   versionGroupId: Tagged(rawValue: 2)  │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIPokedexVersionGroup(            │
            │   pokedexId: Tagged(rawValue: 2),      │
            │   versionGroupId: Tagged(rawValue: 7)  │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIPokedexVersionGroup(            │
            │   pokedexId: Tagged(rawValue: 2),      │
            │   versionGroupId: Tagged(rawValue: 28) │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIPokedexVersionGroup(            │
            │   pokedexId: Tagged(rawValue: 2),      │
            │   versionGroupId: Tagged(rawValue: 29) │
            │ )                                      │
            └────────────────────────────────────────┘
            """
        }
    }
}