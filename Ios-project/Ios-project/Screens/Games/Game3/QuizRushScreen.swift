import SwiftUI
// import Foundation


struct QuizRushScreen: View {
    
    @State private var currentIndex = 0
    @State private var Score = 0
    @State private var Streakpoints = 0
    @State private var AlltimeStreak = 0

    @State private var correctlyAnswered = 0
    @State private var Loading =  false
    //   @State private var Errormessage=""
    @State private var Isfinished = false
    @State private var AnswerLocked = false
    
    @State private var feedbackMessage = ""
    @State private var IsCorrectANswer = false
    
    @State private var questions: [APIQuestion] = []
    @State private var Errormessage=""
    
    @State private var  Userselectanswer = ""
    
    
    
    var body: some View {
        
        VStack{
            //            topBar
            
            if Loading{
                Spacer()
                Text("Loading...")
                    .foregroundColor(.white)
                Spacer()
                
            } else if !Errormessage.isEmpty{
                VStack(){
                    Text(Errormessage)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Button("Retry"){
                        loadQuiz()
                    }
                    .frame(width: 120, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                }
            }else if Isfinished{
                VStack(){
                    Text("Quiz Finished!")
                        .foregroundStyle(
                            Color (
                                red :255.0 / 255.0,
                                green: 255.0 / 255.0,
                                blue: 0.0 / 255.0
                            )
                        )
                    
                        .padding(.bottom , 60)
                        .font(.system(size: 40, weight: .medium))
                    
                    Text("Final Score \(Score)")
                        .foregroundStyle(.white)
                        .padding(.bottom ,10)
                        .font(.system(size: 26, weight: .medium))
                    
                    
                    
                    Text("Correct Answers \(correctlyAnswered)/\(questions.count)")
                        .foregroundStyle(.white)
                        .padding(.bottom ,10)
                        .font(.system(size: 26, weight: .medium))
                    
                    
                    Text("Best Streak \(AlltimeStreak)")
                        .foregroundStyle(.white)
                        .padding(.bottom ,10)
                        .font(.system(size: 26, weight: .medium))
                    
                    
                    
                    
                    Button("Retry") {
                        loadQuiz()
                    }
                    
                    .frame(width: 140, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    //                    .padding(.trailing ,50)
                    //                        .padding(.bottom , )
                    
                }
            }
            
            else if questions.indices.contains(currentIndex) {
                let question = questions[currentIndex]
                
                
                VStack (){
                    
                    HStack(){
                        Button("Play Again") {
                            loadQuiz()
                        }
                        .frame(width: 100, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.trailing ,50)
                        //                        .padding(.bottom , )
                        
                        
                        Text("Score \(Score)  |  Streak \(Streakpoints)")
                            .foregroundStyle(.white)
                    }
                    
                    .padding(.bottom ,50)
                    
                    
                    
                    Text(question.question)
                        .font(.system(size: 18, weight: .light))
                        .foregroundStyle(.white)
                        .padding(.bottom ,30)
                        .padding(.horizontal,5)
                    
                    VStack(){
                        ForEach(question.answers, id: \.self) { answer in
                            Button {
                                answerTapped(answer)
                            } label: {
                                Text(answer)
                                    .frame(width: 250, height: 30)
                                    .font(.system(size: 20, weight: .regular))
                                    .padding()
                                    .background(ButtonColor(for: answer))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            .disabled(AnswerLocked)
                        }
                    }
                    
                    //                    Text(feedbackMessage)
                    //                        .foregroundColor(IsCorrectANswer ? .green : .red)
                    //                        .font(.headline)
                    
                    //                    if !feedbackMessage.isEmpty {
                    //                        Text(feedbackMessage)
                    //                            .foregroundColor(IsCorrectANswer ? .green : .red)
                    //                            .font(.headline)
                    //                    }
                }
            }
            
            if !Loading && !Isfinished && questions.indices.contains(currentIndex) {
                Text("Question \(currentIndex + 1) of \(questions.count)")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.top ,50)
            }
            
            
            
            
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(24)
        .background(
            Color (
                red: 37.0 / 255.0,
                green: 40.0 / 255.0,
                blue: 54.0 / 255.0
            )
            .ignoresSafeArea()
        )
        
        .onAppear{
            if questions.isEmpty && !Loading{
                loadQuiz()
            }
        }
    }
    
    //    private var topBar: some View{
    //        HStack(alignment: .top){
    //            Button("Play Again") {
    //                loadQuiz()
    //            }
    //            .frame(width: 110, height: 40)
    //            .background(Color.blue)
    //            .foregroundColor(.white)
    //            .cornerRadius(10)
    //        }
    //    }
    
    private func ButtonColor(for answer: String)-> Color{
        if !AnswerLocked{
            return .blue
        }
        
        if answer == Userselectanswer {
            return IsCorrectANswer ? .green : .red
        }
        
        return .blue
        
    }
    
    private func loadQuiz(){
        Loading = true
        Errormessage = ""
        Isfinished = false
        AnswerLocked = false
        feedbackMessage = ""
        
        
        questions = []
        currentIndex = 0
        Score = 0
        Streakpoints = 0
        AlltimeStreak = 0
        correctlyAnswered = 0
        
        //
        
        Task{
            do {
                let fetchedquestions = try await QuizloadAPI.fetchQuestions()
                
                await MainActor.run{
                    questions = fetchedquestions
                    Loading = false
                }
            }
            catch{
                await MainActor.run{
                    Errormessage = "Failed to load questions. Please check your internet connection and try again."
                    Loading = false
                }
            }
        }
    }
    
    private func answerTapped(_ answer: String){
        
        guard !AnswerLocked, questions.indices.contains(currentIndex) else { return }
        
        AnswerLocked = true
        Userselectanswer = answer
        
        
        let question = questions[currentIndex]
        let isCorrect = answer == question.correctAnswer
        
        if isCorrect{
            Score += 1 + Streakpoints
            
            Streakpoints += 1
            correctlyAnswered += 1
            
            feedbackMessage = "Correct!"
            IsCorrectANswer = true
        } else {
            Score = max(0,Score - 1)
            feedbackMessage = "Incorrect!"
            IsCorrectANswer = false
            Streakpoints = 0
        }
        
        if Streakpoints > AlltimeStreak{
            AlltimeStreak = Streakpoints
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            feedbackMessage = ""
            IsCorrectANswer = false
            currentIndex += 1
            AnswerLocked = false
            
            if currentIndex >= questions.count {
                Isfinished = true
            }
        }
        
    }
}

#Preview {
    QuizRushScreen()
}

