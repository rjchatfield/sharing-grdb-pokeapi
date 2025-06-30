import StructuredQueries
import Tagged

/// Records stat changes that moves can apply to Pokémon during battle.
/// This table maps moves to the specific stats they modify and by how much,
/// covering both stat boosts and debuffs that occur as move effects.
@Table("move_meta_stat_changes")
public struct PokeAPIMoveMetaStatChange: Decodable, Hashable, Sendable {

    /// Reference to the move that causes the stat change
    @Column("move_id") public var moveId: PokeAPIMove.ID

    /// Reference to the stat that is modified by the move
    @Column("stat_id") public var statId: PokeAPIStat.ID

    /// The amount by which the stat is changed (positive for increases, negative for decreases)
    @Column("change") public var change: Int

}