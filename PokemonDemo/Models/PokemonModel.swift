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
    
    static var example = PokemonModel(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

struct PokemonDetails: Codable {
    let id: Int
    let height: Int
    let weight: Int
    
    static var example = PokemonDetails(id: 1, height: 7, weight: 69)
}
