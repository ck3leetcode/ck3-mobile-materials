//
//  GameSessionModel.swift
//  TicTacBomb
//
//  Created by Chris K on 11/12/22.
//

import Foundation
import SwiftUI

struct GameSession {
    static func create(config: Config = Config()) -> GameSession {
        return GameSession(config: config, state: State.new)
    }
    
    enum State {
        case initializing
        case new
        case inprogress
        case won
        case lost
    }

    struct Config {
        let level: Int = 1
        let blood: Int = 3
        let speed: Int = 1
        let poolSize: Int = 10
        let word: [String] = ["S", "U", "N"]
        let image = "sun.max.fill"
    }
        
    let config: Config
    
    var state: State
    var score: Int = 0
    var hitCount: Int = 0
    var bloodCount: Int = 3
    var timeCount: Int = 0
}
    

struct GameSessionViewModel {
    class Header {
        var levelColor: Color = .black
        var levelText: String = ""
        
        var scoreColor: Color = .black
        var scoreText: String = ""
        
        var bloodColor: Color = .black
        var bloodText: String = ""
        
        var timeColor: Color = .black
        var timerText: String = ""
    }
    
    class Control {
        var enabled: Bool = false
        var imageKey: String = "questionmark"
    }
}
