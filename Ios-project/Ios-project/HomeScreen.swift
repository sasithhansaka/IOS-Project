import SwiftUI

struct HomeScreen: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("Home Screen")
                    .font(.largeTitle)
                    .bold()
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
                
                NavigationLink(destination: Game1Screen()) {
                    Text("Game 1")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                NavigationLink(destination: Game2Screen()) {
                    Text("Game 2")
                        .frame(width: 100, height: 40)
                        .font(.headline)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(24)
            .background(
               Color (
                   red: 37.0 / 255.0,
                   green: 40.0 / 255.0,
                   blue: 54.0 / 255.0
                   )
            )
        }
        .frame(maxWidth: .infinity)
//        .padding()
            }
}

#Preview {
    HomeScreen()
}
