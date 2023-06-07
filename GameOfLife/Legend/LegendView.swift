//
//  LegendView.swift
//  GameOfLife
//
//  Created by Илья Дубенский on 12.05.2023.
//

import SwiftUI

struct LegendView: View {

    private let stilllifes = [
        "block": "Блок (Block)",
        "bee-hive": "Пчелиный улей (Bee-Hive)",
        "loaf": "Буханка (Loaf)",
        "ship": "Корабль (Ship)",
        "boat": "Лодка (Boat)",
        "snake": "Змея (Snake)",
        "tub": "Ванна (Tub)"
    ]

    private let oscillators = [
        "blinker": "Поворотник (Blinker)",
        "toad": "Жаба (Toad)",
        "beacon": "Маяк (Beacon)",
        "pulsar": "Пульсар (Pulsar)",
        "eight": "Восемь (Eight)",
        "penta-decathlon": """
        Пента-Десятиборье \n(Penta-Decathlon)
        """
    ]

    private let spaceships = [
        "glider": "Планер (Glider)",
        "light-weight-spaceship": """
        Легкий космический корабль \n(Light-weight Spaceship)
        """,
        "middle-weight-spaceship": """
        Средний космический корабль \n(Middle-weight Spaceship)
        """,
        "heavy-weight-spaceship": """
        Тяжелый космический корабль \n(Heavy-weight Spaceship)
        """
    ]

    var body: some View {
        ZStack {
            BackView()
            ScrollView {

                // MARK: - Stilllifes
                Section(header:
                            Text("Все еще живы (Stilllifes):")
                    .font(.title3)
                    .foregroundColor(Color.black)
                    .bold()
                ){
                    VStack {
                        ForEach(stilllifes.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                            HStack {
                                Image(key)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 70)

                                Spacer()

                                Text(value)
                                    .font(.callout)
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }
                .frame(width: Constants.shared.screen.width * 0.9)
                .padding(.bottom, 10)

                // MARK: - Oscillators
                Section(header:
                            Text("Колеблющиеся (Oscillators):")
                    .font(.title3)
                    .bold()
                ){
                    VStack {

                        ForEach(oscillators.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                            HStack {
                                Image(key)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 70)

                                Spacer()

                                Text(value)
                                    .foregroundColor(Color.black)
                                    .font(.callout)
                            }
                        }
                    }
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }
                .frame(width: Constants.shared.screen.width * 0.9)

                // MARK: - Spaceships
                Section(header:
                            Text("Движующиеся (Spaceships):")
                    .foregroundColor(Color.black)
                    .font(.title3)
                    .bold()
                ) {
                    VStack {
                        ForEach(spaceships.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                            HStack {
                                Image(key)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 70)

                                Spacer()

                                Text(value)
                                    .foregroundColor(Color.black)
                                    .font(.callout)

                            }
                        }
                    }
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }
                .frame(width: Constants.shared.screen.width * 0.9)
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .scrollIndicators(.hidden)
            .navigationBarTitle("Легенда", displayMode: .inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarColorScheme(ColorScheme.light, for: .navigationBar)
            .foregroundColor(.black)
        }

    }
}


struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView()
    }
}
