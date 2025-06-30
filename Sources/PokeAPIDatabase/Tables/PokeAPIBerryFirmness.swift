import StructuredQueries
import Tagged

// TODO: Add description for berry_firmness table
@Table("berry_firmness")
public struct PokeAPIBerryFirmness: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

}