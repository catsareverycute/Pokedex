//
//  NetworkClient.swift
//  Pokedex
//
//  Created by Student on 4/30/26.
//

import SwiftUI
import Foundation

@Observable
class NetworkClient {
    private(set) var pokemonImageURL: URL? = nil
    var animationTrigger = false
    
    private let totalPokemon = 1025
    
    func getRandomPokemon() async {
        let randomID = Int.random(in: 1...totalPokemon)

        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)/"
        guard let url = URL(string: urlString) else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(PokemonData.self, from: data)
            await MainActor.run {
                self.pokemonImageURL = URL(string: decodedData.sprites.front_default)
                self.animationTrigger.toggle()
            }
        }
        catch {
            print(error)
        }
    }
}
