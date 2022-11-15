//
//  GameSessionPresenter.swift
//  TicTacBomb
//
//  Created by Chris K on 11/25/22.
//

import Foundation

protocol GameSessionViewProtocol {
    func displayControl(viewModel: GameSessionViewModel.Control)
    func displayHeaderView(viewModel: GameSessionViewModel.Header)
}

class GameSessionPresenter {
    var view: GameSessionViewProtocol?
    
    func presentGameSession(gameSession: GameSession) {
        presentHeaderView(gameSession: gameSession)
        presentControlView(gameSession: gameSession)
    }
    
    private func presentHeaderView(gameSession: GameSession) {
        let headerViewModel = GameSessionViewModel.Header()
        headerViewModel.scoreText = "\(gameSession.score)"
        headerViewModel.scoreColor = gameSession.score > 10 ? .red : .black
        //
        headerViewModel.timeColor = .red
        headerViewModel.timerText = "\(gameSession.timeCount)"
        //
        headerViewModel.levelColor = .red
        headerViewModel.levelText = "\(gameSession.config.level)"
        //
        headerViewModel.bloodColor = .red
        headerViewModel.bloodText = "\(gameSession.bloodCount)"
        view?.displayHeaderView(viewModel: headerViewModel)
    }
    
    private func presentControlView(gameSession: GameSession) {
        let controlViewModel = GameSessionViewModel.Control()
        controlViewModel.enabled = gameSession.state == .inprogress
        controlViewModel.imageKey = gameSession.config.image
        view?.displayControl(viewModel: controlViewModel)
    }
}

