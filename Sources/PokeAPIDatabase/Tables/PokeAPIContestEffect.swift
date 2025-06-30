import StructuredQueries
import Tagged

// TODO: Add description for contest_effects table
@Table("contest_effects")
public struct PokeAPIContestEffect: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for appeal
    @Column("appeal") public var appeal: Int

    // TODO: Add description for jam
    @Column("jam") public var jam: Int

}