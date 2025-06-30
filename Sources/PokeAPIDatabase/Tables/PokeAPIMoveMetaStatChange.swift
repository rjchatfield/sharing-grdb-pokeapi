import StructuredQueries
import Tagged

// TODO: Add description for move_meta_stat_changes table
@Table("move_meta_stat_changes")
public struct PokeAPIMoveMetaStatChange: Decodable, Hashable, Sendable {

    // TODO: Add description for move_id
    @Column("move_id") public var moveId: PokeAPIMove.ID

    // TODO: Add description for stat_id
    @Column("stat_id") public var statId: PokeAPIStat.ID

    // TODO: Add description for change
    @Column("change") public var change: Int

}