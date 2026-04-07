//
//  HeaderView.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

import SwiftUI


struct HeaderView: View {
  @Binding var flagsLeft: Int
  
  var body: some View {
    HStack {
      Text("Minesweeper")
        .font(.system(size: 20, weight: .black))
      
      Spacer()
      
      Text("Flags left: \(flagsLeft)")
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.blue.opacity(0.2))
        .clipShape(.capsule)
        .foregroundStyle(.blue)
    }
  }
}
