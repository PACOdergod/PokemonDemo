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
    
    private var totalPokemonList = [PokemonModel]()
    
    @Published var pokemonList = [PokemonModel]()
    @Published var searchText = "" {
        didSet {
            filterPokemon()
        }
    }
    @Published var isLoading = true
    @Published var error: Error?
    
    init() {
        self.getPokemonList()
    }
    
    func getPokemonList() {
        isLoading = true
        
        Helpers.callApi(url: url, model: PokemonPage.self) { data in
            self.totalPokemonList = data.results
            self.pokemonList = data.results
            self.isLoading = false
        } failure: { error in
            self.isLoading = false
            print(error)
        }
    }
    
    private func filterPokemon() {
        if searchText.isEmpty {
            self.pokemonList = totalPokemonList
        } else {
            self.pokemonList = totalPokemonList.filter {
                $0.name.contains(searchText.lowercased())
            }
        }
    }
    
    func getPokemonIndex(pokemon: PokemonModel) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
}
