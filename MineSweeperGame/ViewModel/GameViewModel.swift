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
  @Published var activeAlert: GameAlert?
  
  @Published var difficult : Difficult = .amateur {
    didSet {
      DispatchQueue.main.async {
        self.generateBoard()
      }
    }
  }
  
  @Published var gameState: GameState = .waiting {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        switch self.gameState {
        case .won:
          self.activeAlert = .won
        case .lost:
          self.activeAlert = .lost
        default:
          self.activeAlert = nil
        }
      }
    }
  }
  
  @Published var flags: Int = 0
  
  var height: Int = 0
  var width: Int = 0
  var mines: Int = 0
  
  private var openedCells = 0
  
  init() {
    DispatchQueue.main.async {
      self.generateBoard()
    }
  }
  
  func newGame() {
    gameState = .waiting
    DispatchQueue.main.async {
      self.generateBoard()
    }
  }
  
  func changeCell(x: Int, y: Int) {
    switch gameState {
    case .waiting:
      generateMines(firstX: x, firstY: y)
      calculateCloseMines()
      openFreeCells(x: x, y: y)
      gameState = .openingCell
    case .openingCell:
      if board[y][x].isMine {
        board[y][x].isClosed = false
        gameState = .lost
      } else {
        openFreeCells(x: x, y: y)
        if openedCells == width * height - mines {
          gameState = .won
        }
      }
    case .settingFlags:
      setFlag(x: x, y: y)
    default: return
    }
  }
  
  func setFlag(x: Int, y: Int) {
    if board[y][x].isClosed {
      if board[y][x].isFlag {
        flags += 1
        board[y][x].isFlag.toggle()
      } else if flags > 0 {
        flags -= 1
        board[y][x].isFlag.toggle()
      }
    }
  }
  
  // MARK: - Generating Board
  
  private func generateBoard() {
    setValuesFromDifficult()
    openedCells = 0
    self.board = (0..<height).map { y in
      (0..<width).map { x in
        Cell(x: x, y: y)
      }
    }
  }
  
  private func setValuesFromDifficult() {
    switch difficult {
    case .beginner:
      height = 10
      width = 10
      mines = 10
      flags = 10
    case .amateur:
      height = 16
      width = 16
      mines = 40
      flags = 40
    case .expert:
      height = 16
      width = 30
      mines = 99
      flags = 99
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
  
  // MARK: - Opening cells
  
  private func openFreeCells(x: Int, y: Int) {
    
    if x < 0 || x >= width || y < 0 || y >= height {
      return
    }
    
    if !board[y][x].isClosed || board[y][x].isFlag {
      return
    }
    
    board[y][x].isClosed = false
    openedCells += 1
    
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
}
