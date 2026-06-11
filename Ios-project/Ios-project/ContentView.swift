//
//  ContentView.swift
//  Ios-project
//
//  Created by student3 on 2026-06-06.
//



import SwiftUI

struct ContentView: View {
    @AppStorage("highScore") private var highScore = 0

    @State private var score = 0
    @State private var timeRemaining = 10
    @State private var isGameRunning = true
    @State private var isPenaltyTap = false
    @State private var showFinalScore = false
    @State private var isNewHighScore = false

    private let gameTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 24) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Score: \(score)")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("High Score: \(highScore)")
                        .font(.headline)

                    if isNewHighScore {
                        Text("High Score!")
                            .font(.headline)
                            .foregroundStyle(.green)
                    }
                }

                Spacer()

                Button("Play Again") {
                    resetGame()
                }
                .font(.headline)
            }

            Spacer()

            if showFinalScore {
                VStack(spacing: 8) {
                    Text("Time's Up!")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Final Score: \(score)")
                        .font(.title2)
                }
            }

            Button {
                handleTap()
            } label: {
                Text(isPenaltyTap ? "-2" : "TAP")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: buttonSize, height: buttonSize)
                    .background(isPenaltyTap ? Color.red : Color.blue)
                    .clipShape(Circle())
            }
            .disabled(!isGameRunning)
            .opacity(isGameRunning ? 1 : 0.5)

            if isPenaltyTap {
                Text("Red tap gives -2 points")
                    .foregroundStyle(.red)
            } else {
                Text("Blue tap gives +1 point")
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text("Time: \(timeRemaining)")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .padding(24)
        .onReceive(gameTimer) { _ in
            guard isGameRunning else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
                isPenaltyTap = Int.random(in: 1...4) == 1
            }

            if timeRemaining == 0 {
                endGame()
            }
        }
    }

    private var buttonSize: CGFloat {
        CGFloat(80 + (timeRemaining * 14))
    }

    private func handleTap() {
        if isPenaltyTap {
            score = max(0, score - 2)
        } else {
            score += 1
        }
    }

    private func resetGame() {
        score = 0
        timeRemaining = 10
        isGameRunning = true
        isPenaltyTap = false
        showFinalScore = false
        isNewHighScore = false
    }

    private func endGame() {
        isGameRunning = false
        showFinalScore = true

        if score > highScore {
            highScore = score
            isNewHighScore = true
        }
    }
}

#Preview {
    ContentView()
}


// import SwiftUI

// struct ContentView: View {

// @AppStorage ("highScore") private var highScore=0

// @State  private var gamescore=0
// @State private var timeRemain=10
// @State private var isGameRunning=true
// @State private var isPanalty = false
// @State private var FinalScore= false
// @State private var isNewHighScore=false

// private let GTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


//     var body: some View {
//             VStack(spacing: 10){
//                 HStack(alignment: .top){
//                     VStack(alignment: .leading, spacing:6){
//                         Text("Score \(gamescore)")
//                             .font(.title2)
//                             .fontWeight(.bold)

//                         // Text("High Score ")

//                         if(isNewHighScore){
//                             Text("High Score")
//                                 .font(.headline)
//                                 .foregroundStyle(.green)
//                         }
//                     }
//                     Spacer()

//                     Button("Play Again"){
//                         resetGame()
//                     }
//                     .frame(width: 100, height: 40)
//                     .font(.headline)
//                     .background(Color.blue)
//                     .foregroundColor(.white)
//                     .cornerRadius(10)
//                 }

//                 Spacer()

//                 if(FinalScore){
//                     VStack(spacing: 8){
//                         Text("Time's Up")
//                             .font(.title)
//                             .fontWeight(.bold)

//                         Text("Final Score \(gamescore)")
//                             .font(.title2)
//                     }
//                 }

//                 Button {
//                     buttonTap()
//                 } label:{
//                     Text(isPanalty ? "-1" : "TAP")
//                         .font(.system(size: 34, weight: .bold))
//                         .foregroundStyle(.white)
//                         .frame(width: updatebuttonSize, height: updatebuttonSize)
//                         .background(isPanalty ? Color.red : Color.blue)
//                         .clipShape(Circle())
//                 }
//                 .disabled(!isGameRunning)
//                 .opacity(isGameRunning ? 1 : 0.1)
                

//                 Spacer()

//                 Text("\(timeRemain)")
//                     .font(.largeTitle)
//                     .fontWeight(.bold)

//             }
//             .padding(24)

//             .onReceive(GTimer) { _ in
//             guard isGameRunning else { return }

//             if timeRemain > 0 {
//                 timeRemain -= 1
//                 isPanalty = Int.random(in: 1...4) == 1
//             }

//             if timeRemain == 0 {
//                 endGame()
//             }
//         }  
        
//     }

//     private var updatebuttonSize: CGFloat{
//         CGFloat(80 + (timeRemain * 14))
//     }

//     private func buttonTap(){
//         if isPanalty{
//             gamescore = max(0,gamescore -1);
//         }
//         else{
//             gamescore = gamescore +1;
//         } 
//     }

//     private func resetGame(){
//         gamescore=0;
//         timeRemain=10;
//         isGameRunning=true;
//         isPanalty=false;
//         FinalScore=false;
//         isNewHighScore=false;
//     }

//     private func endGame(){
//         isGameRunning = false;
//         FinalScore = true;
//         if gamescore > highScore{
//             highScore = gamescore;
//             isNewHighScore = true;
//         }
//     }

// }

#Preview {
    ContentView()
}


