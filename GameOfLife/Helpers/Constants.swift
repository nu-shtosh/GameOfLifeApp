//
//  Constants.swift
//  GameOfLife
//
//  Created by Илья Дубенский on 07.06.2023.
//


import SwiftUI

final class Constants {
    static let shared: Constants = .init()

    let screen = UIScreen.main.bounds

    func calculateTopPadding() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height

        switch screenHeight {
        case 0...666:
            return 64
        case 667...812:
            return 32
        default:
            return 0
        }
    }
}
