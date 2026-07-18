# iOS Project

This project is a SwiftUI-based iOS game app that combines multiple quick-play mini games with session tracking and basic statistics. The app is designed to be fun, lightweight, and easy to run on an iPhone or iOS simulator.

## Overview

The app includes:

- A home screen with three playable game modes
- A timed tap-based game called Tap Frenzy
- A light-pattern memory game called Light It Up
- A trivia quiz game called Quiz Rush
- A stats screen with recent sessions and personal bests
- Local persistence of game session history using UserDefaults
- Optional location tracking for each saved session

## Features

### Gameplay Modes
- Tap Frenzy: Tap the button as quickly as possible while avoiding penalties and aiming for bonus points.
- Light It Up: Watch for lit cards, react quickly, and build your score across increasing levels.
- Quiz Rush: Answer multiple-choice trivia questions fetched from the Open Trivia DB API.

### Statistics
- View recent games
- See personal best scores for each mode
- Review a simple chart of completed sessions

### App Behavior
- Saves game sessions locally
- Requests location permission when the app starts
- Stores coordinates with each session when available

## Tech Stack

- SwiftUI for the user interface
- Charts for the stats visualization
- CoreLocation for location access
- URLSession for loading quiz questions from the internet
- UserDefaults for local session storage

## Project Structure

- App: app entry point and tab-based navigation
- Screens: home, stats, map, settings, and game screens
- Services: session storage, location management, and quiz API access
- Models: game mode and session data models

## Requirements

- Xcode 15 or newer
- An iPhone or iOS simulator
- Internet access for Quiz Rush
- Location permission granted on the device or simulator when prompted

## Notes

- Quiz Rush depends on internet access because it fetches data from an external API.
- If Xcode prompts for location permissions, make sure the app has a description for location access in the app target settings.
- The app currently stores session data locally on the device.

## License

This project is for educational and personal use.
