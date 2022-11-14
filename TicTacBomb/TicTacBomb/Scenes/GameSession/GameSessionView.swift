//
//  GameSessionView.swift
//  TicTacBomb
//
//  Created by Chris K on 11/12/22.
//

import SwiftUI

struct GameSessionView: View {
    @ObservedObject fileprivate var gameSessionObs = GameSessionObservableObject()
    
    var interactor: GameSessionInteractor?

    var body: some View {
        VStack {
            Spacer()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text("score: \(gameSessionObs.scoreTextVal)")
            Text("time remaining: \(gameSessionObs.scoreTextVal)")
            Spacer()
        }.onAppear() {
            print("onAppear")
            interactor?.loadNewGameSession()
        }
        
    }
}

extension GameSessionView: GameSessionViewProtocol {
    func displayScore(viewModel: GameSessionViewModel.Score) {
        gameSessionObs.scoreTextVal = viewModel.text
    }
    
    func displayTimer(viewModel: GameSessionViewModel.Timer) {
        gameSessionObs.timerTextVal = viewModel.text
    }
}

extension GameSessionView {
    func configureView() -> some View {
        var view = self
        let presenter = GameSessionPresenter()
        presenter.view = view
        view.interactor = GameSessionInteractor(presenter: presenter)
        return view
    }
}

fileprivate class GameSessionObservableObject: ObservableObject {
    @Published var timerTextVal = ""
    @Published var scoreTextVal = ""
}

struct GameSessionView_Previews: PreviewProvider {
    static var previews: some View {
        GameSessionView()
    }
}


