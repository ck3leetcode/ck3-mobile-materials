//
//  GameSessionView.swift
//  TicTacBomb
//
//  Created by Chris K on 11/12/22.
//

import SwiftUI

extension GameSessionView {
    func configureView() -> some View {
        var view = self
        let presenter = GameSessionPresenter()
        presenter.view = view
        
        let interactor = GameSessionInteractor(presenter: presenter)
        view.interactor = interactor
        return view
    }
}

struct GameSessionView: View {
    @ObservedObject var gameSessionObs = GameSessionObservableObject()
    var interactor: GameSessionInteractor?

    var gameKeyboardView: GameKeyboardView
    init() {
        self.gameKeyboardView = GameKeyboardView(
            gameKeyboardObs: GameKeyboardObs())
        .configureView()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                // header
                GameHeaderView(levelText: $gameSessionObs.levelText,
                               scoreText: $gameSessionObs.scoreText,
                               timerText: $gameSessionObs.timerText,
                               bloodText: $gameSessionObs.bloodText)

                // Image
                GameGuessView(imageKey: $gameSessionObs.imageKey,
                              scale: .constant(1.0))
                .padding(5)
                //.frame(width: 100, height: 100, alignment: .center)
                .background {
                    RoundedRectangle(cornerRadius:15)
                        .stroke()
                        .fill(.black)
                }.padding(20)
                
                // keyboard or menu
                VStack {
                    if (gameSessionObs.isActive) {
                        gameKeyboardView
                    } else {
                        Button("start") {
                            interactor?.startGame()
                            updateKeyboardView()
                        }
                    }
                }
            }//.navigationTitle("LEVEL \(gameSessionObs.levelText)")
            .onAppear {
                interactor?.endGame()
                updateKeyboardView()
            }
        }
    }
    
    private func updateKeyboardView() {
        let word: [String] = interactor?.gameSession.config.word ?? []
        
        gameKeyboardView.interactor?.reset(word: word)
        gameKeyboardView.interactor?.gameSessionScorer = interactor
    }
}

extension GameSessionView: GameSessionViewProtocol {
    func displayControl(viewModel: GameSessionViewModel.Control) {
        gameSessionObs.isActive = viewModel.enabled
        gameSessionObs.imageKey = viewModel.imageKey
    }
    
    func displayHeaderView(viewModel: GameSessionViewModel.Header) {
        gameSessionObs.scoreText = viewModel.scoreText
        gameSessionObs.bloodText = viewModel.bloodText
        gameSessionObs.timerText = viewModel.timerText
        gameSessionObs.levelText = viewModel.levelText
    }
}

class GameSessionObservableObject: ObservableObject {
    @Published var timerText = ""
    
    var scoreText = ""
    var bloodText = ""
    var levelText = ""
    
    var imageKey = "questionmark"
    var isActive = false
}

struct GameSessionView_Previews: PreviewProvider {
    static var previews: some View {
        GameSessionView().configureView()
    }
}
