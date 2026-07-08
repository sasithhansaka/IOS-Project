//
//  SettingsScreen.swift
//  Ios-project
//
//  Created by student3 on 2026-07-08.
//
import SwiftUI


struct SettingsScreen: View {

    @AppStorage("notificationsEnabled")
    private var notificationsEnabled = false

        @AppStorage("challengeHour")
        private var challengeHour = 7

    @AppStorage("challengeMinute")
    private var challengeMinute = 0

    @State private var showResetAlert = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(
                red: 37.0 / 255.0,
                green: 40.0 / 255.0,
                blue: 54.0 / 255.0
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 12) {
                Text("Settings")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.top ,10)

                Text("Manage notifications, challenge time, and your saved game data from one place.")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.6))
//                    .lineSpacing(2)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Preferences")
                        .font(.headline.bold())
                        .foregroundColor(.white)

                    Toggle(
                        "Notifications",
                        isOn: $notificationsEnabled
                    )
                    .tint(.blue)
                    .foregroundColor(.white)
                    .onChange(of: notificationsEnabled) { enabled in
                        if enabled {
                            NotificationService.shared
                                .requestPermission()
                            
                            scheduleNotification()
                        } else {
                            NotificationService.shared
                                .removeDailyNotification()

                        }

                    }

                    DatePicker(
                        "Daily Challenge Time",
                        selection: challengeTimeBinding,
                        displayedComponents: .hourAndMinute
                    )
                    .disabled(!notificationsEnabled)
                    .foregroundColor(.white)
                    .onChange(of: challengeHour) { _ in

                        if notificationsEnabled {
                            scheduleNotification()
                        }

                    }
                    .onChange(of: challengeMinute) { _ in

                        if notificationsEnabled {
                            scheduleNotification()
                        }

                    }
                }
                .padding(14)
                .padding(.top ,20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    Color(
                        red: 47.0 / 255.0,
                        green: 50.0 / 255.0,
                        blue: 66.0 / 255.0
                    )
                )
               
                .cornerRadius(14)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Reset The Data")
                        .font(.headline.bold())
                        .foregroundColor(.white)

                    Button {
                        showResetAlert = true
                    } label: {
                        Text("Reset All Stats")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(.blue
                            )
                            .cornerRadius(12)
                    }
                }
                .padding(14)
//                .padding(.top ,20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    Color(
                        red: 47.0 / 255.0,
                        green: 50.0 / 255.0,
                        blue: 66.0 / 255.0
                    )
                )
//                .overlay(
//                    RoundedRectangle(cornerRadius: 14)
//                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
//                )
                .cornerRadius(14)
                .padding(.top ,20)

//                VStack(alignment: .leading, spacing: 8) {
//                    Text("About")
//                        .font(.headline.bold())
//                        .foregroundColor(.white)

//                .cornerRadius(14)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(20)
        }

        .alert(
            "Reset Statistics?",
            isPresented: $showResetAlert
        ) {
            Button(
                "Cancel",
                role: .cancel
            ) { }
            Button(
                "Reset",
                role: .destructive
            ) {
                resetAllStats()
            }
        } message: {
            Text(
                "This will delete all saved game sessions and scores."
            )
        }
        .onAppear {

            if notificationsEnabled {

                scheduleNotification()
            }

        }

    }

    private var challengeTimeBinding: Binding<Date> {
        Binding(
            
            get: {
                Calendar.current.date(
                          bySettingHour: challengeHour,
                    minute: challengeMinute,
                    
                    second: 0,
                    
                    of: Date()
                ) ?? Date()
            },
            set: { newDate in

                    let calendar = Calendar.current
                    challengeHour = calendar.component(
                        .hour,
                        from: newDate
                    )
                challengeMinute = calendar.component(
                    .minute,
                    from: newDate
                )
            }
        )
    }

    private func scheduleNotification() {
        NotificationService.shared
            .scheduleDailyNotification(
                hour: challengeHour,
                minute: challengeMinute
            )

    }

    private func resetAllStats() {

        UserDefaults.standard
            .removeObject(
                forKey: "gameSessions"
            )
        UserDefaults.standard
            .removeObject(
                forKey: "game1highScore"
            )
        UserDefaults.standard
            .removeObject(
                forKey: "game2highScore"
            )

        UserDefaults.standard
            .removeObject(
                forKey: "game3highScore"
            )

        UserDefaults.standard
            .removeObject(
                forKey: "notificationsEnabled"
            )

        UserDefaults.standard
            .removeObject(
                forKey: "challengeHour"
            )

            UserDefaults.standard
                .removeObject(
                    forKey: "challengeMinute"
                )
            NotificationService.shared
                .removeDailyNotification()

//        notificationsEnabled = false
        notificationsEnabled = false

        challengeHour = 7
        challengeMinute = 0

        print("All game stats removed")
    }

}



#Preview {
    SettingsScreen()
}
