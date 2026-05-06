import SwiftUI

struct Capture: View {
    @State private var client = NetworkClient()
    @State private var animate = false
    @State private var buttonVisible = true
    @State private var ballLoc = CGSize(width: 0, height: 575)
    @State private var ballScale = 1.0
    @State private var capturing = false
    
    var body: some View {
        ZStack {
            Image(.battlePlatform)
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
                //                .offset(x: animate ? CGFloat.random(in: -100...100) : 0)
                //                .offset(y: animate ? CGFloat.random(in: -100...100) : 0)
                .onAppear { resetAndStart() }
                .onChange(of: client.animationTrigger) { resetAndStart() }
            }
            VStack {
                Image(.pokeball)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(ballLoc)
                    .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                        .onEnded({ value in
                            withAnimation(.easeInOut(duration: 0.8)){
                                ballLoc = CGSize(width: 0, height: 100)
                            }
                            withAnimation(.easeInOut(duration: 0.4).delay(0.8)){
                                ballLoc = CGSize(width: 0, height: 280)
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(1.2)){
                                ballLoc = CGSize(width: 0, height: 150)
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(1.5)){
                                ballLoc = CGSize(width: 0, height: 320)
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(1.8)){
                                ballLoc = CGSize(width: 0, height: 260)
                                capturing = true
                            }
                            withAnimation(.easeInOut(duration: 0.2).delay(2.1)){
                                ballLoc = CGSize(width: 0, height: 300)
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(2.3)){
                                ballLoc = CGSize(width: 0, height: 400)
                            }
                        }))
                Spacer()
                Button("Launch Pokemon") {
                    Task {
                        await client.getRandomPokemon()
                        capturing = false
                        ballLoc = CGSize(width: 0, height: 575)
//                        buttonVisible = false
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
    Capture()
}
