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
struct PokeAPIPokedexTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIPokedex.count()
        ) {
            """
            SELECT count(*)
            FROM "pokedexes"
            """
        } results: {
            """
            ┌────┐
            │ 32 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIPokedex.limit(5)
        ) {
            """
            SELECT "pokedexes"."id", "pokedexes"."identifier", "pokedexes"."region_id", "pokedexes"."is_main_series"
            FROM "pokedexes"
            LIMIT 5
            """
        } results: {
            """
            ┌──────────────────────────────────┐
            │ PokeAPIPokedex(                  │
            │   id: Tagged(rawValue: 1),       │
            │   identifier: "national",        │
            │   regionId: nil,                 │
            │   isMainSeries: true             │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIPokedex(                  │
            │   id: Tagged(rawValue: 2),       │
            │   identifier: "kanto",           │
            │   regionId: Tagged(rawValue: 1), │
            │   isMainSeries: true             │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIPokedex(                  │
            │   id: Tagged(rawValue: 3),       │
            │   identifier: "original-johto",  │
            │   regionId: Tagged(rawValue: 2), │
            │   isMainSeries: true             │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIPokedex(                  │
            │   id: Tagged(rawValue: 4),       │
            │   identifier: "hoenn",           │
            │   regionId: Tagged(rawValue: 3), │
            │   isMainSeries: true             │
            │ )                                │
            ├──────────────────────────────────┤
            │ PokeAPIPokedex(                  │
            │   id: Tagged(rawValue: 5),       │
            │   identifier: "original-sinnoh", │
            │   regionId: Tagged(rawValue: 4), │
            │   isMainSeries: true             │
            │ )                                │
            └──────────────────────────────────┘
            """
        }
    }
}
