//
//  ContentView.swift
//  Pokedex
//
//  Created by Student on 4/28/26.
//

import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    var body: some View {
        ZStack{
            Image(.pokemonBackgrounds)
                .resizable()
                .frame(width: .infinity, height: .infinity)
                .ignoresSafeArea()
            VStack {
                Image(.pokemonLogo)
                    .resizable()
                    .scaledToFit()
                HStack{
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title)
                        .foregroundStyle(.red)
                    TextField("Pokemon Name", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                //Switch between pokeinfo and capture screen
                PokeInfo()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
