//
//  GameView.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

import SwiftUI

struct GameView: View {
  @ObservedObject var viewModel = GameViewModel()
  
  var body: some View {
    VStack {
      HStack {
        Text("Minesweeper")
          .font(.system(size: 20, weight: .black))
        
        Spacer()
        
        Text("Mines left: ")
          .padding(.horizontal, 12)
          .padding(.vertical, 6)
          .background(.blue.opacity(0.2))
          .clipShape(.capsule)
          .foregroundStyle(.blue)
      }
      
      HStack {
        VStack {
          Picker("Difficult", selection: $viewModel.difficult) {
            ForEach(Difficult.allCases) { level in
              Text(level.rawValue.capitalized)
                .tag(level)
            }
          }
          .pickerStyle(.menu)
          .padding()
          .disabled(viewModel.gameState != .waiting)
        }
        
        Button() {
          viewModel.newGame()
        } label: {
          Text("New Game")
        }
      }
      .padding(.vertical, 8)
      
      HStack {
        Text("LBM - open, RMB - flag/chord")
          .font(.caption)
          .foregroundStyle(.secondary)
      }
      
      VStack(spacing: 0) {
        ForEach(0..<viewModel.height, id: \.self) { y in
          HStack(spacing: 0) {
            ForEach(0..<viewModel.width, id: \.self) { x in
              Button(action: {
                handleTap(y: y, x: x)
              }) {
                Text(displayText(viewModel.board[y][x]))
                  .frame(width: 30, height: 30)
                  .background(viewModel.board[y][x].isClosed ? Color("ClosedCellColor") : .white)
                  .border(Color.black, width: 1)
                  .font(.system(size: 14))
                  .foregroundStyle(neighborColor(viewModel.board[y][x].closeMines))
              }
              .buttonStyle(PlainButtonStyle())
            }
          }
        }
      }
      
      Spacer()
    }
  }
  
  func handleTap(y: Int, x: Int) {
    print("print")
    viewModel.openCell(x: x, y: y)
  }
  
  func displayText(_ cell: Cell) -> String {
    if cell.isClosed {
      return ""
    }
    
    if cell.isMine {
      return "💣"
    }
    
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

#Preview {
  GameView()
}
