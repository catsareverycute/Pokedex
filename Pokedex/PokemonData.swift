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
    let height: Int
    let weight: Int
    let base_experience: Int
   
    var heightInMeters: Double { Double(height) / 10.0 }
    var weightInKilograms: Double { Double(weight) / 10.0 }
    
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
