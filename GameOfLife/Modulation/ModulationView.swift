//
//  ContentView.swift
//  GameOfLife
//
//  Created by Илья Дубенский on 11.05.2023.
//

import SwiftUI

struct ModulationView: View {

    // MARK: - Observed Properties
    @ObservedObject private var game = GameOfLife(rows: 40, columns: 30)

    // MARK: - State Properties
    @State private var isRunning = false
    @State private var showLegend = false
    @State private var seconds = 0
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var previousScale: CGFloat = 1.0
    @State private var currentScale: CGFloat = 1.0

    // MARK: - Private Properties
    private let timer = Timer.publish(every: 1,
                                      on: .main,
                                      in: .common).autoconnect()
    private let minimumScale: CGFloat = 0.9
    private let maximumScale: CGFloat = 3.0

    // MARK: - Computed Properties
    private var timerText: String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return "Время: \(String(format: "%02d:%02d", minutes, seconds))"
    }

    private var liveElements: Int {
        var count = 0

        for row in game.grid {
            for element in row {
                count += element ? 1 : 0
            }
        }

        return count
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            BackView()
            VStack {
                // Info
                HStack {
                    VStack(alignment: .leading) {
                        Text(timerText)
                            .font(.headline)
                            .foregroundColor(Color.black)
                        Text("Население: " + liveElements.description)
                            .font(.headline)
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )

                // Grid
                GeometryReader { geometry in
                    ScrollView([.horizontal, .vertical]) {
                        GridView(game: game)
                            .scaleEffect(scale)
                            .offset(offset)
                            .onReceive(timer) { _ in
                                updateGame()
                            }
                            .onDisappear {
                                isRunning = false
                                seconds = 0
                                DispatchQueue.global().async {
                                    game.newGame()
                                }
                            }
                            .frame(width: geometry.size.width * scale * currentScale,
                                   height: geometry.size.height * scale * currentScale)                    .scrollIndicators(.hidden)
                            .gesture(zoomAndScrollGesture)
                    }
                }

                // Buttons
                VStack {
                    Button(action: {
                        game.randomizeGrid()
                    }) {
                        Text("Случайное заполнение")
                            .frame(width: 200, height: 20)
                            .padding()
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    HStack {
                        Button(action: {
                            isRunning = false
                            seconds = 0
                            DispatchQueue.global().async {
                                game.newGame()
                            }
                        }) {
                            Text("Новая игра")
                                .frame(width: 100, height: 20)
                                .padding()
                                .background(liveElements == 0 ? .gray : .red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(liveElements == 0)
                        Spacer()
                        Button(action: {
                            isRunning.toggle()
                        }) {
                            Text(isRunning ? "Стоп" : "Старт")
                                .frame(width: 100, height: 20)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
            }
            .padding()
            .navigationBarTitle("Модуляция", displayMode: .inline)
            .navigationBarItems(trailing: modulationButton)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarColorScheme(ColorScheme.light, for: .navigationBar)
            .foregroundColor(.black)
        }
    }

    private func updateGame() {
        guard isRunning else { return }

        DispatchQueue.global(qos: .background).async {
            game.nextGeneration()
            let currentLiveElements = liveElements

            DispatchQueue.main.async {
                seconds += 1
                if currentLiveElements == 0 {
                    isRunning = false
                }
            }
        }
    }

    private var modulationButton: some View {
        NavigationLink(destination: LegendView()) {
            Text("К легенде")
        }
    }

    private var zoomAndScrollGesture: some Gesture {
        SimultaneousGesture(
            MagnificationGesture()
                .onChanged { value in
                    let newScale = previousScale * value.magnitude
                    currentScale = min(maximumScale, max(minimumScale, newScale))
                }
                .onEnded { _ in
                    previousScale = currentScale
                    scale = 1.0
                },
            DragGesture()
                .onChanged { value in
                    offset.width += value.translation.width
                    offset.height += value.translation.height
                }
                .onEnded { value in
                    offset = .zero
                }
        )
    }
}

// MARK: - Preview
struct ModulationView_Previews: PreviewProvider {
    static var previews: some View {
        ModulationView()
    }
}
