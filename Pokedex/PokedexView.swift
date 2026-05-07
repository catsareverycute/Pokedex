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
        NavigationStack {
            List(pokedex.caughtPokemon, id: \.name) { pokemon in
                NavigationLink(pokemon.name.capitalized) {
                    PokeInfo(pokemon: pokemon)
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
