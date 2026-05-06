import SwiftUI

struct Capture: View {
    @State private var client = NetworkClient()
    @State private var animate = false
    @State private var buttonVisible = true
    @State private var ballLoc = CGSize(width: 0, height: 575)
    
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
                //                .offset(x: animate ? CGFloat.random(in: -100...100) : 0)
                //                .offset(y: animate ? CGFloat.random(in: -100...100) : 0)
                .onAppear { resetAndStart() }
                .onChange(of: client.animationTrigger) { resetAndStart() }
            }
            VStack {
                Image(.pokeball)
                    .offset(ballLoc)
                    .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                        .onEnded({ value in
//                            if value.translation.height < 10 {
//                                withAnimation(
//                                    ballLoc = CGPoint(0, 0)
//                                )
//                            }
                            withAnimation(.easeInOut(duration: 0.5)){
                                ballLoc = CGSize(width: 0, height: 100)
                            }
                            withAnimation(.easeInOut(duration: 0.4).delay(0.5)){
                                ballLoc = CGSize(width: 0, height: 260)
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(0.9)){
                                ballLoc = CGSize(width: 0, height: 150)
                            }
                            withAnimation(.easeInOut(duration: 0.3).delay(1.2)){
                                ballLoc = CGSize(width: 0, height: 260)
                            }
                        }))
                Spacer()
                Button("Launch Pokemon") {
                    Task {
                        await client.getRandomPokemon()
                        ballLoc = CGSize(width: 0, height: 575)
                        buttonVisible = false
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
