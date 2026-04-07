//
//  GameState.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

enum GameState {
  case waiting
  case playing
  case won
  case lost
}

enum GameAlert: Identifiable {
    case won
    case lost
    
    var id: Int {
        switch self {
        case .won: return 1
        case .lost: return 2
        }
    }
}
