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
      HeaderView(minesLeft: viewModel.mines)
      
      ControlPanelView(viewModel: viewModel)
        .padding(.vertical, 8)
      
      Text("LBM - open, RMB - flag/chord")
        .font(.caption)
        .foregroundStyle(.secondary)
      
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

struct CellView: View {
  let cell: Cell
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(displayText(cell))
        .frame(width: 30, height: 30)
        .background(cell.isClosed ? Color("ClosedCellColor") : .white)
        .border(Color.black, width: 1)
        .font(.system(size: 14))
        .foregroundStyle(neighborColor(cell.closeMines))
    }
    .buttonStyle(.plain)
  }
  
  private func displayText(_ cell: Cell) -> String {
    if cell.isClosed { return "" }
    if cell.isMine { return "💣" }
    return cell.closeMines == 0 ? "" : "\(cell.closeMines)"
  }
  
  private func neighborColor(_ count: Int) -> Color {
    switch count {
    case 1: return .blue
    case 2: return .green
    case 3: return .red
    case 4: return .purple
    case 5: return .orange
    default: return .black
    }
  }
}

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

struct HeaderView: View {
  let minesLeft: Int
  
  var body: some View {
    HStack {
      Text("Minesweeper")
        .font(.system(size: 20, weight: .black))
      
      Spacer()
      
      Text("Mines left: \(minesLeft)")
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.blue.opacity(0.2))
        .clipShape(.capsule)
        .foregroundStyle(.blue)
    }
  }
}

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
                viewModel.openCell(x: x, y: y)
              }
            )
          }
        }
      }
    }
  }
}

#Preview {
  GameView()
}
