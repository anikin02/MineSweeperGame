//
//  GameViewModel.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

import Combine
import Foundation

class GameViewModel: ObservableObject {
  @Published var board: [[Cell]] = []
  @Published var difficult : Difficult = .amateur {
    didSet {
      DispatchQueue.main.async {
        self.generateBoard()
      }
    }
  }
  @Published var isGameOver: Bool = false
  @Published var gameState: GameState = .waiting
  
  var height: Int = 0
  var width: Int = 0
  var mines: Int = 0
  
  init() {
    DispatchQueue.main.async {
      self.generateBoard()
    }
  }
  
  private func generateBoard() {
    setValuesFromDifficult()
    self.board = (0..<height).map { y in
        (0..<width).map { x in
            Cell(x: x, y: y)
        }
    }
  }
  
  func newGame() {
    gameState = .waiting
    DispatchQueue.main.async {
      self.generateBoard()
    }
  }
  
  func openCell(x: Int, y: Int) {
    switch gameState {
    case .waiting:
      generateMines(firstX: x, firstY: y)
      calculateCloseMines()
      openFreeCells(x: x, y: y)
      gameState = .playing
    case .playing:
      if board[y][x].isMine {
        board[y][x].isClosed = false
        gameState = .lost
      } else {
        openFreeCells(x: x, y: y)
      }
    case .won:
      print("Nothing")
    case .lost:
      print("Nothing")
    }
  }
  
  private func openFreeCells(x: Int, y: Int) {

      if x < 0 || x >= width || y < 0 || y >= height {
          return
      }
      
      if !board[y][x].isClosed || board[y][x].isFlag {
          return
      }
      
      board[y][x].isClosed = false
      
      if board[y][x].closeMines > 0 {
          return
      }
      
      for dx in -1...1 {
          for dy in -1...1 {
              if dx == 0 && dy == 0 { continue }
              
              openFreeCells(x: x + dx, y: y + dy)
          }
      }
  }
  
  private func generateMines(firstX: Int, firstY: Int) {
    for _ in 0..<mines {
      var isSet = false
      while !isSet {
        let x = Int.random(in: 0..<width)
        let y = Int.random(in: 0..<height)
        if (firstX != x) && (firstY != y) && !board[y][x].isMine {
          isSet = true
          board[y][x].isMine.toggle()
        }
      }
    }
  }
  
  private func calculateCloseMines() {
    for y in 0..<height {
      for x in 0..<width {
        
        
        if board[y][x].isMine {
          continue
        }
        
        var count = 0
        
        for i in -1...1 {
          for j in -1...1 {
            
            if i == 0 && j == 0 { continue }
            
            let newY = y + i
            let newX = x + j
            
            if newY >= 0 && newY < height &&
                newX >= 0 && newX < width {
              
              if board[newY][newX].isMine {
                count += 1
              }
            }
          }
        }
        
        board[y][x].closeMines = count
      }
    }
  }
  
  private func setValuesFromDifficult() {
    switch difficult {
    case .beginner:
      height = 10
      width = 10
      mines = 10
    case .amateur:
      height = 16
      width = 16
      mines = 40
    case .expert:
      height = 16
      width = 30
      mines = 99
    }
  }
}

enum GameState {
  case waiting
  case playing
  case won
  case lost
}


