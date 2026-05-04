import SwiftUI

struct Capture: View {
    @State private var client = NetworkClient()
    @State private var animate = false
    
    var body: some View {
        ZStack {
            if let pokemon = client.currentPokemon {
                AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 300, height: 300)
                .onAppear { resetAndStart() }
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
    }
    func resetAndStart() {
        animate = false
        withAnimation(.linear(duration: 3.0)) {
            animate = false
        }
    }
}
    
#Preview {
    Capture()
}
