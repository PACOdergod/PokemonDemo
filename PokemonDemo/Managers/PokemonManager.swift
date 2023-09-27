//
//  PokemonManager.swift
//  PokemonDemo
//
//  Created by FAMM on 26/09/23.
//

import Foundation

class PokemonManager {
    func getPokemon() -> [PokemonModel] {
        let data: PokemonPage = Bundle.main.decode(file: "pokemon.json")
        let pokemon: [PokemonModel] = data.results
        return pokemon
    }
    
    func getDetailsPokemon(id: Int, _ completion: @escaping (PokemonDetails)->()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/", model: PokemonDetails.self) { data in
            completion(data)
        } failure: { error in
            print(error)
        }

    }
}
