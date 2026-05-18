import SwiftUI

struct Capture: View {
    @Binding var currentScreen: AppScreen
    var pokedex: PokedexManager
    @State private var client = NetworkClient()
    @State private var ballLoc = CGSize(width: 0, height: 575)
    @State private var ballScale: CGFloat = 1
    @State private var ballAngle = 0.0
    @State private var animate = false
    @State private var capturing = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: { currentScreen = .start }) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    Spacer()
                }
                Spacer()
            }
            .zIndex(1)
            
            Image(.battlePlatform)
                .resizable()
                .frame(width: 375, height: 500)
                .offset(x: 0, y: 40)
            if let pokemon = client.currentPokemon {
                AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 300, height: 300)
                .onAppear { resetAndStart() }
                .opacity(animate ? 0 : 1)
                .offset(x: 0, y: 0)
                .scaleEffect(y: capturing ? 0 : 1, anchor: .center)
                .onAppear { resetAndStart() }
                .onChange(of: client.animationTrigger) { resetAndStart() }
            }
            VStack {
                Image(.pokeball)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .scaleEffect(ballScale)
                    .rotationEffect(.degrees(ballAngle))
                    .offset(ballLoc)
                    .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                        .onEnded({ value in
                            withAnimation(.easeInOut(duration: 0.5)){
                                ballScale = 0.8
                                ballLoc = CGSize(width: 0, height: 80)
                            }
                            withAnimation(.linear(duration: 0.3).delay(0.5)){
                                ballScale = 0.7
                                ballLoc = CGSize(width: 0, height: 290)
                            }
                            withAnimation(.easeInOut(duration: 0.45).delay(0.8)){
                                ballLoc = CGSize(width: 0, height: 150)
                            }
                            withAnimation(.linear(duration: 0.2).delay(1.25)){
                                ballLoc = CGSize(width: 0, height: 290)
                            }
                            withAnimation(.easeInOut(duration: 0.4).delay(1.45)){
                                ballLoc = CGSize(width: 0, height: 230)
                                
                                if let caughtPokemon = client.currentPokemon {
                                    if !pokedex.caughtPokemon.contains(where: { $0.name == caughtPokemon.name }) {
                                        pokedex.caughtPokemon.append(caughtPokemon)
                                    }
                                }
                            }
                            withAnimation(.linear(duration: 0.3).delay(1.85)){
                                ballLoc = CGSize(width: 0, height: 290)
                                capturing = true
                            }
                            withAnimation(.easeInOut(duration: 0.4).delay(2.15)){
                                ballLoc = CGSize(width: 0, height: 400)
                            }
                            withAnimation(.smooth(duration: 0.3).delay(3)){
                                ballAngle = -30
                            }
                            withAnimation(.smooth(duration: 0.3).delay(3.3)){
                                ballAngle = 20
                            }
                            withAnimation(.smooth(duration: 0.3).delay(3.6)){
                                ballAngle = 0
                            }
                            Task{
                                try? await Task.sleep(for: .seconds(4))
                                await client.getRandomPokemon()
                                capturing = false
                                withAnimation(.spring()) {
                                    ballLoc = CGSize(width: 0, height: 575)
                                }
                            }
                            
                        }))
                Spacer()
            }
        }
        .onAppear {
            Task {
                await client.getRandomPokemon()
            }
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
    Capture(currentScreen: .constant(.capture), pokedex: PokedexManager())
}
