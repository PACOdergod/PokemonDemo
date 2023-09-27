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
    let index: Int
    private let urlImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    
    var body: some View {
        let urlString = "\(urlImage)\(vm.getPokemonIndex(pokemon: pokemon)).png"
        VStack {
            AsyncImage(url: URL(string: urlString)) { image in
                if let image = image {
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                }
            } placeholder: {
                ProgressView()
                    .frame(width: 140, height: 140)
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
        PokemonView(pokemon: PokemonModel.example, index: 1)
            .environmentObject(ViewModel())
    }
}
