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
struct PokeAPILocationAreaTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPILocationArea.count()
        ) {
            """
            SELECT count(*)
            FROM "location_areas"
            """
        } results: {
            """
            ┌──────┐
            │ 1089 │
            └──────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPILocationArea.limit(5)
        ) {
            """
            SELECT "location_areas"."id", "location_areas"."identifier", "location_areas"."location_id", "location_areas"."game_index"
            FROM "location_areas"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────┐
            │ PokeAPILocationArea(               │
            │   id: Tagged(rawValue: 1),         │
            │   identifier: nil,                 │
            │   locationId: Tagged(rawValue: 1), │
            │   gameIndex: 1                     │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPILocationArea(               │
            │   id: Tagged(rawValue: 2),         │
            │   identifier: nil,                 │
            │   locationId: Tagged(rawValue: 2), │
            │   gameIndex: 2                     │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPILocationArea(               │
            │   id: Tagged(rawValue: 3),         │
            │   identifier: nil,                 │
            │   locationId: Tagged(rawValue: 3), │
            │   gameIndex: 3                     │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPILocationArea(               │
            │   id: Tagged(rawValue: 4),         │
            │   identifier: nil,                 │
            │   locationId: Tagged(rawValue: 4), │
            │   gameIndex: 4                     │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPILocationArea(               │
            │   id: Tagged(rawValue: 5),         │
            │   identifier: nil,                 │
            │   locationId: Tagged(rawValue: 5), │
            │   gameIndex: 5                     │
            │ )                                  │
            └────────────────────────────────────┘
            """
        }
    }

    @Test
    func hasIdentifier() {
        Helper.assertQuery(
            PokeAPILocationArea
                .where { $0.identifier != nil }
                .limit(2)
        ) {
            """
            SELECT "location_areas"."id", "location_areas"."identifier", "location_areas"."location_id", "location_areas"."game_index"
            FROM "location_areas"
            WHERE ("location_areas"."identifier" IS NOT NULL)
            LIMIT 2
            """
        } results: {
            """
            ┌────────────────────────────────────┐
            │ PokeAPILocationArea(               │
            │   id: Tagged(rawValue: 6),         │
            │   identifier: "1f",                │
            │   locationId: Tagged(rawValue: 6), │
            │   gameIndex: 6                     │
            │ )                                  │
            ├────────────────────────────────────┤
            │ PokeAPILocationArea(               │
            │   id: Tagged(rawValue: 7),         │
            │   identifier: "b1f",               │
            │   locationId: Tagged(rawValue: 6), │
            │   gameIndex: 7                     │
            │ )                                  │
            └────────────────────────────────────┘
            """
        }
    }
}
