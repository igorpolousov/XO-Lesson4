//
//  FiveCellsState.swift
//  XO-Lesson4
//
//  Created by Igor Polousov on 30.03.2022.
//

import Foundation

class FiveCellsState: GameState {
    
    var isCompleted: Bool = false
    let player: Player
    
    var playerOneArray: [GameboardPosition] = []
    var playerTwoArray: [GameboardPosition] = []
    
    var gameViewController: GameViewController?
    var gameBoard: Gameboard?
    var gameBoardView: GameboardView?
    
    init(player: Player, gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView ) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
    }
    
    func begin() {
        
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
    
    func addMark(at position: GameboardPosition) {
        logging(.playerInput(player: player, position: position))
        
        let markView: MarkView
        
        switch self.player {
        case.first:
            markView = XView()
            for _ in 1...5 {
                self.gameBoard?.setPlayer(self.player, at: position)
                self.gameBoardView?.placeMarkView(markView, at: position)
            }
            self.isCompleted = true
            
        case .second:
            markView = OView()
            for _ in 1...5 {
                self.gameBoard?.setPlayer(self.player, at: position)
                self.gameBoardView?.placeMarkView(markView, at: position)
            }
            self.isCompleted = true
            
        case .computer:
            print("There is no session for computer in this game state")
        }
        
    }
    
    
}
