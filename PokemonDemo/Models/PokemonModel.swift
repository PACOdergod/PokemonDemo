//
//  PokemonModel.swift
//  PokemonDemo
//
//  Created by FAMM on 26/09/23.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [PokemonModel]
}

struct PokemonModel: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
//    var index = 0
    
    static var example = PokemonModel(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

struct PokemonDetails: Codable {
    let id: Int
    let height: Int
    let weight: Int
    let sprites: Sprites
    
    static var example = PokemonDetails(
        id: 1,
        height: 7,
        weight: 69,
        sprites: Sprites(backDefault: nil, backFemale: nil, backShiny: nil, backShinyFemale: nil, frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", frontFemale: nil, frontShiny: nil, frontShinyFemale: nil, other: nil)
    )
}

// MARK: - Sprites
struct Sprites: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let other: Other?
}

// MARK: - Other
struct Other: Codable {
    let dreamWorld: DreamWorld?
    let home: Home?
    let officialArtwork: OfficialArtwork?
}

// MARK: - DreamWorld
struct DreamWorld: Codable {
    let frontDefault: String?
    let frontFemale: String?
}

// MARK: - Home
struct Home: Codable {
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault, frontShiny: String?
}
