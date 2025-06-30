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
struct PokeAPIVersionGroupRegionTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPIVersionGroupRegion.count()
        ) {
            """
            SELECT count(*)
            FROM "version_group_regions"
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
            PokeAPIVersionGroupRegion.limit(5)
        ) {
            """
            SELECT "version_group_regions"."version_group_id", "version_group_regions"."region_id"
            FROM "version_group_regions"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────────────────┐
            │ PokeAPIVersionGroupRegion(             │
            │   versionGroupId: Tagged(rawValue: 1), │
            │   regionId: Tagged(rawValue: 1)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIVersionGroupRegion(             │
            │   versionGroupId: Tagged(rawValue: 2), │
            │   regionId: Tagged(rawValue: 1)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIVersionGroupRegion(             │
            │   versionGroupId: Tagged(rawValue: 3), │
            │   regionId: Tagged(rawValue: 1)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIVersionGroupRegion(             │
            │   versionGroupId: Tagged(rawValue: 3), │
            │   regionId: Tagged(rawValue: 2)        │
            │ )                                      │
            ├────────────────────────────────────────┤
            │ PokeAPIVersionGroupRegion(             │
            │   versionGroupId: Tagged(rawValue: 4), │
            │   regionId: Tagged(rawValue: 1)        │
            │ )                                      │
            └────────────────────────────────────────┘
            """
        }
    }
}