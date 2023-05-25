//
//  GridView.swift
//  GameOfLife
//
//  Created by Илья Дубенский on 12.05.2023.
//

import SwiftUI

struct GridView: View {
    @ObservedObject var game: GameOfLife

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<game.grid.count, id: \.self) { row in
                ForEach(0..<game.grid[row].count, id: \.self) { column in
                    let cellSize = CGSize(width: geometry.size.width / CGFloat(game.grid[row].count), height: geometry.size.height / CGFloat(game.grid.count))
                    let cellLength = min(cellSize.width, cellSize.height)
                    let position = CGPoint(x: CGFloat(column) * cellSize.width, y: CGFloat(row) * cellSize.height)

                    GridCellView(isAlive: game.grid[row][column])
                        .frame(width: cellLength, height: cellLength)
                        .position(x: position.x + (cellSize.width / 2), y: position.y + (cellSize.height / 2))
                        .onTapGesture {
                            game.toggleCell(row: row, column: column)
                        }
                }
            }
        }
    }
}




struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(game: GameOfLife.init(rows: 20, columns: 20))
    }
}
