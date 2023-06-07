//
//  GameOfLife.swift
//  GameOfLife
//
//  Created by Илья Дубенский on 12.05.2023.
//

import SwiftUI

class GameOfLife: ObservableObject, Equatable {

    let rows: Int
    let columns: Int

    let neighborOffsets: [(Int, Int)] = [
        (-1, -1), (-1, 0), (-1, 1),
        (0, -1),           (0, 1),
        (1, -1),  (1, 0),  (1, 1)
    ]

    static func == (lhs: GameOfLife, rhs: GameOfLife) -> Bool {
        lhs.grid == rhs.grid
    }

    @Published var grid: [[Bool]]
    @Published var nextGrid: [[Bool]] = []

    @Published var generationCount: Int = 0

    var liveElementsCount: Int {
        grid.flatMap { $0 }.reduce(0) { $0 + ($1 ? 1 : 0) }
    }

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.grid = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }

    func toggleCell(row: Int, column: Int) {
        grid[row][column].toggle()
        objectWillChange.send()
    }

    func randomizeGrid() {
        grid = grid.map { row in
            row.map { _ in Bool.random() }
        }
    }

    func nextGeneration() {
        var newGrid = self.grid

        for rowIndex in 0..<rows {
            for columnIndex in 0..<columns {
                let liveNeighbors = self.countLiveNeighbors(row: rowIndex, column: columnIndex)
                let isAlive = self.grid[rowIndex][columnIndex]

                if isAlive {
                    newGrid[rowIndex][columnIndex] = liveNeighbors == 2 || liveNeighbors == 3
                } else {
                    newGrid[rowIndex][columnIndex] = liveNeighbors == 3
                }
            }
        }

        self.grid = newGrid
        self.generationCount += 1
    }

    func newGame() {
        self.grid = Array(repeating: Array<Bool>(repeating: false, count: columns), count: rows)
        self.generationCount = 0
    }

    func calculateNextGeneration() -> [[Bool]] {
        let rowCount = grid.count
        let columnCount = grid.first?.count ?? 0

        var newGrid = [[Bool]](repeating: [Bool](repeating: false, count: columnCount), count: rowCount)

        for rowIndex in 0..<rowCount {
            for columnIndex in 0..<columnCount {
                let liveNeighbors = self.countLiveNeighbors(row: rowIndex, column: columnIndex)
                let element = grid[rowIndex][columnIndex]
                if element {
                    newGrid[rowIndex][columnIndex] = liveNeighbors == 2 || liveNeighbors == 3
                } else {
                    newGrid[rowIndex][columnIndex] = liveNeighbors == 3
                }
            }
        }

        return newGrid
    }

    func countLiveNeighbors(row: Int, column: Int) -> Int {
        let rowCount = grid.count
        let columnCount = grid[row].count

        let liveNeighborCount = neighborOffsets.reduce(0) { count, offset in
            let neighborRow = (row + offset.0 + rowCount) % rowCount
            let neighborColumn = (column + offset.1 + columnCount) % columnCount
            return count + (grid[neighborRow][neighborColumn] ? 1 : 0)
        }

        return liveNeighborCount
    }

    func countLiveElements(grid: [[Bool]]) -> Int {
        return grid.reduce(0) { count, row in
            return count + row.reduce(0) { rowSum, element in
                return rowSum + (element ? 1 : 0)
            }
        }
    }
}
