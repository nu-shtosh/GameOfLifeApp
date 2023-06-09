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
                .cornerRadius(geometry.size.width / 2)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    RoundedRectangle(cornerRadius: geometry.size.width / 2)
                        .strokeBorder(Color(.black).opacity(0.2), lineWidth: 1)
                )
                .contentShape(Rectangle())
        }
        .drawingGroup()
    }
}

struct GridCellView_Previews: PreviewProvider {
    static var previews: some View {
        GridCellView(isAlive: false)
    }
}
