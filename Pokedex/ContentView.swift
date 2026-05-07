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
            switch currentScreen {
            case .start:
                VStack {
                    Image(.pokemonLogo)
                        .resizable()
                        .scaledToFit()
                    
                    Button(action: {currentScreen = .capture}) {
                        Text("Capture Pokemon")
                            .font(.headline)
                    }
                    Button(action: {currentScreen = .pokedex}) {
                        Text("View Pokedex")
                            .font(.headline)
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
