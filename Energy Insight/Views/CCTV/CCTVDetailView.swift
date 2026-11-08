// CCTVDetailView.swift
import SwiftUI
import Combine
import WebKit

// MARK: - YouTube View dengan Fallback
struct YouTubeLiveView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false
        webView.backgroundColor = .black
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let html = """
        <html>
        <head>
        <meta name="referrer" content="origin">
        <style>
            * { margin:0; padding:0; box-sizing:border-box; }
            body { background:#000; width:100vw; height:100vh; overflow:hidden; }
            iframe { width:100%; height:100%; border:none; display:block; }
        </style>
        </head>
        <body>
        <iframe
            src="https://www.youtube.com/embed/\(videoID)?autoplay=1&mute=1&playsinline=1&rel=0&controls=1&modestbranding=1"
            allow="autoplay; encrypted-media; fullscreen"
            allowfullscreen>
        </iframe>
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube.com"))
    }
}

// MARK: - Simulasi CCTV Realistis
struct CCTVSimulationView: View {
    let room: CCTVRoom
    @State private var currentTime = Date()
    @State private var signalStrength = Int.random(in: 80...99)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return formatter.string(from: currentTime)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.08, green: 0.08, blue: 0.10))
                .frame(height: 220)

            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.02))
                .frame(height: 220)

            VStack(spacing: 4) {
                ForEach(0..<20, id: \.self) { _ in
                    Rectangle()
                        .fill(Color.black.opacity(0.05))
                        .frame(height: 1)
                }
            }
            .frame(height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(spacing: 8) {
                Image(systemName: "video.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(Color.white.opacity(0.15))
                Text(room.name)
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .foregroundStyle(Color.white.opacity(0.2))
            }

            VStack {
                HStack {
                    HStack(spacing: 5) {
                        LiveDotView()
                        Text("LIVE")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.red.opacity(0.85))
                    .clipShape(RoundedRectangle(cornerRadius: 4))

                    Spacer()

                    HStack(spacing: 3) {
                        Image(systemName: "wifi")
                            .font(.system(size: 10))
                            .foregroundStyle(.green)
                        Text("\(signalStrength)%")
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                            .foregroundStyle(.green)
                    }
                }
                .padding(10)

                Spacer()

                HStack {
                    Text("CAM • \(room.name.uppercased())")
                        .font(.system(size: 10, weight: .medium, design: .monospaced))
                        .foregroundStyle(Color.white.opacity(0.7))
                    Spacer()
                    Text(timeString)
                        .font(.system(size: 10, weight: .medium, design: .monospaced))
                        .foregroundStyle(Color.white.opacity(0.7))
                }
                .padding(10)
                .background(Color.black.opacity(0.4))
            }
            .frame(height: 220)
        }
        .onReceive(timer) { _ in
            currentTime = Date()
            if Int(Date().timeIntervalSince1970) % 5 == 0 {
                signalStrength = Int.random(in: 80...99)
            }
        }
    }
}

// MARK: - Animasi dot LIVE
struct LiveDotView: View {
    @State private var isBlinking = false

    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: 6, height: 6)
            .opacity(isBlinking ? 0.2 : 1.0)
            .animation(.easeInOut(duration: 0.8).repeatForever(), value: isBlinking)
            .onAppear { isBlinking = true }
    }
}

// MARK: - CCTV Detail View
struct CCTVDetailView: View {
    let room: CCTVRoom
    @State private var isACOn: Bool = false
    @State private var temperature: Double = 24
    @State private var showYouTube: Bool = true

    // Ganti video ID sesuai kebutuhan
    let videoID = "JJ3MWNYVCU4"

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                // Video Feed
                if room.isOnline {
                    ZStack(alignment: .bottomTrailing) {

                        if showYouTube {
                            YouTubeLiveView(videoID: videoID)
                                .frame(height: 220)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        } else {
                            CCTVSimulationView(room: room)
                        }

                        // Tombol toggle YouTube / Simulasi
                        Button {
                            showYouTube.toggle()
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: showYouTube ? "display" : "play.rectangle.fill")
                                    .font(.system(size: 10))
                                Text(showYouTube ? "Simulasi" : "YouTube")
                                    .font(.system(size: 10, weight: .medium))
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.black.opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .padding(10)
                    }
                    .padding(.horizontal)

                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.08, green: 0.08, blue: 0.10))
                            .frame(height: 220)
                        VStack(spacing: 8) {
                            Image(systemName: "video.slash.fill")
                                .font(.system(size: 44))
                                .foregroundStyle(.secondary)
                            Text("Camera Offline")
                                .font(.system(size: 13, design: .monospaced))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.horizontal)
                }

                // AC Control Card
                VStack(spacing: 0) {
                    HStack {
                        Label("AC Control", systemImage: "air.conditioner.horizontal.fill")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        Toggle("", isOn: $isACOn)
                            .labelsHidden()
                    }
                    .padding()

                    Divider().padding(.horizontal)

                    VStack(spacing: 12) {
                        HStack {
                            Text("Suhu")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("\(Int(temperature))°C")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(isACOn ? .blue : .secondary)
                        }
                        Slider(value: $temperature, in: 16...30, step: 1)
                            .tint(.blue)
                            .disabled(!isACOn)
                    }
                    .padding()
                    .opacity(isACOn ? 1 : 0.4)
                }
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.horizontal)

                // Status Cards
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 6) {
                        Label("Kamera", systemImage: "video.fill")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(room.isOnline ? "Online" : "Offline")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(room.isOnline ? .green : .red)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                    VStack(alignment: .leading, spacing: 6) {
                        Label("AC", systemImage: "thermometer")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(isACOn ? "Menyala" : "Mati")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(isACOn ? .blue : .secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle(room.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}
