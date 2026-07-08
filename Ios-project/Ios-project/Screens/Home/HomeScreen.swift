import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var locationService: LocationService
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Lets Play Games")
                .font(.largeTitle)
                .bold()
                .font(.title)
                .foregroundColor(Color.white)
                .padding(.top ,50)
                .padding(.bottom, 120)
            
//                Image("banner")
//                       .resizable()
////                       .scaledToFit()
//                       .frame(width: 120, height: 180)
//                       .padding(.bottom, 50)
//                       .clipShape(Circle())
//
                       

            
            
            NavigationLink(destination: Game1Screen()) {
                Text("Game 1")
                    .frame(width: 200, height: 60)
                    .font(.headline)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            NavigationLink(destination: GameTwoScreen()) {
                Text("Game 2")
                    .frame(width: 200, height: 60)
                    .font(.headline)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.bottom ,10)
            }
            .padding(.horizontal)
            
            NavigationLink(destination: QuizRushScreen()) {
                Text("Game 3")
                    .frame(width: 200, height: 60)
                    .font(.headline)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.bottom ,250)
            }
            .padding(.horizontal)
            
        
            
            Text("Developed by @Devlopment team")
                .font(.caption)
                .bold()
                .font(.title)
                .foregroundColor(Color.white)
                .padding()
                .padding(.bottom, 10)

            
            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
           Color (
               red: 37.0 / 255.0,
               green: 40.0 / 255.0,
               blue: 54.0 / 255.0
               )
        )
        .frame(maxWidth: .infinity)

        .onAppear{
            locationService.requestPermissionIfNeeded()
        }
     
//        .padding()
            }
}

#Preview {
    HomeScreen()
}
