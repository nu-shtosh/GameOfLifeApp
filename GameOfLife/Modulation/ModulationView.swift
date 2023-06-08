//
//  ContentView.swift
//  GameOfLife
//
//  Created by Илья Дубенский on 11.05.2023.
//

import SwiftUI

struct ModulationView: View {

    // MARK: - Observed Properties
    @ObservedObject private var game = GameOfLife(rows: 54, columns: 31)

    // MARK: - State Properties
    @State private var isRunning = false
    @State private var presentAlert = false

    @State private var offset: CGSize = .zero

    @State private var scale: CGFloat = 1.0
    @State private var previousScale: CGFloat = 1.0
    @State private var currentScale: CGFloat = 1.0

    @State private var stableGenerationCount: Int = 0
    @State private var stableLiveElementsCount: Int = 0

    @State private var timerSpeed = 0.5
    @State private var timerText = 9

    // MARK: - Private Properties
    private let minimumScale: CGFloat = 0.9
    private let maximumScale: CGFloat = 3.0

    // MARK: - Computed Properties
    private var generationText: String {
        "Поколение: " + game.generationCount.description
    }

    private var liveElementsText: String {
        "Население: " + game.liveElementsCount.description
    }

    private var speedText: String {
        "Cкорость: " + timerText.description
    }

    // MARK: - Body
    var body: some View {
        let timer = Timer.publish(every: timerSpeed,
                                  on: .main, in:
                .common).autoconnect()

        ZStack {
            BackView()
            VStack {
                // MARK: - Info Labels
                HStack {
                    Text(generationText)
                        .font(.system(size: 14, weight: .bold))
                        .frame(width: 130, alignment: .leading)
                        .lineLimit(1)

                    Text(liveElementsText)
                        .font(.system(size: 14, weight: .bold))
                        .frame(width: 120, alignment: .leading)

                    Spacer()

                    Text(speedText)
                        .font(.system(size: 14, weight: .bold))
                        .frame(width: 100, alignment: .trailing)

                }


                // MARK: - Grid
                GeometryReader { geometry in
                        GridView(game: game)
                            .scaleEffect(scale)
                            .offset(offset)
                            .onReceive(timer) { _ in
                                updateGame()
                            }
                            .onDisappear {
                                isRunning = false
                                game.newGame()
                            }
                            .frame(width: geometry.size.width * scale * currentScale,
                                   height: geometry.size.height * scale * currentScale)
                            .scrollIndicators(.hidden)
                }


                // MARK: - Randomize Button
                HStack {
                    Button(action: {
                        game.randomizeGrid()
                        isRunning = false
                        game.generationCount = 0
                    }) {
                        Image(systemName: "shuffle.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                            .foregroundColor(.black)
                    }

                    Spacer()

                    // MARK: - Clear Button
                    Button(action: {
                        isRunning = false
                        game.newGame()
                    }) {
                        Image(systemName: "trash.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                            .foregroundColor(.black)
                    }

                    Spacer()

                    // MARK: - Speed Buttons
                    Button(action: {
                        if timerSpeed < 0.9 {
                            timerSpeed += 0.05
                            timerText -= 1
                        }
                    }) {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                    }
                    .disabled(timerSpeed > 0.9)
                    .foregroundColor(timerSpeed < 0.9 ? .black : .gray)

                    Button(action: {
                        if timerSpeed > 0.1 {
                            timerSpeed -= 0.05
                            timerText += 1
                        }
                    }) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                    }
                    .disabled(timerSpeed < 0.1)
                    .foregroundColor(timerSpeed > 0.1 ? .black : .gray)

                    Spacer()

                    // MARK: - Play / Pause
                    Button(action: {
                        isRunning.toggle()
                    }) {
                        Image(systemName: isRunning ? "pause.circle" : "play.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
            .navigationBarTitle("Модуляция", displayMode: .inline)
            .navigationBarItems(trailing: goToLegendButton)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarColorScheme(ColorScheme.light, for: .navigationBar)
            .foregroundColor(.black)
        }
        .alert(isPresented: $presentAlert) {
            Alert(title: Text("Стабильное состояние"),
                  message: Text("Количество живых элементов не менялось в течение 50 поколений."),
                  primaryButton: .destructive(Text("Очистить"), action: {
                isRunning = false
                game.newGame()
            }),
                  secondaryButton: .default(Text("Продолжить"))
            )
        }
    }

    // MARK: - Update Game
    private func updateGame() {
        guard isRunning else { return }

        game.nextGeneration()

        let currentLiveElements = game.liveElementsCount

        if currentLiveElements == stableLiveElementsCount {
            stableGenerationCount += 1
        } else {
            stableGenerationCount = 0
            stableLiveElementsCount = currentLiveElements
        }

        if stableGenerationCount >= 50 {
            isRunning = false
            presentAlert = true
            stableGenerationCount = 0
        }
    }

    // MARK: - Go To Legend Button
    private var goToLegendButton: some View {
        NavigationLink(destination: LegendView()) {
            Text("К легенде")
        }
    }

    // MARK: - Zoom And Scroll Gesture
    private var zoomAndScrollGesture: some Gesture {
        SimultaneousGesture(
            MagnificationGesture()
                .onChanged { value in
                    let newScale = previousScale * value.magnitude
                    currentScale = min(maximumScale, max(minimumScale, newScale))
                }
                .onEnded { _ in
                    previousScale = currentScale
                },
            DragGesture()
                .onChanged { value in
                    let scaledWidth = CGFloat(game.columns) * scale * currentScale
                    let scaledHeight = CGFloat(game.rows) * scale * currentScale
                    let maxOffsetX = (scaledWidth - UIScreen.main.bounds.width) / 2
                    let maxOffsetY = (scaledHeight - UIScreen.main.bounds.height) / 2

                    offset.width += value.translation.width
                    offset.height += value.translation.height

                    // Ограничение смещения в пределах доступной области
                    offset.width = max(-maxOffsetX, min(maxOffsetX, offset.width))
                    offset.height = max(-maxOffsetY, min(maxOffsetY, offset.height))
                }
                .onEnded { _ in
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
