import SwiftUI

class GameOfLife: ObservableObject, Equatable {

    let rows: Int
    let columns: Int

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
        let newGrid = self.grid.enumerated().map { rowIndex, row in
            row.enumerated().map { columnIndex, element in
                let liveNeighbors = self.countLiveNeighbors(row: rowIndex, column: columnIndex)
                if element {
                    return liveNeighbors == 2 || liveNeighbors == 3
                } else {
                    return liveNeighbors == 3
                }
            }
        }
        self.grid = newGrid
        self.generationCount += 1
    }

    func newGame() {
        let newGrid = Array(repeating: Array(repeating: false, count: self.columns),
                            count: self.rows)
        self.grid = newGrid
        self.generationCount = 0
    }

    func calculateNextGeneration() -> [[Bool]] {
        let newGrid = grid.enumerated().map { rowIndex, row in
            row.enumerated().map { columnIndex, element in
                let liveNeighbors = self.countLiveNeighbors(row: rowIndex, column: columnIndex)
                if element {
                    return liveNeighbors == 2 || liveNeighbors == 3
                } else {
                    return liveNeighbors == 3
                }
            }
        }
        return newGrid
    }

    func countLiveNeighbors(row: Int, column: Int) -> Int {
        var count = 0
        for i in -1...1 {
            for j in -1...1 {
                let neighborRow = (row + i + grid.count) % grid.count
                let neighborColumn = (column + j + grid[row].count) % grid[row].count

                if !(i == 0 && j == 0) && grid[neighborRow][neighborColumn] {
                    count += 1
                }
            }
        }
        return count
    }

    func countLiveElements(grid: [[Bool]]) -> Int {
        var count = 0

        for row in grid {
            for element in row {
                if element {
                    count += 1
                }
            }
        }

        return count
    }
}
