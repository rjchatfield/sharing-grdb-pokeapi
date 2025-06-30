import StructuredQueries
import Tagged

// TODO: Add description for berry_flavors table
@Table("berry_flavors")
public struct PokeAPIBerryFlavor: Decodable, Hashable, Sendable {

    // TODO: Add description for berry_id
    @Column("berry_id") public var berryId: PokeAPIBerry.ID

    // TODO: Add description for contest_type_id
    @Column("contest_type_id") public var contestTypeId: PokeAPIContestType.ID

    // TODO: Add description for flavor
    @Column("flavor") public var flavor: Int

}