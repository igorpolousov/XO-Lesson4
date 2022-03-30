//
//  Player.swift
//  XO-Lesson4
//
//  Created by Igor Polousov on 30.03.2022.
//

import Foundation

public enum Player: CaseIterable {
    case first // Игрок1
    case second //  Игрок2
    case computer
    
    
    func next(player: Player, gameMode: String) -> Player{
        switch player {
        case .first:
            if gameMode == "2nd Player" {
                return .second
            } else if gameMode == "Computer" {
                return .computer
            }
        case .second:
            return .first
        case .computer:
            return .first
        }
        return player
    }
}
