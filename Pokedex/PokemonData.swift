//
//  PokemonData.swift
//  Pokedex
//
//  Created by Student on 5/1/26.
//

struct PokemonData: Codable {
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
   
    
    struct Sprites: Codable {
        let front_default: String
    }
    
    struct TypeElement: Codable {
        let type: Species
    }
    
    struct Species: Codable {
        let name: String
    }
}
