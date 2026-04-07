//
//  GameState.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

enum GameState: String, CaseIterable, Identifiable {
  case waiting
  case openingCell
  case settingFlags
  case won
  case lost
  
  var id: String { self.rawValue }
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
