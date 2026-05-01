//
//  PokemonData.swift
//  Pokedex
//
//  Created by Student on 5/1/26.
//

struct PokemonData: Codable {
    let sprites: Sprites
    
    struct Sprites: Codable {
        let front_default: String
    }
}
