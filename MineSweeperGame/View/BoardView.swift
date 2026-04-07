//
//  BoardView.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

import SwiftUI

struct BoardView: View {
  @ObservedObject var viewModel: GameViewModel
  
  var body: some View {
    VStack(spacing: 0) {
      ForEach(0..<viewModel.height, id: \.self) { y in
        HStack(spacing: 0) {
          ForEach(0..<viewModel.width, id: \.self) { x in
            CellView(
              cell: viewModel.board[y][x],
              action: {
                viewModel.changeCell(x: x, y: y)
              }
            )
          }
        }
      }
    }
  }
}
