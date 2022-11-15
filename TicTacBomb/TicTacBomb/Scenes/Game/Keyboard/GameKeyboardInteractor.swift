//
//  GameKeyboardInteractor.swift
//  TicTacBomb
//
//  Created by Chris K on 11/25/22.
//

import Foundation


class GameKeyboardInteractor {
    private(set) var word: [String] = []
    private(set) var selectedKeys: [String] = []

    let presenter: GameKeyboardPresenter
    var gameSessionScorer: GameSessionScorer?
    
    init(presenter: GameKeyboardPresenter) {
        self.presenter = presenter
    }
    
    func reset(word: [String]) {
        self.word = word
        self.selectedKeys = []
        presenter.presentView(correct: [], incorrect: [])
    }
    
    func tap(key: String) {
        if selectedKeys.contains(key) {
            return
        }

        selectedKeys.append(key)
        let hit = word.contains(key)
        let _ = hit ? gameSessionScorer?.hit() : gameSessionScorer?.miss()
        
        presenter.presentView(correct: filterKeys(corrected: true),
                              incorrect: filterKeys(corrected: false))
    }
    
    private func filterKeys(corrected: Bool) -> [String] {
        return selectedKeys.filter { word.contains($0)  == corrected }
    }
}
