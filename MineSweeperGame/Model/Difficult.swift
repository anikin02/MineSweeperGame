//
//  Difficult.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

enum Difficult: String, CaseIterable, Identifiable {
    case beginner
    case amateur
    case expert

    var id: String { self.rawValue }
}
