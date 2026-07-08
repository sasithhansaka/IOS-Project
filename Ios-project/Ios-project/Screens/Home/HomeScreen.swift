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
                .padding(.top ,30)
//                .padding(.bottom, 120)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Text("Pick a game, read the challenge, and start playing. Every mode is designed to be quick, fun, and easy to jump into whenever you have a free moment.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
                .lineSpacing(4)
                .padding(.top ,5)
                .padding(.bottom ,10)
            
            
            

//                Image("banner")
//                       .resizable()
////                       .scaledToFit()
//                       .frame(width: 120, height: 180)
//                       .padding(.bottom, 50)
//                       .clipShape(Circle())
//
                       

            
            VStack(spacing: 18) {
                
                NavigationLink(destination: Game1Screen()) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Tap Frenzy")
                        //                            .frame(width: 200, height: 60)
                            .font(.headline)
                        //                            .background(Color.blue)
                            .foregroundColor(.white)
                        //                            .cornerRadius(10)
                        
                        Text("Tap fast and stay focused to score higher.")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.85))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 18)
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                //                .padding(.horizontal)
                
                NavigationLink(destination: GameTwoScreen()) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Light It Up")
                        //                            .frame(width: 200, height: 60)
                            .font(.headline)
                        //                            .background(Color.blue)
                            .foregroundColor(.white)
                        //                            .cornerRadius(10)
                        
                        Text("Match the lights before time runs out.")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.85))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 18)
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                
                NavigationLink(destination: QuizRushScreen()) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Quiz Rush")
                        //                            .frame(width: 200, height: 60)
                            .font(.headline)
                        //                            .background(Color.blue)
                            .foregroundColor(.white)
                        //                            .cornerRadius(10)
                        
                        Text("Answer quickly and keep your streak alive.")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.85))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 18)
                    .background(Color.blue)
                    .cornerRadius(12)
                }
            }
            
//            NavigationLink(destination: StatsScreen()) {
//                VStack(alignment: .leading, spacing: 6) {
//                    Text("Quiz Rush")
//                    //                            .frame(width: 200, height: 60)
//                        .font(.headline)
//                    //                            .background(Color.blue)
//                        .foregroundColor(.white)
//                    //                            .cornerRadius(10)
//                    
//                    Text("Answer quickly and keep your streak alive.")
//                        .font(.subheadline)
//                        .foregroundColor(.white.opacity(0.85))
//                    
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.vertical, 16)
//                .padding(.horizontal, 18)
//                .background(Color.blue)
//                .cornerRadius(12)
//            }
//            
        
            
          
//                .padding(.bottom ,30)

            
            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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
