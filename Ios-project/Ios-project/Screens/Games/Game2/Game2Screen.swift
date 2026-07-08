import SwiftUI
internal import Combine
import Foundation


struct GameTwoScreen: View {

    @EnvironmentObject private var locationService: LocationService

    @AppStorage("game2highScore") private var Game2highScore = 0

    @State private var score = 0
    @State private var timeRemain = 60

    @State private var cards: [Card1] = []

    @State private var isGameRunning = true
    @State private var finalScore = false
    @State private var isNewHighScore = false

    private let gameTimer =
    Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()

    var body: some View {

        VStack(spacing: 10) {


            HStack(alignment: .top) {

                VStack(alignment: .leading) {

                    Text("Score \(score)")
                        .font(.system(size: 30, weight: .light))
                        .foregroundStyle(.white)

//                    Text("Best \(Game2highScore)")
//                        .foregroundStyle(.white)
                }

                Spacer()

                Button("Play Again") {
                    resetGame()
                }
                .frame(width: 110, height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            if finalScore && isNewHighScore {

                Text("High Score")
                    .foregroundStyle(.yellow)
                    .font(.system(size: 40, weight: .light))
                    .padding(.top, 40)
            }

            Spacer()

            

            if finalScore {

                VStack(spacing: 8) {

                    Text("Time's Up")
                        .font(.system(size: 32))
                        .foregroundStyle(.white)

                    Text("Final Score \(score)")
                        .font(.system(size: 36))
                        .foregroundStyle(.white)

                     ShareLink(
                        item: "I just scored \(score) on Light It Up — beat that!"
                    ) {
                        Label("Share Score", systemImage: "square.and.arrow.up")
                    }
                    .foregroundStyle(.white)
                }

            } else {

                Text("Level \(currentLevel)")
                    .foregroundStyle(.white)
                    .font(.title2)

                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.flexible()),
                        count: columnCount
                    ),
                    spacing: 15
                ) {

                    ForEach(cards.indices, id: \.self) { index in

                        Button {

                            cardTapped(index)

                        } label: {

                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    cards[index].isLit
                                    ? Color.yellow
                                    : Color.blue
                                )
                                .frame(height: 90)
                        }
                    }
                }
            }

            Spacer()

            Text("\(timeRemain)")
                .font(.system(size: 48, weight: .bold))
                .foregroundStyle(.white)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color(
                red: 37.0 / 255.0,
                green: 40.0 / 255.0,
                blue: 54.0 / 255.0
            )
            .ignoresSafeArea()
        )
        .onAppear {
            resetGame()
        }
        .onReceive(gameTimer) { _ in

            guard isGameRunning else { return }

            if timeRemain > 0 {

                timeRemain -= 1

                setupLevel()
            }

            if timeRemain == 0 {
                endGame()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }

    private var currentLevel: Int {

        let elapsed = 60 - timeRemain

        if elapsed < 15 {
            return 1
        } else if elapsed < 30 {
            return 2
        } else if elapsed < 45 {
            return 3
        }

        return 4
    }

    private var cardCount: Int {

        switch currentLevel {

        case 1:
            return 3

        case 2:
            return 4

        case 3:
            return 6

        default:
            return 9
        }
    }

    private var columnCount: Int {

        switch currentLevel {

        case 1:
            return 3

        case 2:
            return 2

        default:
            return 3
        }
    }

    private var lightDuration: Double {

        switch currentLevel {

        case 1:
            return 1.5

        case 2:
            return 1.2

        case 3:
            return 1.0

        default:
            return 0.8
        }
    }


    private func setupLevel() {

        if cards.count != cardCount {

            cards = (0..<cardCount).map {
                Card1(id: $0)
            }
        }
    }


    private func startLighting() {

        guard isGameRunning else { return }

        for index in cards.indices {
            cards[index].isLit = false
        }

        let litCount = currentLevel == 4 ? 2 : 1

        let randomCards =
        Array(cards.indices.shuffled().prefix(litCount))

        for index in randomCards {
            cards[index].isLit = true
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + lightDuration
        ) {

            guard isGameRunning else { return }

//            let missed = cards.contains {
//                $0.isLit
//            }
//
//            if missed {
//                score = max(0, score - 1)
//            }

            for index in cards.indices {
                cards[index].isLit = false
            }

            startLighting()
        }
    }

   

    private func cardTapped(_ index: Int) {

        guard isGameRunning else { return }

        if cards[index].isLit {

            score += 1
            cards[index].isLit = false

        } else {

            score = max(0, score - 1)
        }
    }

    private func endGame() {

        isGameRunning = false
        finalScore = true

        if score > Game2highScore {

            Game2highScore = score
            isNewHighScore = true
        }

        GameSessionService.shared.saveSession(
            mode: .lightItUp,
            score: score,
            locationService: locationService
        )
    }
    private func resetGame() {

        score = 0
        timeRemain = 60

        finalScore = false
        isNewHighScore = false
        isGameRunning = true

        setupLevel()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            startLighting()
        }
    }
}
struct Card1: Identifiable {
    let id: Int
    var isLit = false
}

#Preview {
    GameTwoScreen()
}
