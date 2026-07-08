//
//  GameSession.swift
//  Ios-project
//
//  Created by student3 on 2026-07-08.
//

import Foundation

struct GameSession: Identifiable, Codable {
    let id: UUID
    let mode: GameMode
    let score: Int
    let timestamp: Date
    let latitude: Double
    let longitude: Double
}
