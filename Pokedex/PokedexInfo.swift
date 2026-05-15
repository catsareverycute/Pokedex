//
//  PokeInfo.swift
//  Pokedex
//
//  Created by Student on 4/29/26.
//

import SwiftUI

struct PokedexInfo: View {
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
                        .foregroundColor(.white)
                        .padding(8)
                        .background(typeEntry.type.name.pokemonTypeColor)
                        .clipShape(Capsule())
                }
            }
            
            HStack(spacing: 40) {
                VStack {
                    Text("\(pokemon.heightInMeters, specifier: "%.1f")m")
                        .font(.headline)
                    Text("Height").font(.caption).foregroundColor(.gray)
                }
                VStack {
                    Text("\(pokemon.weightInKilograms, specifier: "%.1f")kg")
                        .font(.headline)
                    Text("Weight").font(.caption).foregroundColor(.gray)
                }
                VStack {
                    Text("\(pokemon.base_experience)")
                        .font(.headline)
                    Text("Base XP").font(.caption).foregroundColor(.gray)
                }
            }
            VStack() {
                Text("Abilities")
                    .font(.headline)
                
                HStack {
                    ForEach(pokemon.abilities, id: \.ability.name) { entry in
                        Text(entry.ability.name.capitalized)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                            .opacity(entry.is_hidden ? 0.6 : 1.0)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    PokedexInfo(pokemon: PokemonData(
        name: "Pikachu",
        sprites: .init(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"),
        types: [
            .init(type: .init(name: "electric"))
        ],
        height: 4,
        weight: 60,
        base_experience: 112,
        abilities: [.init(ability: .init(name: "static"), is_hidden: false),
        .init(ability: .init(name: "lightning-rod"), is_hidden: true)]
    ))
}
