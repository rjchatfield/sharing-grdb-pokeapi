import StructuredQueries
import Tagged

/// Personality characteristics based on Individual Values (IVs)
@Table("characteristics")
public struct PokeAPICharacteristic: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for this characteristic
    @Column("id", primaryKey: true) public var id: ID

    /// Foreign key to stat
    @Column("stat_id") public var statId: PokeAPIStat.ID

    /// Gene mod 5
    @Column("gene_mod_5") public var geneMod5: Int

    // MARK: - Helpers

    public var localizedName: String {
        return "Characteristic \(id)"
    }
}
