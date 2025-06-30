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
struct PokeAPILanguageTests {
    @Test
    func count() {
        Helper.assertQuery(
            PokeAPILanguage.count()
        ) {
            """
            SELECT count(*)
            FROM "languages"
            """
        } results: {
            """
            ┌────┐
            │ 13 │
            └────┘
            """
        }
    }

    @Test
    func first5() {
        Helper.assertQuery(
            PokeAPILanguage.limit(5)
        ) {
            """
            SELECT "languages"."id", "languages"."iso639", "languages"."iso3166", "languages"."identifier", "languages"."official", "languages"."order"
            FROM "languages"
            LIMIT 5
            """
        } results: {
            """
            ┌────────────────────────────┐
            │ PokeAPILanguage(           │
            │   id: Tagged(rawValue: 1), │
            │   iso639: "ja",            │
            │   iso3166: "jp",           │
            │   identifier: "ja-Hrkt",   │
            │   official: 1,             │
            │   order: 1                 │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPILanguage(           │
            │   id: Tagged(rawValue: 2), │
            │   iso639: "ja",            │
            │   iso3166: "jp",           │
            │   identifier: "roomaji",   │
            │   official: 1,             │
            │   order: 3                 │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPILanguage(           │
            │   id: Tagged(rawValue: 3), │
            │   iso639: "ko",            │
            │   iso3166: "kr",           │
            │   identifier: "ko",        │
            │   official: 1,             │
            │   order: 4                 │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPILanguage(           │
            │   id: Tagged(rawValue: 4), │
            │   iso639: "zh",            │
            │   iso3166: "cn",           │
            │   identifier: "zh-Hant",   │
            │   official: 1,             │
            │   order: 5                 │
            │ )                          │
            ├────────────────────────────┤
            │ PokeAPILanguage(           │
            │   id: Tagged(rawValue: 5), │
            │   iso639: "fr",            │
            │   iso3166: "fr",           │
            │   identifier: "fr",        │
            │   official: 1,             │
            │   order: 8                 │
            │ )                          │
            └────────────────────────────┘
            """
        }
    }
}