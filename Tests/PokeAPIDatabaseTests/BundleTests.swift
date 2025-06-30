import CustomDump
import Foundation
import InlineSnapshotTesting
import PokeAPIDatabase
import SnapshotTesting
import Testing

@Suite(
    .serialized,
    .snapshots(record: .failed)
)
struct BundleTests {
    @Test
    func containsSingleDatabase() throws {
        assertInlineSnapshot(of: sortedFilePaths.filter({ $0.hasSuffix(".db") }), as: .customDump) {
            """
            [
              [0]: "pokeapi.db"
            ]
            """
        }
    }

    @Test
    func containsLocalisations() throws {
        // Filtering to "Pokemon.strings" just to see if every language is present.
        assertInlineSnapshot(of: sortedFilePaths.filter({ $0.hasSuffix("/Pokemon.strings") }), as: .customDump) {
            """
            [
              [0]: "de.lproj/Pokemon.strings",
              [1]: "en.lproj/Pokemon.strings",
              [2]: "es.lproj/Pokemon.strings",
              [3]: "fr.lproj/Pokemon.strings",
              [4]: "it.lproj/Pokemon.strings",
              [5]: "ja.lproj/Pokemon.strings",
              [6]: "ko.lproj/Pokemon.strings",
              [7]: "zh-hans.lproj/Pokemon.strings",
              [8]: "zh-hant.lproj/Pokemon.strings"
            ]
            """
        }
    }

    @Test
    func pathForResource() throws {
        let _ = try #require(Bundle.pokeapi.path(forResource: "pokeapi", ofType: "db"))
    }

    // MARK: -

    private var sortedFilePaths: [String] {
        let enumerator = FileManager.default.enumerator(atPath: Bundle.pokeapi.bundlePath)
        var filePaths = [String]()
        while let filePath = enumerator?.nextObject() as? String {
            guard !filePath.hasPrefix("_CodeSignature") else { continue }
            filePaths.append(filePath)
        }
        return filePaths.sorted()
    }
}
