//
//  ControlPanelView.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

import SwiftUI

struct ControlPanelView: View {
  @ObservedObject var viewModel: GameViewModel
  
  var body: some View {
    VStack {
      HStack {
        Picker("Difficult", selection: $viewModel.difficult) {
          ForEach(Difficult.allCases) { level in
            Text(level.rawValue.capitalized)
              .tag(level)
          }
        }
        .pickerStyle(.menu)
        .disabled(viewModel.gameState != .waiting)
        
        Button("New Game") {
          viewModel.newGame()
        }
      }
      
      Picker("Editing mode", selection: $viewModel.gameState) {
        Text("Open cells")
          .tag(GameState.openingCell)
        Text("Set flags")
          .tag(GameState.settingFlags)
      }
      .pickerStyle(.segmented)
      .padding(.horizontal)
      .disabled(viewModel.gameState == .waiting || viewModel.gameState == .lost || viewModel.gameState == .won)
    }
  }
}
