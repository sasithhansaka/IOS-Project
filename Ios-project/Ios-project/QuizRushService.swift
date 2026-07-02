//
//  QuizRushService.swift
//  Ios-project
//
//  Created by student3 on 2026-07-02.
//

import Foundation


struct QuizloadAPI  {
    
    static func fetchQuestions() async throws -> [APIQuestion] {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&type=multiple") else {
            throw URLError(.badURL)
        }
        
       
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(TriviaResponse.self, from: data)
        
        return response.results.map { item in
            APIQuestion(
                question: item.question,
                
                
                correctAnswer: item.correct_answer,
                answers: (item.incorrect_answers + [item.correct_answer]).shuffled()
            )
        }
    }
}


struct APIQuestion {
let question: String
let correctAnswer: String
let answers: [String]
}

struct TriviaResponse: Codable {
let results: [TriviaQuestion]
}

struct TriviaQuestion: Codable {
let question: String
let correct_answer: String
let incorrect_answers: [String]
}
