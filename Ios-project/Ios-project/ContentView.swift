import SwiftUI
internal import Combine

 struct ContentView: View {

     @AppStorage("highScore") private var highScore = 0

 @State  private var gamescore=0
 @State private var timeRemain=10
 @State private var isGameRunning=true
 @State private var isPanalty = false
 @State private var FinalScore = false
 @State private var isNewHighScore=false

 private let GTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


     var body: some View {
             VStack(spacing: 10){
                 HStack(alignment: .top){
                     VStack(alignment: .leading, spacing:6){
                         Text("Score  \(gamescore)")
                             .font(.system(size: 30, weight: .light)
//                             .fontWeight(.bold)
                             )
                             .foregroundStyle(.white)
                             
                              
                             

                         // Text("High Score ")

                         
                     }
                     Spacer()

                     Button("Play Again"){
                         resetGame()
                     }
                     .frame(width: 100, height: 40)
                     .font(.headline)
                     .background(Color.blue)
                     .foregroundColor(.white)
                     .cornerRadius(10)
                 }
                 
                 
        
                 
                 if(FinalScore){
                     if(isNewHighScore){
                         Text("High Score")
                             .foregroundStyle(
                                Color (
                                    red :255.0 / 255.0,
                                    green: 255.0 / 255.0,
                                    blue: 0.0 / 255.0
                                )
                             )
                             .padding(.top , 50)
                             .font(.system(size: 40, weight: .light))
//                             .onAppear{
//                                 withAnimation(.easeInOut(duration: 1)){
//                                     .font(.system(size: 32, weight: .bold))
//                                     
//                                 }
//                             }
                             
                     }
                 }

                 Spacer()
                 
                 if(FinalScore){
                     VStack(spacing: 8){
                         Text("Time's Up")
//                             .font(.title)
//                             .fontWeight(.bold)
                             .padding(.bottom ,10)
                             .foregroundStyle(Color.white)
                             .font(.system(size: 32, weight: .regular))

                         Text("Final Score \(gamescore)")
                             .font(.system(size: 36 , weight: .regular))
                             .padding(.bottom , 10)
                             .foregroundStyle(Color.white)
                             
                     }
                     .padding(.bottom , 40)
                     
                 }

                 Button {
                     buttonTap()
                 } label:{
                     Text(isPanalty ? "-1" : "TAP")
                         .font(.system(size: updateTextsize, weight: .bold))
                         .foregroundStyle(.white)
                         .frame(width: updatebuttonSize, height: updatebuttonSize)
                         .background(isPanalty ? Color.red : Color.blue)
                         .clipShape(Circle())
                 }
                 .disabled(!isGameRunning)
                 .opacity(isGameRunning ? 1 : 0.1)
                

                 Spacer()

                 Text("\(timeRemain)")
                     .font(.system(size: 48, weight: .bold))
//                     .fontWeight(.bold)
                     .padding(.bottom ,20)
                     .foregroundStyle(Color.white)
                     .opacity(isGameRunning ? 1 : 0.1)

             }
             .padding(24)
             .background(
                Color (
                    red: 37.0 / 255.0,
                    green: 40.0 / 255.0,
                    blue: 54.0 / 255.0
                    )
             )

             .onReceive(GTimer) { _ in
             guard isGameRunning else { return }

             if timeRemain > 0 {
                 timeRemain -= 1
                 isPanalty = Int.random(in: 1...4) == 1
             }

             if timeRemain == 0 {
                 endGame()
             }
         }
        
     }

     private var updatebuttonSize: CGFloat{
         CGFloat(80 + (timeRemain * 14))
     }
     
     private var updateTextsize: CGFloat{
         CGFloat(32 + (timeRemain * 2))
     }

     private func buttonTap(){
         if isPanalty{
             gamescore = max(0,gamescore - 1)
         }
         else{
             gamescore = gamescore + 1
         }
     }

     private func resetGame(){
         gamescore=0;
         timeRemain=10;
         isGameRunning=true;
         isPanalty=false;
         FinalScore=false;
         isNewHighScore=false;
     }

     private func endGame(){
         isGameRunning = false;
         FinalScore = true;
         if gamescore > highScore{
             highScore = gamescore;
             isNewHighScore = true;
         }
     }

 }

#Preview {
    ContentView()
}


