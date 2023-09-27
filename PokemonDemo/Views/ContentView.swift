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
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(2)
            } else {
                grid
            }
        }
        .environmentObject(vm)
    }
    
    var grid: some View {
        ScrollView {
            LazyVGrid(columns: adaptativeColums, spacing: 10) {
                ForEach(vm.filteredPokemon) {pokemon in
                    let image = PokemonView(pokemon: pokemon)
                    
                    NavigationLink(destination: {
                        PokemonDetailView(pokemon: pokemon, image: image)
                    }, label: {
                        image
                    })
                    
                }
                
            }
        }
        .searchable(text: $vm.searchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
