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
        Form {

            Section("Preferences") {

                Toggle(
                    "Notifications",
                    isOn: $notificationsEnabled
                )
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

            Section("Data") {
                Button(role: .destructive) {
                    showResetAlert = true
                } label: {
                    Text("Reset All Stats")
                }
            }

            Section("About") {

                Text(
                    "App settings and preferences will live here."
                )

            }

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

        notificationsEnabled = false
        challengeHour = 7
        challengeMinute = 0

        print("All game stats removed")
    }

}



#Preview {
    SettingsScreen()
}
