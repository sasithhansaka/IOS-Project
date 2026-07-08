//
//  GameSessionService.swift
//  Ios-project
//
//  Created by student3 on 2026-07-08.
//

import Foundation

class GameSessionService {

    static let shared = GameSessionService()

    private let key = "gameSessions"

    func loadSessions() -> [GameSession] {

        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }

        return (try? JSONDecoder().decode([GameSession].self, from: data)) ?? []

    }


    func saveSession(_ session: GameSession) {

        var sessions = loadSessions()

        sessions.append(session)

        if let encoded = try? JSONEncoder().encode(sessions) {

            UserDefaults.standard.set(encoded, forKey: key)

        }
    }

    func saveSession(
        mode: GameMode,
        score: Int,
        locationService: LocationService    ){

        let latitude = locationService.hasLocation ? locationService.latitude : 0
        let longitude = locationService.hasLocation ? locationService.longitude : 0

         let sessiondata = GameSession(
              id: UUID(),
            mode: mode,
            score: score,
            timestamp: Date(),
            latitude: latitude,
            longitude: longitude
         )
        saveSession(sessiondata)
        }

}
