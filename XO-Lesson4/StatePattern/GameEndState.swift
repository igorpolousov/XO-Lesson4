//
//  GameEndState.swift
//  XO-Lesson4
//
//  Created by Igor Polousov on 30.03.2022.
//

import Foundation

class GameEndedstate: GameState {
    
    var isCompleted: Bool = false
    let winner: Player?
    weak var gameViewController: GameViewController?
    
    public init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    func begin() {
        logging(.gameFinished(winner: self.winner))
        
        self.gameViewController?.winnerLabel.isHidden = false
        
        if let winner = winner {
            self.gameViewController?.winnerLabel.text = self.winnerName(from: winner) + " win"
        } else {
            self.gameViewController?.winnerLabel.text = "No winner"
        }
        
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {}
    
    func winnerName(from winner: Player) -> String {
        switch winner {
        case .first:
            return "First player"
        case .second:
            return "Second player"
        case .computer:
            return "Computer"
        }
    }
    
    
}
