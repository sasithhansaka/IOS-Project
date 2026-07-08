import SwiftUI
import MapKit

struct MapScreen: View {

    @State private var sessions: [GameSession] = []

    @State private var position: MapCameraPosition = .automatic

    // Stores currently selected pin
    @State private var selectedSession: GameSession?


    var body: some View {

        ZStack {

            Map(position: $position) {

                ForEach(sessions) { session in

                    Annotation(
                        session.mode.rawValue,
                        coordinate: CLLocationCoordinate2D(
                            latitude: session.latitude,
                            longitude: session.longitude
                        )
                    ) {

                        Button {

                            // When pin tapped
                            selectedSession = session

                        } label: {

                            Image(systemName: "gamecontroller.fill")
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                    }
                }
            }


            VStack {

                Text("Completed Games Map")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .padding(.top,20)


                Spacer()


                // Show selected game details
                if let session = selectedSession {

                    VStack(spacing: 8) {

                        Text(session.mode.rawValue)
                            .font(.headline)

                        Text("Score: \(session.score)")
                            .font(.title2.bold())


                        Text(
                            session.timestamp.formatted(
                                date: .abbreviated,
                                time: .shortened
                            )
                        )
                        .font(.caption)


                        Button("Close") {

                            selectedSession = nil

                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(15)
                    .padding()

                }

            }

        }

        .onAppear {

            sessions = GameSessionService.shared
                .loadSessions()
                .filter {
                    $0.latitude != 0 &&
                    $0.longitude != 0
                }

        }

    }
}


#Preview {
    MapScreen()
}
