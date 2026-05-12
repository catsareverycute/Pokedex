import SwiftUI

struct Capture: View {
    @Binding var currentScreen: AppScreen
    var pokedex: PokedexManager
    @State private var client = NetworkClient()
    @State private var ballLoc = CGSize(width: 0, height: 575)
    @State private var ballScale: CGFloat = 1.0
    @State private var animate = false
    @State private var buttonVisible = true
    @State private var capturing = false
    @State private var changeSize = false
    
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
                    .scaledToFit()
//                    .scaleEffect(imageScale)
                    .frame(width: changeSize ? 80 : 100)
                    .offset(ballLoc)
                    .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                        .onEnded({ value in
                            withAnimation(.easeInOut(duration: 0.5)){
                                ballLoc = CGSize(width: 0, height: 100)
                            }
                            withAnimation(.easeInOut(duration: 0.6).delay(0.5)){
                                changeSize = true
                                ballLoc = CGSize(width: 0, height: 300)
                            }
                            withAnimation(.easeInOut(duration: 0.5).delay(1.2)){
                                ballLoc = CGSize(width: 0, height: 150)
                            }
                            withAnimation(.easeInOut(duration: 0.4).delay(1.7)){
                                ballLoc = CGSize(width: 0, height: 320)
                            }
                            withAnimation(.easeInOut(duration: 0.4).delay(2.1)){
                                ballLoc = CGSize(width: 0, height: 230)
                                
                                if let caughtPokemon = client.currentPokemon {
                                    pokedex.caughtPokemon.append(caughtPokemon)
                                }
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(2.4)){
                                ballLoc = CGSize(width: 0, height: 280)
                                capturing = true
                            }
                            withAnimation(.easeInOut(duration: 0.4).delay(2.7)){
                                ballLoc = CGSize(width: 0, height: 400)
                                buttonVisible = true
                            }
                        }))
                Spacer()
                Button("Launch Pokemon") {
                    Task {
                        changeSize = false
                        await client.getRandomPokemon()
                        capturing = false
                        ballLoc = CGSize(width: 0, height: 575)
                        withAnimation(.easeInOut(duration: 0.4)){
                            buttonVisible = false
                        }
                    }
                }
                .disabled(!buttonVisible)
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
    Capture(currentScreen: .constant(.capture), pokedex: PokedexManager())
}
