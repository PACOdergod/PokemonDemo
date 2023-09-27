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
    
    func filterPokemon() -> [PokemonModel] {
        if searchText.isEmpty {
            return pokemonList
        }
        
        return pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    init() {
        self.pokemonList = manager.getPokemon()
        print(pokemonList)
    }
}
