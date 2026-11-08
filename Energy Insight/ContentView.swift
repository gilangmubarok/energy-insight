// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack(alignment: .bottom) {

            Group {
                if selectedTab == 0 {
                    CCTVListView()
                } else {
                    EnergyView()
                }
            }
            .ignoresSafeArea()

            HStack(spacing: 0) {
                Button {
                    selectedTab = 0
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "video.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(selectedTab == 0 ? .blue : .white)
                        if selectedTab == 0 {
                            Text("CCTV")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal, selectedTab == 0 ? 20 : 18)
                    .padding(.vertical, 12)
                    .background(selectedTab == 0 ? Color(.systemGray5) : Color.clear)
                    .clipShape(Capsule())
                }

                Button {
                    selectedTab = 1
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(selectedTab == 1 ? .yellow : .white)
                        if selectedTab == 1 {
                            Text("Energy")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal, selectedTab == 1 ? 20 : 18)
                    .padding(.vertical, 12)
                    .background(selectedTab == 1 ? Color(.systemGray5) : Color.clear)
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color(.systemGray6).opacity(0.95))
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
            )
            .padding(.horizontal, 40)
            .padding(.bottom, 30)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}
