import StructuredQueries
import Tagged

/// Represents status conditions or ailments that moves can inflict on Pokémon.
/// This includes temporary status effects like paralysis, sleep, burn, poison,
/// and other conditions that affect Pokémon during battle.
@Table("move_meta_ailments")
public struct PokeAPIMoveMetaAilment: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    /// Unique identifier for the ailment
    @Column("id", primaryKey: true) public var id: ID

    /// Machine-readable identifier for the ailment (e.g., "paralysis", "sleep", "burn", "poison")
    @Column("identifier") public var identifier: Identifier

}