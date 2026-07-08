//
//  MainTabView.swift
//  Ios-project
//
//  Created by student3 on 2026-07-08.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeScreen()
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Home", systemImage: "gamecontroller")
            }


            NavigationStack {
                StatsScreen()
                    .navigationTitle("Stats")
                    .navigationBarTitleDisplayMode(.inline)
            }

            .tabItem {
                Label("Stats", systemImage: "chart.bar")
            }

            

            NavigationStack {
                MapScreen()
                    .navigationTitle("Map")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Map", systemImage: "map")
            }


            // navi

            NavigationStack {
                SettingsScreen()
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        
        
        
        }
    }
}

#Preview {
    MainTabView()
}


// Scroll down to Custom iOS Target Properties.

// Click the + button and add:

// Privacy - Location When In Use Usage Description

// Value:

// This app needs your location to save completed game sessions.
