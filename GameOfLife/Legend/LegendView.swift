//
//  LegendView.swift
//  GameOfLife
//
//  Created by Илья Дубенский on 12.05.2023.
//

import SwiftUI

struct LegendView: View {

    let stillLifes = [
        "block": "Блок (Block)",
        "bee-hive": "Пчелиный улей (Bee-Hive)",
        "loaf": "Буханка (Loaf)",
        "ship": "Корабль (Ship)",
        "boat": "Лодка (Boat)",
        "tub": "Ванна (Tub)"
    ]

    let oscillators = [
        "blinker": "Поворотник (Blinker)",
        "toad": "Жаба (Toad)",
        "beacon": "Маяк (Beacon)",
        "pulsar": "Пульсар (Pulsar)",
        "penta-decathlon": "Пента-Десятиборье (Penta-Decathlon)"
    ]

    let spaceships = [
        "glider": "Планер (Glider)",
        "light-weight-spaceship": "Легкий космический корабль (Light-weight Spaceship)",
        "middle-weight-spaceship": "Средний космический корабль (Middle-weight Spaceship)",
        "heavy-weight-spaceship": "Тяжелый космический корабль (Heavy-weight Spaceship)"
    ]

    var body: some View {
        ZStack {
            BackView()
            ScrollView {
                Section(header:
                            Text("Still Lifes:")
                    .font(.title3)
                    .foregroundColor(Color.black)
                    .bold()
                ){
                    ForEach(stillLifes.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        HStack {
                            Image(key)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .cornerRadius(12)

                            Spacer()
                            Text(value)
                                .foregroundColor(Color.black)
                        }
                    }
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }

                Section(header:
                            Text("Oscillators:")
                    .font(.title3)
                    .bold()
                ){
                    ForEach(oscillators.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        HStack {
                            Image(key)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .cornerRadius(12)
                            Spacer()
                            Text(value)
                                .foregroundColor(Color.black)

                        }
                    }
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }


                Section(header:
                            Text("Spaceships:")
                    .foregroundColor(Color.black)
                    .font(.title3)
                    .bold()
                ) {
                    ForEach(spaceships.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        HStack {
                            Image(key)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .cornerRadius(12)

                            Spacer()
                            Text(value)
                                .foregroundColor(Color.black)

                        }
                    }
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }
            }
            .padding(10)
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
