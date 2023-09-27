//
//  ContentView.swift
//  PokemonDemo
//
//  Created by FAMM on 26/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    
    private let adaptativeColums = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptativeColums, spacing: 10) {
                    ForEach(vm.filteredPokemon) {pokemon in
                        NavigationLink {
                            PokemonDetailView(pokemon: pokemon)
                        } label: {
                            PokemonView(pokemon: pokemon)
                        }

                    }
                    
                }
            }
            .searchable(text: $vm.searchText)
        }
        .environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
