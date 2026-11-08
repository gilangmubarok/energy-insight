# Energy Insight

**Smart Classroom Monitoring & Energy Management App**

Energy Insight is a SwiftUI-based iOS application concept for monitoring classroom conditions and visualizing electricity usage. The project is designed to make room monitoring more accessible and encourage more efficient energy use in educational environments.

## Overview

Many classrooms and shared learning spaces can waste electricity when lights or air conditioners are left running. Monitoring room conditions remotely can also be difficult when there is no centralized monitoring interface.

Energy Insight explores a mobile interface that brings room monitoring and energy information together in one app.

## Goals

- Make classroom monitoring easier to access from a mobile device.
- Provide a room-by-room CCTV monitoring interface.
- Present daily electricity usage in a visual format.
- Demonstrate basic room-device controls through the app interface.
- Support better awareness of energy consumption and room security.

## Features

### 1. Room Monitoring

- Displays rooms grouped by floor.
- Shows an online/offline status for each room.
- Provides a room detail screen.
- Includes an embedded YouTube video view and a simulated CCTV display as demonstration options.

### 2. Energy Usage Dashboard

- Displays daily electricity usage in kWh.
- Shows a daily value and a weekly average.
- Compares the displayed usage with the previous day.
- Visualizes weekly usage data with a chart.

### 3. Air Conditioner Control Interface

- Provides an AC on/off toggle in the room detail screen.
- Includes a temperature slider that is enabled when the AC toggle is on.

## Current Prototype Notes

This repository contains an application prototype. Some displayed information and interactions are currently demonstrations using values defined in the app source code:

- Energy usage values are sample data, not readings from a live electricity meter.
- Room online/offline statuses are currently defined in the app.
- The AC toggle and temperature slider update the interface locally; they are not connected to a physical AC unit or IoT controller.
- The CCTV screen uses a configured YouTube video embed or a simulated camera view; it is not connected to a campus CCTV system.

A backend, live sensor integration, device connectivity, and production CCTV integration are not included in the current source.

## Technology Stack

- **Swift**
- **SwiftUI** — application interface
- **Swift Charts** — energy usage visualization
- **WebKit** — embedded video view
- **Combine** — timer-driven updates in the CCTV simulation

## Project Structure

```text
Energy Insight/
├── Energy Insight.xcodeproj/
└── Energy Insight/
    ├── Energy_InsightApp.swift
    ├── ContentView.swift
    ├── Models/
    │   ├── CCTVFeed.swift
    │   ├── EnergyUsage.swift
    │   ├── Room.swift
    │   └── Components/
    │       ├── CCTVThumbnail.swift
    │       ├── EnergyChart.swift
    │       └── RoomCard.swift
    └── Views/
        ├── CCTV/
        │   ├── CCTVListView.swift
        │   └── CCTVDetailView.swift
        ├── Dashboard/
        │   └── DashboardView.swift
        └── Energy/
            └── EnergyView.swift
```

## Requirements

- macOS
- Xcode with an iOS SDK compatible with the project's deployment target
- iPhone or iPad Simulator, or a compatible iOS device

## Getting Started

1. Clone this repository:

   ```bash
   git clone https://github.com/gilangmubarok/energy-insight.git
   ```

2. Open `Energy Insight.xcodeproj` in Xcode.
3. Select an iPhone or iPad simulator (or a connected device).
4. Build and run the project.

## Future Improvements

Potential next steps for the project include:

- Connect the app to real-time energy meter data.
- Integrate room devices through an IoT or backend service.
- Add authentication and user roles.
- Connect CCTV feeds to an authorized camera system.
- Store historical energy data and provide longer-term usage reports.

## Project Information

- **Project:** Energy Insight
- **Category:** Smart Classroom Monitoring & Energy Management
- **Platform:** iOS
- **Framework:** SwiftUI
- **Author:** Gilang Mubarok

---

This project is a prototype developed to explore a mobile interface for classroom monitoring and energy management.
