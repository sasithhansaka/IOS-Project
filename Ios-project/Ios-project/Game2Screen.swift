//
//  Game2Screen.swift
//  Ios-project
//
//  Created by student3 on 2026-06-13.
//

import SwiftUI
internal import Combine

 struct Game2Screen: View {

     @AppStorage("highScore") private var highScore = 0

 @State  private var gamescore=0
 @State private var timeRemain=10
 @State private var isGameRunning=true
 @State private var isPanalty = false
 @State private var FinalScore = false
 @State private var isNewHighScore=false
 @State private var isGoldenButton = false

 private let GTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


     var body: some View {
             VStack(spacing: 10){
                 
                 
                 
        
                 
                
                

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
 }


#Preview {
    Game2Screen()
}


