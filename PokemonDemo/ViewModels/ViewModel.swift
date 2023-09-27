//
//  ViewModel.swift
//  PokemonDemo
//
//  Created by FAMM on 26/09/23.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    private let manager = PokemonManager()
    
    @Published var pokemonList = [PokemonModel]()
    @Published var pokemonDetails: PokemonDetails?
    @Published var searchText = ""
    @Published var isLoading = false
    
    init() {
        self.pokemonList = manager.getPokemon()
    }
    
    var filteredPokemon: [PokemonModel] {
        if searchText.isEmpty {
            return pokemonList
        }
        
        return pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    func getPokemonIndex(pokemon: PokemonModel) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
    func getDetails(pokemon: PokemonModel) {
        isLoading = true
        let id = getPokemonIndex(pokemon: pokemon)
        self.pokemonDetails = PokemonDetails(id: 0, height: 0, weight: 0)
        
        manager.getDetailsPokemon(id: id) { details in
            DispatchQueue.main.async {
                self.pokemonDetails = details
                self.isLoading = false
            }
        }
    }
    
}
