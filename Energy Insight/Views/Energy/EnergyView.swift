// EnergyView.swift
import SwiftUI
import Charts

struct DailyEnergy: Identifiable {
    let id = UUID()
    let day: String
    let kwh: Double
}

struct EnergyView: View {
    let weeklyData: [DailyEnergy] = [
        DailyEnergy(day: "Sen", kwh: 142.5),
        DailyEnergy(day: "Sel", kwh: 138.2),
        DailyEnergy(day: "Rab", kwh: 155.8),
        DailyEnergy(day: "Kam", kwh: 149.3),
        DailyEnergy(day: "Jum", kwh: 161.4),
        DailyEnergy(day: "Sab", kwh: 98.7),
        DailyEnergy(day: "Min", kwh: 87.1),
    ]

    var todayKwh: Double { weeklyData.last?.kwh ?? 0 }
    var yesterdayKwh: Double { weeklyData.dropLast().last?.kwh ?? 0 }
    var averageKwh: Double { weeklyData.map(\.kwh).reduce(0, +) / Double(weeklyData.count) }
    var diffFromYesterday: Double { todayKwh - yesterdayKwh }

    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemBackground).ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // Gradient Header
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(
                            colors: [
                                Color(red: 0.1, green: 0.4, blue: 0.9),
                                Color(red: 0.2, green: 0.7, blue: 0.9),
                                Color(.systemBackground)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottom
                        )
                        .frame(height: 200)
                        .ignoresSafeArea()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Energy")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundStyle(.white)
                            Text("Konsumsi Listrik Harian")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.8))
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }

                    // Konten Energy
                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            StatCard(
                                title: "Hari Ini",
                                value: String(format: "%.1f", todayKwh),
                                unit: "kWh",
                                icon: "bolt.fill",
                                color: .blue
                            )
                            StatCard(
                                title: "Rata-rata",
                                value: String(format: "%.1f", averageKwh),
                                unit: "kWh",
                                icon: "chart.line.uptrend.xyaxis",
                                color: .orange
                            )
                        }

                        CompareCard(
                            today: todayKwh,
                            yesterday: yesterdayKwh,
                            diff: diffFromYesterday
                        )

                        ChartCard(weeklyData: weeklyData, average: averageKwh)
                    }
                    .padding()
                    .padding(.bottom, 100)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

// MARK: - Stat Card
struct StatCard: View {
    let title: String
    let value: String
    let unit: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(color)
                    .font(.subheadline)
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                Text(unit)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

// MARK: - Compare Card
struct CompareCard: View {
    let today: Double
    let yesterday: Double
    let diff: Double

    var isHigher: Bool { diff > 0 }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("vs Kemarin")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack(alignment: .lastTextBaseline, spacing: 4) {
                    Image(systemName: isHigher ? "arrow.up.right" : "arrow.down.right")
                        .foregroundStyle(isHigher ? .red : .green)
                        .fontWeight(.semibold)
                    Text(String(format: "%.1f kWh", abs(diff)))
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(isHigher ? .red : .green)
                }
                Text(isHigher ? "lebih boros dari kemarin" : "lebih hemat dari kemarin")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Label("Kemarin", systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(String(format: "%.1f kWh", yesterday))
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

// MARK: - Chart Card
struct ChartCard: View {
    let weeklyData: [DailyEnergy]
    let average: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("7 Hari Terakhir")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)

            Chart {
                ForEach(weeklyData) { data in
                    LineMark(
                        x: .value("Hari", data.day),
                        y: .value("kWh", data.kwh)
                    )
                    .foregroundStyle(.blue)
                    .interpolationMethod(.catmullRom)

                    AreaMark(
                        x: .value("Hari", data.day),
                        y: .value("kWh", data.kwh)
                    )
                    .foregroundStyle(.blue.opacity(0.1))
                    .interpolationMethod(.catmullRom)

                    PointMark(
                        x: .value("Hari", data.day),
                        y: .value("kWh", data.kwh)
                    )
                    .foregroundStyle(.blue)
                    .symbolSize(40)
                }

                RuleMark(y: .value("Rata-rata", average))
                    .foregroundStyle(.orange.opacity(0.7))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(position: .top, alignment: .trailing) {
                        Text("Avg")
                            .font(.caption2)
                            .foregroundStyle(.orange)
                    }
            }
            .frame(height: 200)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
