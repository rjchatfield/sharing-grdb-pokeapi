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
struct PokeAPICharacteristicTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPICharacteristic.count()
        ) {
            """
            SELECT count(*)
            FROM "characteristics"
            """
        } results: {
            """
            ┌────┐
            │ 30 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPICharacteristic.limit(5)
        ) {
            """
            SELECT "characteristics"."id", "characteristics"."stat_id", "characteristics"."gene_mod_5"
            FROM "characteristics"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPICharacteristic(     │
            │   id: Tagged(rawValue: 1), │
            │   statId: .hp,             │
            │   geneMod5: 0              │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPICharacteristic(     │
            │   id: Tagged(rawValue: 2), │
            │   statId: .attack,         │
            │   geneMod5: 0              │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPICharacteristic(     │
            │   id: Tagged(rawValue: 3), │
            │   statId: .defense,        │
            │   geneMod5: 0              │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPICharacteristic(     │
            │   id: Tagged(rawValue: 4), │
            │   statId: .specialAttack,  │
            │   geneMod5: 0              │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPICharacteristic(     │
            │   id: Tagged(rawValue: 5), │
            │   statId: .specialDefense, │
            │   geneMod5: 0              │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }

    @Test
    func geneMode5() {
        Helper.assertQuery(
            PokeAPICharacteristic
                .where { $0.geneMod5 != 0 }
                .count()
        ) {
            """
            SELECT count(*)
            FROM "characteristics"
            WHERE ("characteristics"."gene_mod_5" <> 0)
            """
        } results: {
            """
            ┌────┐
            │ 24 │
            └────┘
            """
        }
    }
}
