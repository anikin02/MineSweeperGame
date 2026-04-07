//
//  CellView.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

import SwiftUI

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
    if cell.isFlag && cell.isClosed { return "🚩" }
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
