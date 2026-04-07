//
//  Cell.swift
//  MineSweeperGame
//
//  Created by Данил Аникин on 07/04/2026.
//

struct Cell {
  let x: Int
  let y: Int
  var isMine: Bool = false
  var isFlag: Bool = false
  var isClosed: Bool = true
  var closeMines: Int = 0
}
