//
//  GameSessionVIPER.swift
//  TicTacBomb
//
//  Created by Chris K on 11/12/22.
//

import Foundation

protocol GameSessionScorer {
    func hit()
    func miss()
}


class GameSessionInteractor: GameSessionScorer {
    var timer = Timer()
    var gameSession = GameSession.create()

    let presenter: GameSessionPresenter
    init(presenter: GameSessionPresenter) {
        self.presenter = presenter
    }
    
    func startGame() {
        if (gameSession.state == .inprogress) {
            return
        }
        
        gameSession = GameSession.create()
        gameSession.state = .inprogress
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.gameSession.timeCount += 1
            if (self.gameSession.state != .inprogress) {
                self.timer.invalidate()
            }
            self.presentGameSession()
        })
    }
    
    func endGame() {
        gameSession.state = .lost
        presentGameSession()
    }
    
    func hit() {
        gameSession.score += 10
        presentGameSession()
    }
    
    func miss() {
        gameSession.bloodCount -= 1
        if (self.gameSession.bloodCount <= 0) {
            self.endGame()
        }
        presentGameSession()
    }
    
    private func presentGameSession() {
        presenter.presentGameSession(gameSession: gameSession)
    }
}


