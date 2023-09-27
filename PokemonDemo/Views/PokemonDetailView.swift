//
//  PokemonDetailView.swift
//  PokemonDemo
//
//  Created by FAMM on 27/09/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject var vm: ViewModel
    let pokemon: PokemonModel
    
    var body: some View {
        VStack {
            PokemonView(pokemon: pokemon)
            
            if vm.pokemonDetails != nil {            
                VStack(spacing: 10) {
                    Text("**ID**: \(vm.pokemonDetails?.id ?? 0)")
                    Text("**Altura**: \(vm.pokemonDetails?.height ?? 0) Mts")
                    Text("**Peso**: \(vm.pokemonDetails?.weight ?? 0) KG")
                }
            }
            
        }
        .onAppear {
            vm.getDetails(pokemon) { error in
                print("error")
            }
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: PokemonModel.example)
            .environmentObject(ViewModel())
    }
}
