//
//  CCTVListView.swift
//  Energy Insight
//

import SwiftUI

struct CCTVRoom: Identifiable {
    let id = UUID()
    let name: String
    let isOnline: Bool
}

struct CCTVFloor: Identifiable {
    let id = UUID()
    let floor: Int
    let rooms: [CCTVRoom]
}

struct CCTVListView: View {

    let floors: [CCTVFloor] = [
        CCTVFloor(floor: 2, rooms: [
            CCTVRoom(name: "R 201", isOnline: true),
            CCTVRoom(name: "R 202", isOnline: true),
            CCTVRoom(name: "R 203", isOnline: false),
            CCTVRoom(name: "R 204", isOnline: true),
            CCTVRoom(name: "R 205", isOnline: true),
            CCTVRoom(name: "LabKom 2", isOnline: true),
        ]),
        CCTVFloor(floor: 3, rooms: [
            CCTVRoom(name: "R 301", isOnline: true),
            CCTVRoom(name: "R 302", isOnline: false),
            CCTVRoom(name: "R 303", isOnline: true),
            CCTVRoom(name: "R 304", isOnline: true),
            CCTVRoom(name: "R 305", isOnline: false),
            CCTVRoom(name: "LabKom 3", isOnline: true),
        ]),
        CCTVFloor(floor: 4, rooms: [
            CCTVRoom(name: "R 401", isOnline: true),
            CCTVRoom(name: "R 402", isOnline: true),
            CCTVRoom(name: "R 403", isOnline: true),
            CCTVRoom(name: "R 404", isOnline: false),
            CCTVRoom(name: "R 405", isOnline: true),
            CCTVRoom(name: "LabKom 4", isOnline: false),
        ]),
        CCTVFloor(floor: 5, rooms: [
            CCTVRoom(name: "R 501", isOnline: false),
            CCTVRoom(name: "R 502", isOnline: true),
            CCTVRoom(name: "R 503", isOnline: true),
            CCTVRoom(name: "R 504", isOnline: true),
            CCTVRoom(name: "R 505", isOnline: false),
            CCTVRoom(name: "LabKom 5", isOnline: true),
        ]),
        CCTVFloor(floor: 6, rooms: [
            CCTVRoom(name: "R 601", isOnline: true),
            CCTVRoom(name: "R 602", isOnline: true),
            CCTVRoom(name: "R 603", isOnline: false),
            CCTVRoom(name: "R 604", isOnline: true),
            CCTVRoom(name: "R 605", isOnline: true),
            CCTVRoom(name: "LabKom 6", isOnline: true),
        ]),
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        NavigationStack {

            ZStack(alignment: .top) {

                Color(.systemBackground).ignoresSafeArea()

                ScrollView {

                    VStack(alignment: .leading, spacing: 0) {

                        // Gradient Header
                        ZStack(alignment: .bottomLeading) {

                            LinearGradient(
                                colors: [
                                    Color(red: 0.6, green: 0.2, blue: 0.8),
                                    Color(red: 0.9, green: 0.4, blue: 0.2),
                                    Color(.systemBackground)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottom
                            )
                            .frame(height: 200)
                            .ignoresSafeArea()

                            VStack(alignment: .leading, spacing: 4) {

                                Text("CCTV")
                                    .font(.system(size: 34, weight: .bold))
                                    .foregroundStyle(.white)

                                Text("Monitoring Ruangan")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        }

                        // Grid Ruangan
                        VStack(alignment: .leading, spacing: 24) {

                            ForEach(floors) { floor in

                                VStack(alignment: .leading, spacing: 12) {

                                    Text("Lantai \(floor.floor)")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal)

                                    LazyVGrid(columns: columns, spacing: 12) {

                                        ForEach(floor.rooms) { room in

                                            NavigationLink(destination: CCTVDetailView(room: room)) {

                                                CCTVCard(room: room)

                                            }
                                            .buttonStyle(.plain)

                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.vertical)
                        .padding(.bottom, 100)
                    }
                }
                .ignoresSafeArea(edges: .top)
            }
        }
    }
}

struct CCTVCard: View {

    let room: CCTVRoom

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            ZStack {

                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.secondarySystemFill))
                    .frame(height: 100)

                Image(systemName: room.isOnline ? "video.fill" : "video.slash.fill")
                    .font(.system(size: 26))
                    .foregroundStyle(
                        room.isOnline ?
                        .white.opacity(0.6) :
                        .white.opacity(0.2)
                    )

                VStack {

                    HStack {

                        Spacer()

                        Circle()
                            .fill(room.isOnline ? .green : .red)
                            .frame(width: 8, height: 8)
                            .padding(8)
                    }

                    Spacer()
                }
            }

            Text(room.name)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
