//
//  GameKeyboardView.swift
//  TicTacBomb
//
//  Created by Chris K on 11/20/22.
//

import SwiftUI

class GameKeyboardObs: ObservableObject {
    @Published var correctKeys: [String] = []
    @Published var incorrectKeys: [String] = []
    
    func buttonBGColor(key: String) -> Color {
        if (correctKeys.contains(key)) {
            return .green
        }
        else if (incorrectKeys.contains(key)) {
            return .red
        }
        else {
            return .clear
        }
    }
}

struct GameKeyboardView: View {
    @ObservedObject var gameKeyboardObs: GameKeyboardObs
    var interactor: GameKeyboardInteractor?
    
    var body: some View {
        let keyboard = "QWERTYUIOP|ASDFGHJKL|<ZXCVBNM>"
        let lines = keyboard.split(separator: "|")
        VStack {
            ForEach(lines, id: \.self) { line in
                HStack {
                    let keyArray = line.map { String($0) }
                    ForEach(keyArray, id: \.self) { key in
                        KeyButtonView(interactor: interactor,
                                      key: key,
                                      color: gameKeyboardObs.buttonBGColor(key: key))
                    }
                }
            }
        }.padding(20)
    }
}

extension GameKeyboardView {
    func configureView() -> GameKeyboardView {
        var view = self
        let presenter = GameKeyboardPresenter(view: view)
        view.interactor = GameKeyboardInteractor(presenter: presenter)
        return view
    }
}

extension GameKeyboardView: GameKeyboardViewProtocol {
    func displayKeyboard(correct: [String], incorrect: [String]) {
        self.gameKeyboardObs.correctKeys = correct
        self.gameKeyboardObs.incorrectKeys = incorrect
    }
}

struct KeyButtonView: View {
    var interactor: GameKeyboardInteractor?
    
    let key: String
    let color: Color
    var body: some View {
        Button {
            interactor?.tap(key: key)
        } label: {
            switch key {
              case "<":
                Image(systemName: "delete.backward")
              case ">":
                Image(systemName: "return")
              default:
                Text(key)
                  .aspectRatio(1.0, contentMode: .fit)
                  .frame(maxWidth: .infinity)
              }
      }
        .padding(6)
        .background {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke()
                .fill(Color(UIColor.label))
                .background {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(color)
                }
        }
        .foregroundColor(Color(UIColor.label))
    }
}


struct GameKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        let view = GameKeyboardView(gameKeyboardObs: GameKeyboardObs()).configureView()
        view.interactor?.reset(word: ["A", "B", "C"])
        return view
    }
}
