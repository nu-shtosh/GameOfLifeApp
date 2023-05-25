//
//  GridCellView.swift
//  GameOfLife
//
//  Created by Илья Дубенский on 12.05.2023.
//

import SwiftUI

struct GridCellView: View {
    let isAlive: Bool

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .foregroundColor(isAlive ? .black : .clear)
                .border(Color(.gray).opacity(0.3), width: 1)
                .animation(.easeInOut(duration: 0.1), value: isAlive)
                .contentShape(Rectangle()) // Добавленный модификатор

        }
    }
}

struct GridCellView_Previews: PreviewProvider {
    static var previews: some View {
        GridCellView(isAlive: false)
    }
}
