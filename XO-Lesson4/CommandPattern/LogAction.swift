//
//  LogAction.swift
//  XO-Lesson4
//
//  Created by Igor Polousov on 30.03.2022.
//

import Foundation

public enum LogAction {
    case playerInput(player: Player, position: GameboardPosition)
    case gameFinished(winner: Player?)
    case restartGame

}

public func logging(_ action: LogAction) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addLogCommand(command)
}
