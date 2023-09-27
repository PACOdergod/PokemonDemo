//
//  PokemonDetailView.swift
//  PokemonDemo
//
//  Created by FAMM on 27/09/23.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: PokemonModel
    let image: PokemonView
    
    @State var isLoading = true
    @State var pokemonDetails: PokemonDetails?
    
    var body: some View {
        VStack {
            image
            
            if !isLoading {
                VStack(spacing: 10) {
                    Text("**ID**: \(pokemonDetails?.id ?? 0)")
                    Text("**Altura**: \(pokemonDetails?.height ?? 0) Mts")
                    Text("**Peso**: \(pokemonDetails?.weight ?? 0) KG")
                }
            }
        }
        .onAppear {
            getDetails()
        }
    }
    
    func getDetails() {
        self.pokemonDetails = nil
        
        let detailsUrl = URL(string: pokemon.url)!
        
        Helpers.callApi(url: detailsUrl, model: PokemonDetails.self) { details in
            self.isLoading = false
            self.pokemonDetails = details
        } failure: { error in
            self.isLoading = false
            print("error")
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(
            pokemon: PokemonModel.example,
            image: PokemonView(pokemon: PokemonModel.example)
        )
    }
}
