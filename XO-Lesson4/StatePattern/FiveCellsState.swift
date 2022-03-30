//
//  FiveCellsState.swift
//  XO-Lesson4
//
//  Created by Igor Polousov on 30.03.2022.
//

import Foundation

class FiveCellsState: GameState {
    
    public private(set) var isCompleted: Bool = false
    public let player: Player
    
    var playerOneArray: [GameboardPosition] = []
    var playerTwoArray: [GameboardPosition] = []
    
    public private(set) weak var gameViewController: GameViewController?
    public private(set) weak var gameBoard: Gameboard?
    public private(set) weak var gameBoardView: GameboardView?
    
    init(player: Player, gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView ) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
    }
    
   public func begin() {
        
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
            
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
            
        case .computer:
            print("There is no computer session for this game mode")
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
  public  func addMark(at position: GameboardPosition) {
        logging(.playerInput(player: player, position: position))
        
      var markView: MarkView
      
        switch self.player {
        case.first:
            markView = XView()
            markView.isHidden = true
            self.gameBoard?.setPlayer(self.player, at: position)
            self.gameBoardView?.placeMarkView(markView, at: position)
            if let gameBoardView = gameBoardView {
                let count = gameBoardView.markViewForPosition.count
                if count < 5 {
                    self.isCompleted = false
                    print(count)
                } else {
                    self.isCompleted = true
                }
            }

        case .second:
            markView = OView()
            markView.isHidden = true
            self.gameBoard?.setPlayer(self.player, at: position)
            self.gameBoardView?.placeMarkViewFiveCells(markView, at: position)
            if let gameBoardView = gameBoardView {
                let count = gameBoardView.markViewForPosition.count
                if count < 9 {
                    print("Count \(count)")
                    self.isCompleted = false
                } else {
                    self.isCompleted = true
                }
            }
            
        case .computer:
            print("There is no session for computer in this game state")
        }
    }
}
