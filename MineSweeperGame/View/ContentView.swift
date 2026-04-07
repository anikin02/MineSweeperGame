//
//  ContentView.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

import SwiftUI

struct ContentView: View {
  @State private var grid: [[Cell]] = []
  @State private var minesLeft: Int = 9
  @State private var gameOver: Bool = false
  @State private var gameWon: Bool = false
  
  let rows = 9
  let columns = 9
  let totalMines = 9
  
  var body: some View {
    VStack {
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
      
      HStack {
        Button() {
          
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
    }
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
  ContentView()
}
