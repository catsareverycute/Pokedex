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
        VStack {
            HStack{
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.title)
                    .foregroundStyle(.red)
                TextField("Pokemon Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
