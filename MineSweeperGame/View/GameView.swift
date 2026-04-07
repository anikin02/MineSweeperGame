//
//  GameView.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

import SwiftUI

struct GameView: View {
  @StateObject var viewModel = GameViewModel()
  
  var body: some View {
    VStack {
      HeaderView(flagsLeft: $viewModel.flags)
      
      ControlPanelView(viewModel: viewModel)
        .padding(.vertical, 8)
      
      BoardView(viewModel: viewModel)
      
      Spacer()
    }
    .alert(item: $viewModel.activeAlert) { state in
      switch state {
      case .won:
        return Alert(
          title: Text("Game over"),
          message: Text("You WON!!! 🎉"),
          dismissButton: .default(Text("OK"))
        )
      case .lost:
        return Alert(
          title: Text("Game over"),
          message: Text("You lost 💣"),
          dismissButton: .default(Text("OK"))
        )
      }
    }
  }
}



#Preview {
  GameView()
}
