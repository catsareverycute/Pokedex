//
//  PokeInfo.swift
//  Pokedex
//
//  Created by Student on 4/29/26.
//


//POKEINFO UI
import SwiftUI

struct PokeInfo: View {
    let pokemon: PokemonData
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            
            Text(pokemon.name.capitalized)
                .font(.largeTitle).bold()
            
            HStack {
                ForEach(pokemon.types, id: \.type.name) { typeEntry in
                    Text(typeEntry.type.name.uppercased())
                        .padding(8)
                        .background(Color.blue.opacity(0.2))
                        .clipShape(Capsule())
                }
            }
        }
    }
}

#Preview {
    PokeInfo(pokemon: PokemonData(
        name: "Pikachu",
        sprites: .init(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"),
        types: [
            .init(type: .init(name: "electric"))
        ]
    ))
}
