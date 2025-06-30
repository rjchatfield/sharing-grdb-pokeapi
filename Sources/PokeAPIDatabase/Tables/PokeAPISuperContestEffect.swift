import StructuredQueries
import Tagged

// TODO: Add description for super_contest_effects table
@Table("super_contest_effects")
public struct PokeAPISuperContestEffect: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for appeal
    @Column("appeal") public var appeal: Int

}