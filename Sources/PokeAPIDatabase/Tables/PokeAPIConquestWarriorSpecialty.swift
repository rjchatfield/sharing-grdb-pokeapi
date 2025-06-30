import StructuredQueries
import Tagged

/// Warrior type specialties in Pokemon Conquest showing which Pokemon types warriors prefer.
/// Warriors have natural affinities for certain types, affecting their combat effectiveness.
/// This system encourages strategic team building by matching warriors with compatible Pokemon.
@Table("conquest_warrior_specialties")
public struct PokeAPIConquestWarriorSpecialty: Decodable, Hashable, Sendable {

    /// References the warrior who has this type specialty
    /// Each warrior can specialize in multiple types
    @Column("warrior_id") public var warriorId: PokeAPIConquestWarrior.ID

    /// The Pokemon type this warrior specializes in
    /// Warriors form stronger bonds with Pokemon of their specialty types
    @Column("type_id") public var typeId: PokeAPIType.ID

    /// The slot/order of this specialty for this warrior
    /// Indicates the priority or importance of this type specialty
    @Column("slot") public var slot: Int

}