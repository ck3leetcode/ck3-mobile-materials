//
//  GameSessionModel.swift
//  TicTacBomb
//
//  Created by Chris K on 11/12/22.
//

import Foundation
import SwiftUI

struct GameSession {
    static func create() -> GameSession {
        return GameSession(state: State.new, config: Config())
    }
    
    enum State {
        case initializing
        case new
        case inprogress
        case won
        case lost
    }

    struct Config {
        var level: Int = 1
        var speed: Int = 1
        var poolSize: Int = 10
        var duration: Int = 10000
        // let theme
    }
    
    var state: State
    var config: Config
    
    var score: Int = 0
    var hitCount: Int = 0
    var missCount: Int = 0
    var timeRemain: Int = 10000
    
    var targetCellId: String = ""
}
    

struct GameSessionViewModel {
    class Score {
        var color: Color = .black
        var text: String = ""
    }
    
    class Timer {
        var color: Color = .black
        var text: String = ""
    }
    
    class Cell {
        var image: String = ""
        var isBomb: Bool = false
        var score: Int = 0
    }
}
