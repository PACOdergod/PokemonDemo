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
    private let url = URL(string:"https://pokeapi.co/api/v2/pokemon/")!
    
    @Published var pokemonList = [PokemonModel]()
    @Published var pokemonDetails: PokemonDetails?
    @Published var searchText = ""
    @Published var isLoading = true
    @Published var indexPokemonSelected: Int?
    
    init() {
        self.pokemonList = manager.getPokemon()
    }
    
    func getPokemonList(onError: @escaping (Error)->Void) {
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    onError(error)
                }
                return
            }
            
            do {
                let serverData = try JSONDecoder().decode(PokemonPage.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonList = serverData.results
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                onError(error)
            }
        }.resume()
    }
    
    var filteredPokemon: [PokemonModel] {
        if searchText.isEmpty {
            return pokemonList
        }
        
        return pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    func selectPokemon(_ pokemon: PokemonModel) {
        self.indexPokemonSelected = self.pokemonList.firstIndex(of: pokemon)
    }
    
    func getPokemonIndex(pokemon: PokemonModel) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
    func getDetails(onError: @escaping (Error)->Void) {
        isLoading = true
        let id = (self.indexPokemonSelected ?? 0) + 1
        self.pokemonDetails = nil
        
        let detailsUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/")!
        
        URLSession.shared.dataTask(with: detailsUrl) { data, response, error in
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    onError(error)
                }
                return
            }
            
            do {
                let serverData = try JSONDecoder().decode(PokemonDetails.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonDetails = serverData
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                onError(error)
            }
        }.resume()
    }
    
}
