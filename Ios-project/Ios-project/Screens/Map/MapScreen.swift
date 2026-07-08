import SwiftUI
import MapKit

struct MapScreen: View {

    @State private var sessions: [GameSession] = []

    @State private var position: MapCameraPosition = .automatic

    // Stores currently selected pin
    @State private var selectedSession: GameSession?


    var body: some View {

        ZStack (alignment: .bottom) {

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


          if let session = selectedSession {
                            VStack(alignment: .leading, spacing: 12) {
//                                HStack {
//                                    Text("Game Details")
//                                        .font(.headline.bold())
//                                        .foregroundColor(.white)
//
//                                    Spacer()
//
//                                    Button {
//                                        selectedSession = nil
//                                    } label: {
//                                        Image(systemName: "xmark")
//                                            .font(.caption.bold())
//                                            .foregroundColor(.white.opacity(0.85))
//                                            .padding(8)
//                                            .background(Color.white.opacity(0.12))
//                                            .clipShape(Circle())
//                                    }
//                                }

                                VStack(alignment: .leading, spacing: 8) {
                                    Text(session.mode.rawValue)
                                        .font(.title3.bold())
                                        .foregroundColor(.white)

                                    Text("Score: \(session.score)")
                                        .font(.headline)
                                        .foregroundColor(.white.opacity(0.95))

                                    Text(
                                        session.timestamp.formatted(
                                            date: .abbreviated,
                                            time: .shortened
                                        )
                                    )
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.75))
                                }

                                Button {
                                    selectedSession = nil
                                } label: {
                                    Text("Close")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 14)
                                        .background(Color.blue)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(18)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color(
                                    red: 37.0 / 255.0,
                                    green: 40.0 / 255.0,
                                    blue: 54.0 / 255.0
                                )
                            )
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 18)
//                                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
//                            )
                            .cornerRadius(18)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                            
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
