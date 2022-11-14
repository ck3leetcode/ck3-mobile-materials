//
//  GameSessionVIPER.swift
//  TicTacBomb
//
//  Created by Chris K on 11/12/22.
//

import Foundation

protocol GameSessionViewProtocol {
    func displayScore(viewModel: GameSessionViewModel.Score)
    func displayTimer(viewModel: GameSessionViewModel.Timer)
}

class GameSessionInteractor {
    var gameSession = GameSession.create()

    let presenter: GameSessionPresenter
    init(presenter: GameSessionPresenter) {
        self.presenter = presenter
    }
    
    func loadNewGameSession() {
        print("loadNewGameSession")
        self.gameSession = GameSession.create()
        presenter.presentGameSession(gameSession: gameSession)
    }
}


class GameSessionPresenter {
    var view: GameSessionViewProtocol?
    
    func presentGameSession(gameSession: GameSession) {
        let score = GameSessionViewModel.Score()
        score.text = "\(gameSession.score)"
        score.color = gameSession.score > 10 ? .red : .black
        
        let timer = GameSessionViewModel.Timer()
        timer.color = .red
        timer.text = "0:10:00"
        
        view?.displayScore(viewModel: score)
        view?.displayTimer(viewModel: timer)
    }
}






