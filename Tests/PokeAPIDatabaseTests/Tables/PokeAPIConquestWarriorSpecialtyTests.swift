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
struct PokeAPIConquestWarriorSpecialtyTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIConquestWarriorSpecialty.count()
        ) {
            """
            SELECT count(*)
            FROM "conquest_warrior_specialties"
            """
        } results: {
            """
            ┌─────┐
            │ 297 │
            └─────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPIConquestWarriorSpecialty.limit(5)
        ) {
            """
            SELECT "conquest_warrior_specialties"."warrior_id", "conquest_warrior_specialties"."type_id", "conquest_warrior_specialties"."slot"
            FROM "conquest_warrior_specialties"
            LIMIT 5
            """
        } results: {
            """
            ┌───────────────────────────────────┐
            │ PokeAPIConquestWarriorSpecialty(  │
            │   warriorId: Tagged(rawValue: 1), │
            │   typeId: Tagged(rawValue: 1),    │
            │   slot: 1                         │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestWarriorSpecialty(  │
            │   warriorId: Tagged(rawValue: 2), │
            │   typeId: Tagged(rawValue: 1),    │
            │   slot: 1                         │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestWarriorSpecialty(  │
            │   warriorId: Tagged(rawValue: 3), │
            │   typeId: Tagged(rawValue: 13),   │
            │   slot: 2                         │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestWarriorSpecialty(  │
            │   warriorId: Tagged(rawValue: 3), │
            │   typeId: Tagged(rawValue: 16),   │
            │   slot: 1                         │
            │ )                                 │
            ├───────────────────────────────────┤
            │ PokeAPIConquestWarriorSpecialty(  │
            │   warriorId: Tagged(rawValue: 4), │
            │   typeId: Tagged(rawValue: 1),    │
            │   slot: 1                         │
            │ )                                 │
            └───────────────────────────────────┘
            """
        }
    }
}