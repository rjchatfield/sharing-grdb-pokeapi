import StructuredQueries
import Tagged

// TODO: Add description for pokemon_move_methods table
@Table("pokemon_move_methods")
public struct PokeAPIPokemonMoveMethod: Decodable, Hashable, Identifiable, Sendable {
    public typealias ID = Tagged<Self, Int>
    public typealias Identifier = String

    // TODO: Add description for id
    @Column("id", primaryKey: true) public var id: ID

    // TODO: Add description for identifier
    @Column("identifier") public var identifier: Identifier

}