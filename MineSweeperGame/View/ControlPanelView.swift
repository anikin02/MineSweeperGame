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
    HStack {
      Picker("Difficult", selection: $viewModel.difficult) {
        ForEach(Difficult.allCases) { level in
          Text(level.rawValue.capitalized)
            .tag(level)
        }
      }
      .pickerStyle(.menu)
      .padding()
      .disabled(viewModel.gameState != .waiting)
      
      Button("New Game") {
        viewModel.newGame()
      }
    }
  }
}
