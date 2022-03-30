//
//  GameState.swift
//  XO-Lesson4
//
//  Created by Igor Polousov on 30.03.2022.
//

import Foundation

public protocol GameState {
    
    var isCompleted: Bool { get } // Отслеживание выполнено состояние или нет
    func begin() // Подготовка к началу игры
    func addMark(at position: GameboardPosition) // Добавляет крестик или нолик на игровое поле
}


class PlayerInputState: GameState {
    
    public private(set) var isCompleted: Bool = false
    public let player: Player
    
    public private(set) weak var gameViewController: GameViewController?
    public private(set) weak var gameBoard: Gameboard?
    public private(set) weak var gameBoardView: GameboardView?
    
    init(player: Player, gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
    }
    
    // Подготавливаение состояние элементов на view, будут отображиться или нет
    public func begin() {
        
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        case .computer:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) {
        logging(.playerInput(player: player, position: position))
        
        guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else { return }
        
        let markView: MarkView
        
        switch self.player {
            
        case .first:
            markView = XView()
            self.gameBoard?.setPlayer(self.player, at: position)
            self.gameBoardView?.placeMarkView(markView, at: position)
            self.isCompleted = true
            
        case .second:
            markView = OView()
            self.gameBoard?.setPlayer(self.player, at: position)
            self.gameBoardView?.placeMarkView(markView, at: position)
            self.isCompleted = true
            
        case .computer:
            markView = OView()
            let compPosition = randomCell()
            self.gameBoard?.setPlayer(self.player, at: compPosition)
            self.gameBoardView?.placeMarkView(markView, at: compPosition)
            self.isCompleted = true
        }
    }
    
    func randomCell() -> GameboardPosition {
        var positions:[GameboardPosition] = []
        for column in 0...2 {
            for row in 0...2 {
                let position = GameboardPosition(column: column, row: row)
                positions.append(position)
            }
        }
            
        if let gameBoardView = gameBoardView {
            for (key,_) in gameBoardView.markViewForPosition {
                positions = positions.filter({$0 != key})
            }
        }
       
        let position = positions.randomElement()!
        return position
    }
}
