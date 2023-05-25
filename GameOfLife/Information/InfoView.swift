//
//  InfoView.swift
//  GameOfLife
//
//  Created by Илья Дубенский on 12.05.2023.
//

import SwiftUI

struct InfoView: View {

    var body: some View {

        NavigationView {
            ZStack {
                BackView()

                ScrollView {
                    TitleView()

                    RulesView()

                    ControlView()

                    TargetView()
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
            .scrollIndicators(.hidden)
            .navigationBarTitle("Информация", displayMode: .inline)
            .navigationBarItems(trailing: modulationButton)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarColorScheme(ColorScheme.light, for: .navigationBar)
            .foregroundColor(.black)
        }
    }

    private var modulationButton: some View {
        NavigationLink(destination: ModulationView()) {
            Text("К модуляции")
        }
    }
}

struct RulesView: View {
    var body: some View {
        VStack {
            Text("Правила игры:")
                .font(.title3)
                .foregroundColor(.black)
                .bold()
            VStack(alignment: .leading, spacing: 4) {
                Text("- Любая живая клетка с менее чем двумя живыми соседям и умирает от одиночества.")
                    .font(.callout)
                    .foregroundColor(.black)
                    .lineLimit(3)
                Text("- Любая живая клетка с двумя или тремя живыми соседями продолжает жить и на следующем шаге.")
                    .font(.callout)
                    .foregroundColor(.black)
                    .lineLimit(3)
                Text("- Любая живая клетка с более чем тремя живыми соседями умирает от перенаселения.")
                    .font(.callout)
                    .lineLimit(3)
                    .foregroundColor(.black)
                Text("- Любая мертвая клетка с ровно тремя живыми соседями становится живой.")
                    .font(.callout)
                    .foregroundColor(.black)
                    .lineLimit(3)
                Text("- Любая клетка может иметь только 8 соседей.")
                    .font(.callout)
                    .foregroundColor(.black)
                    .lineLimit(3)
            }
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
        .ignoresSafeArea()
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            Text("Игра «Жизнь» (Game of Life)")
                .font(.title3)
                .foregroundColor(.black)
                .bold()
                Text("Это клеточный автомат, разработанный математиком Джоном Конвеем. Игра происходит на двумерном поле, состоящем из клеток, которые могут находиться в двух состояниях: живые или мертвые.")
                    .foregroundColor(.black)
                    .font(.callout)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
        }
        .ignoresSafeArea()
    }
}

struct ControlView: View {
    var body: some View {
        VStack {
            Text("Управление:")
                .font(.title3)
                .bold()
                .foregroundColor(.black)
            VStack(alignment: .leading, spacing: 4) {
                Text("- Чтобы пометить/снять пометку с клетки, щелкните по ней.")
                    .font(.callout)
                    .foregroundColor(.black)
                Text("- Для запуска/остановки эволюции нажмите кнопку \"Старт\"/\"Стоп\".")
                    .font(.callout)
                    .foregroundColor(.black)
                Text("- Чтобы заполнить поле случайными живыми клетками  \"Случайное заполнение\".")
                    .font(.callout)
                    .foregroundColor(.black)
                Text("- Чтобы очистить поле нажмите \"Новая игра\".")
                    .font(.callout)
                    .foregroundColor(.black)
            }
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
        .ignoresSafeArea()

    }
}

struct TargetView: View {
    var body: some View {
        VStack {
            Text("Цель:")
                .font(.title3)
                .foregroundColor(.black)
                .bold()
            Text("Cоздавать различные узоры и формы, запуская эволюцию клеток и наблюдая за их изменениями во времени.")
                .font(.callout)
                .padding(8)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
        }
        .ignoresSafeArea()
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
