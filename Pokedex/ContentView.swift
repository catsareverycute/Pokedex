//
//  ContentView.swift
//  Pokedex
//
//  Created by Student on 4/28/26.
//

import SwiftUI

enum AppScreen {
    case start
    case capture
    case pokedex
}
struct ContentView: View {
    @State private var name: String = ""
    @State private var client = NetworkClient()
    @State private var currentScreen: AppScreen = .start
    @State private var pokedexManager = PokedexManager()
    
    var body: some View {
        ZStack{
            Image(.pokemonBackgrounds)
                .resizable()
                .ignoresSafeArea()
                .frame(width: 410, height: 800)
            switch currentScreen {
            case .start:
                VStack {
                    Image(.pokemonLogo)
                        .resizable()
                        .scaledToFit()
                    
                    Button(action: {currentScreen = .capture}) {
                        Text("Capture Pokemon")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 240, height: 50)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
                            )
                            .shadow(radius: 5)
                    }
                    Button(action: {currentScreen = .pokedex}) {
                        Text("View Pokedex")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 240, height: 50)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
                            )
                            .shadow(radius: 5)
                    }
                    /*HStack{
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title)
                            .foregroundStyle(.white, .red)
                        TextField("Pokemon Name", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 300, height: 50)
                            .padding()
                    } */
                    //Switch between pokeinfo and capture screen
                    //                PokeInfo()
                }
            case .capture:
                Capture(currentScreen: $currentScreen, pokedex: pokedexManager)
            case .pokedex: PokedexView(currentScreen: $currentScreen, pokedex: pokedexManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
