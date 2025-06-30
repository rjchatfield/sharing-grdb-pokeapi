import StructuredQueries
import Tagged

/// Technical Machines (TMs) and Hidden Machines (HMs) that teach moves
@Table("machines")
public struct PokeAPIMachine: Decodable, Hashable, Sendable {
    /// Machine number
    @Column("machine_number") public var machineNumber: Int

    /// Foreign key to version group
    @Column("version_group_id") public var versionGroupId: PokeAPIVersionGroup.ID

    /// Foreign key to item
    @Column("item_id") public var itemId: PokeAPIItem.ID

    /// Foreign key to move
    @Column("move_id") public var moveId: PokeAPIMove.ID
}
