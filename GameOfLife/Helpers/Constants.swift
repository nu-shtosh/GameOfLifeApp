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
        case 0...667:
            return 64
        case 668...812:
            return 32
        default:
            return 0
        }
    }
}
