//
//  PokemonView.swift
//  PokemonDemo
//
//  Created by FAMM on 27/09/23.
//

import SwiftUI

struct PokemonView: View {
    @EnvironmentObject var vm: ViewModel
    let pokemon: PokemonModel
    private let dimensions: Double = 140
    private let urlImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(vm.getPokemonIndex(pokemon: pokemon)).png")) { image in
                if let image = image {
                    image.resizable()
                        .scaledToFit()
                        .frame(width: dimensions, height: dimensions)
                }
            } placeholder: {
                ProgressView()
                    .frame(width: dimensions, height: dimensions)
            }
            .background(.thinMaterial)
            .clipShape(Circle())
            
            Text("\(pokemon.name.capitalized)")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
                .padding(.bottom, 20)
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemon: PokemonModel.example)
            .environmentObject(ViewModel())
    }
}
