//
//  LoggerInvoker.swift
//  XO-Lesson4
//
//  Created by Igor Polousov on 30.03.2022.
//

import Foundation


// MARK: Invoker

internal final class LoggerInvoker {
    
    internal static let shared = LoggerInvoker()
    private let logger = Logger()
    private let batchSize = 10
    private var commands = [LogCommand]()
    
    
    internal func addLogCommand(_ command: LogCommand) {
        self.commands.append(command)
        self.executeCommandsIfNeeded()
    }
    
    private func executeCommandsIfNeeded() {
        guard self.commands.count >= batchSize else { return }
        self.commands.forEach { self.logger.writeMessageToLog($0.logMessage) }
        self.commands = []
    }
}
