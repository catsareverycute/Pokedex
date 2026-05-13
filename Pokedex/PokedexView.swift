//
//  PokedexView.swift
//  Pokedex
//
//  Created by Student on 5/7/26.
//

import SwiftUI

struct PokedexView: View {
    @Binding var currentScreen: AppScreen
    var pokedex: PokedexManager

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: { currentScreen = .start }) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    Spacer()
                }
                Spacer()
            }
            .zIndex(1)
            
            NavigationStack {
                List(pokedex.caughtPokemon, id: \.name) { pokemon in
                    NavigationLink(pokemon.name.capitalized) {
                        PokedexInfo(pokemon: pokemon)
                    }
                }
                .navigationTitle("Captured Pokemon")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Home") {
                            currentScreen = .start
                        }
                    }
                }
            }
        }
    }
}
