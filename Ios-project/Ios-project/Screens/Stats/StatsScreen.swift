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
        ZStack {
            Color(
                red: 37.0 / 255.0,
                green: 40.0 / 255.0,
                blue: 54.0 / 255.0
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Game Statistics")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .padding(.top ,30)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Personal Bests")
                            .font(.headline.bold())
                            .foregroundColor(.white)

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
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        Color(
                            red: 47.0 / 255.0,
                            green: 50.0 / 255.0,
                            blue: 66.0 / 255.0
                        )
                    )
                    // .overlay(
                    //     RoundedRectangle(cornerRadius: 14)
                    //         .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    // )
                    .cornerRadius(14)

                    recentGamesSection

                    chartSection
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            }
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
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Games")
                .font(.headline.bold())
                .foregroundColor(.white)

            if recentGames.isEmpty {
                Text("No games played yet.")
                    .foregroundStyle(.white)

            } else {
                VStack(spacing: 10) {
                    ForEach(recentGames) { game in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(game.mode.rawValue)
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                Text(
                                    game.timestamp.formatted(
                                        date: .abbreviated,
                                        time: .shortened
                                    )
                                )
                                .font(.caption)
                                .foregroundStyle(.white)
                            }

                            Spacer()

                            Text("\(game.score)")
                                .font(.title3.bold())
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white.opacity(0.04))
                        .cornerRadius(12)
                    }
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(
                red: 47.0 / 255.0,
                green: 50.0 / 255.0,
                blue: 66.0 / 255.0
            )
        )
        .foregroundColor(.white)
        .cornerRadius(14)
}

    private var chartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Session Chart")
                .font(.headline.bold())
                .foregroundColor(.white)

            if chartSessions.isEmpty {
                Text("Add a few completed games to see the chart.")
                    .foregroundStyle(.white)
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
                .chartXAxisLabel {
                    Text("Mode")
                        .foregroundStyle(.white)
                }                .chartYAxisLabel("Score")
                .frame(height: 260)
//                .foregroundColor(.white)
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            .white .opacity(0.8)
        )
        .cornerRadius(14)
    }
}

private struct StatCard: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.white)

            Text(value)
                .font(.title2.bold())
                // .lineLimit(1)
                // .minimumScaleFactor(0.8)
                .foregroundStyle(.white)
            }

            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)

        .frame(maxWidth: .infinity, alignment: .leading)

        .background(Color.white.opacity(0.04))
        // .overlay(
        //     RoundedRectangle(cornerRadius: 12)
        //         .stroke(Color.white.opacity(0.08), lineWidth: 1)
        // )
        .cornerRadius(12)
    }
}

#Preview {
    StatsScreen()
}
