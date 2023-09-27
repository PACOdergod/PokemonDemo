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
    @State var isLoading = true
    @State var pokemonDetails: PokemonDetails?
    
    var body: some View {
        VStack {
            PokemonView(pokemon: pokemon)
            
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
        let id = vm.getPokemonIndex(pokemon: pokemon) + 1
        self.pokemonDetails = nil
        
        let detailsUrl = URL(string: pokemon.url)!
        
        URLSession.shared.dataTask(with: detailsUrl) { data, response, error in
            guard let data = data else {
                if let _ = error {
                    self.isLoading = false
                    print("error")
                }
                return
            }
            
            do {
                let serverData = try JSONDecoder().decode(PokemonDetails.self, from: data)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.pokemonDetails = serverData
                }
            } catch {
                self.isLoading = false
                print("error")
            }
        }.resume()
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: PokemonModel.example)
            .environmentObject(ViewModel())
    }
}
