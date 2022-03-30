//
//  LogCommand.swift
//  XO-Lesson4
//
//  Created by Igor Polousov on 30.03.2022.
//

import Foundation

// MARK: Command
final class LogCommand {
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    var logMessage: String {
        switch self.action {
            
        case .playerInput(player: let player, position: let position):
            return "\(player) placed mark at \(position)"
        case .gameFinished(winner: let winner):
            if let winner = winner {
                return "\(winner) win game"
            } else {
                return "There is no winner here"
            }
        case .restartGame:
            return "game restarted"
        }
    }
}
