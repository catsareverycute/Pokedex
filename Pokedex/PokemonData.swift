//
//  PokemonData.swift
//  Pokedex
//
//  Created by Student on 5/1/26.
//

import Foundation
import SwiftUI

struct PokemonData: Codable {
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let height: Int
    let weight: Int
    let base_experience: Int
    let abilities: [AbilityElement]
   
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
    
    struct AbilityElement: Codable {
        let ability: Species
        let is_hidden: Bool
    }
}

extension String {
    var pokemonTypeColor: Color {
        switch self.lowercased() {
        case "normal": return Color(red: 0.65, green: 0.65, blue: 0.47)
        case "fire": return Color(red: 0.94, green: 0.50, blue: 0.19)
        case "water": return Color(red: 0.39, green: 0.56, blue: 0.94)
        case "electric": return Color(red: 0.97, green: 0.82, blue: 0.17)
        case "grass": return Color(red: 0.48, green: 0.78, blue: 0.30)
        case "ice": return Color(red: 0.59, green: 0.85, blue: 0.84)
        case "fighting": return Color(red: 0.76, green: 0.18, blue: 0.16)
        case "poison": return Color(red: 0.63, green: 0.24, blue: 0.63)
        case "ground": return Color(red: 0.89, green: 0.73, blue: 0.40)
        case "flying": return Color(red: 0.66, green: 0.58, blue: 0.94)
        case "psychic": return Color(red: 0.98, green: 0.33, blue: 0.53)
        case "bug": return Color(red: 0.65, green: 0.73, blue: 0.10)
        case "rock": return Color(red: 0.71, green: 0.63, blue: 0.24)
        case "ghost": return Color(red: 0.44, green: 0.34, blue: 0.61)
        case "dragon": return Color(red: 0.43, green: 0.21, blue: 0.98)
        case "dark": return Color(red: 0.44, green: 0.34, blue: 0.27)
        case "steel": return Color(red: 0.72, green: 0.72, blue: 0.81)
        case "fairy": return Color(red: 0.84, green: 0.52, blue: 0.70)
        default: return Color.gray
        }
    }
    
    var pokemonBgColor: Color {
        switch self.lowercased() {
        case "normal":   return Color(red: 0.82, green: 0.82, blue: 0.80)
        case "fire":     return Color(red: 0.97, green: 0.82, blue: 0.55)
        case "water":    return Color(red: 0.68, green: 0.78, blue: 0.88)
        case "electric": return Color(red: 0.98, green: 0.90, blue: 0.70)
        case "grass":    return Color(red: 0.78, green: 0.90, blue: 0.70)
        case "ice":      return Color(red: 0.85, green: 0.93, blue: 0.95)
        case "fighting": return Color(red: 0.78, green: 0.55, blue: 0.45)
        case "poison":   return Color(red: 0.80, green: 0.65, blue: 0.80)
        case "ground":   return Color(red: 0.90, green: 0.85, blue: 0.72)
        case "flying":   return Color(red: 0.80, green: 0.75, blue: 0.88)
        case "psychic":  return Color(red: 0.99, green: 0.75, blue: 0.70)
        case "bug":      return Color(red: 0.80, green: 0.85, blue: 0.70)
        case "rock":     return Color(red: 0.83, green: 0.78, blue: 0.65)
        case "ghost":    return Color(red: 0.68, green: 0.65, blue: 0.78)
        case "dragon":   return Color(red: 0.68, green: 0.67, blue: 0.88)
        case "dark":     return Color(red: 0.65, green: 0.60, blue: 0.58)
        case "steel":    return Color(red: 0.88, green: 0.88, blue: 0.93)
        case "fairy":    return Color(red: 0.93, green: 0.80, blue: 0.88)
        default:         return Color(red: 0.88, green: 0.86, blue: 0.88)
        }
    }

}
