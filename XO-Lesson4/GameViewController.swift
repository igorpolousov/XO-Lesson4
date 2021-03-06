//
//  GameViewController.swift
//  XO-Lesson4
//
//  Created by Igor Polousov on 30.03.2022.
//

import UIKit

protocol Copying {
    init(_ prototype: Self)
}

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var vsPlayer: UIButton!
    @IBOutlet var vsComputer: UIButton!
    @IBOutlet var fiveCellsButton: UIButton!
    @IBOutlet var normalGameButton: UIButton!
    
    private let gameBoard = Gameboard()
    
    
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    private var playerType: Player?
    
    private lazy var referee = Referee(gameboard: self.gameBoard)
    
    var secondLabelText: String = "" {
        didSet {
            secondPlayerTurnLabel.text = secondLabelText
        }
    }
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vsPlayer.setup()
        vsComputer.setup()
        restartButton.setup()
        fiveCellsButton.setup()
        normalGameButton.setup()
        secondLabelText = ""
        
        
        if secondLabelText.isEmpty {
            gameboardView.isHidden = true
        }
        
        
        self.goToFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        gameboardView.isHidden = false
        goToFirstState()
        logging(.restartGame)
    }
        
    @IBAction func vsPlayerTapped(_ sender: UIButton) {
        gameboardView.isHidden = false
        secondLabelText = "2nd Player"
    }
    
    @IBAction func vsComputerTapped(_ sender: UIButton) {
        gameboardView.isHidden = false
        secondLabelText = "Computer"
    }
    
    @IBAction func fiveCellsTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func normalGameTapped(_ sender: UIButton) {
        
    }
    
    private func goToFirstState() {
        gameBoard.clear()
        gameboardView.clear()
        self.currentState = PlayerInputState(player: .first, gameViewController: self, gameBoard: gameBoard, gameBoardView: gameboardView)
    }
    
    private func goToNextState() {
        
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedstate(winner: winner, gameViewController: self)
            return
        }
        
        if let playerInputState = currentState as? PlayerInputState {
            self.currentState = PlayerInputState(player: playerInputState.player.next(player: playerInputState.player, gameMode: secondLabelText), gameViewController: self, gameBoard: gameBoard, gameBoardView: gameboardView)
        }
    }
}

extension Copying {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}
