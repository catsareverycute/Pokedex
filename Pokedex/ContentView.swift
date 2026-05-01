//
//  ContentView.swift
//  Pokedex
//
//  Created by Student on 4/28/26.
//

import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    @State private var client = NetworkClient()
    @State private var animate = false
    
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
            ZStack {
                if let url = client.pokemonImageURL {
                    AsyncImage(url: url) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150, height: 150)
                    .opacity(animate ? 0 : 1)
                    .offset(x: animate ? CGFloat.random(in: -100...100) : 0)
                    .offset(y: animate ? CGFloat.random(in: -100...100) : 0)
                    .onAppear { resetAndStart() }
                    .onChange(of: client.animationTrigger) { resetAndStart() }
                }
                VStack {
                    Spacer()
                    Button("Launch Pokemon") {
                        Task {
                             await client.getRandomPokemon()
                         }
                     }
                     .onAppear {
                         Task {
                             await client.getRandomPokemon()
                         }
                     }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 50)
                }
                .frame(maxWidth: .infinity)
            }
        }
    func resetAndStart() {
        animate = false
        withAnimation(.linear(duration: 3.0)) {
            animate = true
        }
    }
}

#Preview {
    ContentView()
}
