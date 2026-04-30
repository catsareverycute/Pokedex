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
    
    private let totalPokemon = 151
    
    func getRandomPokemon() {
        let randomID = Int.random(in: 1...totalPokemon)

        let urlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(randomID).png"
   
        self.pokemonImageURL = URL(string: urlString)
    }
}
