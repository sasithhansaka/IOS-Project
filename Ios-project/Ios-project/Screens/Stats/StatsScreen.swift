//
//  StatsScreen.swift
//  Ios-project
//
//  Created by student3 on 2026-07-08.
//

import SwiftUI
import Charts

struct StatsScreen: View {

    // @State private var sessions: [GameSession] = []
    
    @Environment(\.scenePhase) private var scenePhase


    @State private var sessions: [GameSession] = []

    var body: some View {
        ScrollView {
            VStack {
                 VStack {
                    Text("Game Statistics")
                        // .padding(.bottom ,10)
                             .foregroundStyle(Color.white)
                             .font(.system(size: 32, weight: .regular))


                    // Text("A quick view of completed games, best scores, and recent runs.")
                    //     .font(.subheadline)
                    //     .foregroundStyle(.secondary)
                }

                recentGamesSection


            VStack {
            Text("Personal Bests")
                .font(.title2.bold())

            StatCard(
                title: "Tap Frenzy",
                value: "\(tapFrenzyHighscore)"
            )
            StatCard(
                title: "Light It Up",
                value: "\(lightItUpHighscore)"
            )
            StatCard(
                title: "Quiz Rush",
                value: "\(quizRushHighscore)"
            )
            }

            chartSection
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
       }
        .onAppear {
                    loadSessions()
                }
                .onChange(of: scenePhase) {
                    if scenePhase == .active {
                        loadSessions()
                    }
                }
            }

            private func loadSessions() {
                sessions = GameSessionService.shared
                    .loadSessions()
                    .sorted { $0.timestamp > $1.timestamp }
            }

    private var tapFrenzyHighscore:Int {
        sessions
            .filter { $0.mode == .tapFrenzy }
            .map { $0.score }
            .max() ?? 0
    }


    private var lightItUpHighscore:Int {
        sessions
            .filter { $0.mode == .lightItUp  }
            .map { $0.score }
            .max() ?? 0
    }


    private var quizRushHighscore:Int {
            sessions
                .filter { $0.mode == .quizRush }
                .map { $0.score }
                .max() ?? 0
    }

    private var recentGames: [GameSession] {
    Array(sessions.prefix(5))
}


    private var chartSessions: [GameSession] {
        sessions.sorted { $0.timestamp < $1.timestamp }
    }

    

    private var recentGamesSection: some View {
    VStack() {

        Text("Recent Games")
            .font(.title2.bold())

        if recentGames.isEmpty {

            Text("No games played yet.")
                .foregroundStyle(.secondary)

        } else {

            VStack() {

                ForEach(recentGames) { game in

                    HStack {

                        VStack() {

                            Text(game.mode.rawValue)
   .font(.caption)
                .foregroundStyle(.secondary)
                            Text(
                                game.timestamp.formatted(
                                    date: .abbreviated,
                                    time: .shortened
                                )
                            )
                            .font(.caption)
                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text("\(game.score)")
                            .font(.title3.bold())
                    }
                    // .padding()
                    // .background(Color.gray.opacity(0.12))
                    // .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
    }
}

    private var chartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Session Chart")
                .font(.title2.bold())

            if chartSessions.isEmpty {
                Text("Add a few completed games to see the chart.")
                    .foregroundStyle(.secondary)
            } else {
                Chart {
                    ForEach(chartSessions) { session in
                        BarMark(
                            x: .value("Mode", session.mode.rawValue),
                            y: .value("Score", session.score)
                        )
                        .foregroundStyle(by: .value("Mode", session.mode.rawValue))
                        .position(by: .value("Session", session.id.uuidString))
                    }
                }
                .chartXAxisLabel("Mode")
                .chartYAxisLabel("Score")
                .frame(height: 260)
            }
        }
    }
}

private struct StatCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack() {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.title2.bold())
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        // .frame(maxWidth: .infinity, alignment: .leading)
        // .padding()
        // .background(Color.gray.opacity(0.12))
        // .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    StatsScreen()
}
