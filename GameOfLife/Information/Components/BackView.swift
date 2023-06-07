//
//  BackView.swift
//  GameOfLife
//
//  Created by Илья Дубенский on 16.05.2023.
//

import SwiftUI

struct BackView: View {
    var body: some View {
        GridForBack()
            .background(Color.white)
    }
}

struct GridForBack: View {
    var body: some View {
        VStack {
            ForEach(0..<28) { _ in
                HStack {
                    ForEach(0..<14) { _ in
                        CellForBackView()
                    }
                }
            }
        }
    }
}

struct CellForBackView: View {
    @State private var isAlive = Bool.random() // Случайное состояние

    var body: some View {
        Rectangle()
            .foregroundColor(isAlive ? Color(.gray).opacity(0.1) : .clear)
            .frame(width: 20, height: 20)
            .border(Color.white, width: 1) // Граница клетки
    }
}

struct BackView_Previews: PreviewProvider {
    static var previews: some View {
        BackView()
    }
}
