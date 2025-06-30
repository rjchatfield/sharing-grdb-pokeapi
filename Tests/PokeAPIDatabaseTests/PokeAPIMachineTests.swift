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
struct PokeAPIMachineTests {
    @Test
        func testMachineBasicQuery() {
            Helper.assertQuery(
                PokeAPIMachine.count()
            ) {
                """
                SELECT count(*)
                FROM "machines"
                """
            } results: {
                """
                ┌──────┐
                │ 2102 │
                └──────┘
                """
            }
    
            Helper.assertQuery(
                PokeAPIMachine.limit(5)
            ) {
                """
                SELECT "machines"."machine_number", "machines"."version_group_id", "machines"."item_id", "machines"."move_id"
                FROM "machines"
                LIMIT 5
                """
            } results: {
                """
                ┌─────────────────────────────────────────┐
                │ PokeAPIMachine(                         │
                │   machineNumber: 0,                     │
                │   versionGroupId: Tagged(rawValue: 20), │
                │   itemId: Tagged(rawValue: 1288),       │
                │   moveId: Tagged(rawValue: 5)           │
                │ )                                       │
                ├─────────────────────────────────────────┤
                │ PokeAPIMachine(                         │
                │   machineNumber: 1,                     │
                │   versionGroupId: Tagged(rawValue: 1),  │
                │   itemId: Tagged(rawValue: 305),        │
                │   moveId: Tagged(rawValue: 5)           │
                │ )                                       │
                ├─────────────────────────────────────────┤
                │ PokeAPIMachine(                         │
                │   machineNumber: 1,                     │
                │   versionGroupId: Tagged(rawValue: 2),  │
                │   itemId: Tagged(rawValue: 305),        │
                │   moveId: Tagged(rawValue: 5)           │
                │ )                                       │
                ├─────────────────────────────────────────┤
                │ PokeAPIMachine(                         │
                │   machineNumber: 1,                     │
                │   versionGroupId: Tagged(rawValue: 3),  │
                │   itemId: Tagged(rawValue: 305),        │
                │   moveId: Tagged(rawValue: 223)         │
                │ )                                       │
                ├─────────────────────────────────────────┤
                │ PokeAPIMachine(                         │
                │   machineNumber: 1,                     │
                │   versionGroupId: Tagged(rawValue: 4),  │
                │   itemId: Tagged(rawValue: 305),        │
                │   moveId: Tagged(rawValue: 223)         │
                │ )                                       │
                └─────────────────────────────────────────┘
                """
            }
        }
}
