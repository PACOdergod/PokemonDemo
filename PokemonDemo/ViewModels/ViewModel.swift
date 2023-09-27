//
//  ViewModel.swift
//  PokemonDemo
//
//  Created by FAMM on 26/09/23.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    private let url = URL(string:"https://pokeapi.co/api/v2/pokemon")!
    
    @Published var pokemonList = [PokemonModel]()
    @Published var pokemonDetails: PokemonDetails?
    @Published var searchText = ""
    @Published var isLoading = true
    @Published var indexPokemonSelected: Int?
    
//    init() {
//        self.pokemonList = manager.getPokemon()
//    }
    
    func getPokemonList(onError: @escaping (Error)->Void) {
        isLoading = true
        
        Helpers.callApi(url: url, model: PokemonPage.self) { data in
            self.pokemonList = data.results
            self.isLoading = false
        } failure: { error in
            self.isLoading = false
            print(error)
        }
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
    
}
