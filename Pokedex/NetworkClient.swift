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
    var currentPokemon: PokemonData? = nil
    var animationTrigger = false
    
    func getRandomPokemon() async {
        let randomID = Int.random(in: 1...1028)

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomID)/") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(PokemonData.self, from: data)
            await MainActor.run {
                self.currentPokemon = decodedData
                self.animationTrigger.toggle()
            }
        }
        catch {
            print(error)
        }
    }
}
