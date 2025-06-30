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
struct PokeAPIPokemonColorTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokemonColor.count()
        ) {
            """
            SELECT count(*)
            FROM "pokemon_colors"
            """
        } results: {
            """
            ┌────┐
            │ 10 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokemonColor.limit(5)
        ) {
            """
            SELECT "pokemon_colors"."id", "pokemon_colors"."identifier"
            FROM "pokemon_colors"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPIPokemonColor(       │
            │   id: Tagged(rawValue: 1), │
            │   identifier: "black"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonColor(       │
            │   id: Tagged(rawValue: 2), │
            │   identifier: "blue"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonColor(       │
            │   id: Tagged(rawValue: 3), │
            │   identifier: "brown"      │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonColor(       │
            │   id: Tagged(rawValue: 4), │
            │   identifier: "gray"       │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPIPokemonColor(       │
            │   id: Tagged(rawValue: 5), │
            │   identifier: "green"      │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}
