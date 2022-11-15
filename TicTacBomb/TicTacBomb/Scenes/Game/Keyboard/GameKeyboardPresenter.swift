//
//  GameKeyboardVIP.swift
//  TicTacBomb
//
//  Created by Chris K on 11/25/22.
//

import Foundation

protocol GameKeyboardViewProtocol {
    func displayKeyboard(correct: [String], incorrect: [String])
}

class GameKeyboardPresenter {
    //view
    var view: GameKeyboardViewProtocol
    init(view: GameKeyboardViewProtocol) {
        self.view = view
    }
    
    func presentView(correct: [String], incorrect: [String]) {
        self.view.displayKeyboard(correct: correct, incorrect: incorrect)
    }
}

