//
//  GameHeaderView.swift
//  TicTacBomb
//
//  Created by Chris K on 11/19/22.
//

import Foundation
import SwiftUI

struct GameHeaderView: View {
    @Binding var levelText: String
    @Binding var scoreText: String
    @Binding var timerText: String
    @Binding var bloodText: String
    
   // @ObservedObject var gameSessionObs: GameSessionObservableObject
    
    var body: some View {
        VStack {
            Text("LEVEL \(levelText)")
                .font(.system(size: 25, weight: .bold, design: .monospaced))
                .kerning(3)
                .foregroundColor(.red)
            
             HStack(alignment: .center, spacing: 5) {
                 Group {
                     Image(systemName: "rosette")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .foregroundColor(.black)
                     Text("\(scoreText)")
                         .font(.system(size: 15, weight: .bold, design: .monospaced))
                         .foregroundColor(.black)
                 }
                 
                 Spacer()
                
                 Group {
                     Image(systemName: "timer")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .foregroundColor(.black)
                     
                     Text("\(timerText)")
                         .font(.system(size: 15, weight: .bold, design: .monospaced))
                         .foregroundColor(.black)
                 }
                 
                 Spacer()
                
                 Group {
                     Image(systemName: "drop.fill")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .foregroundColor(.red)

                    Text(bloodText)
                        .font(.system(size: 15, weight: .bold, design: .monospaced))
                        .foregroundColor(.black)
                 }

                
            }.frame(width: UIScreen.main.bounds.width * 0.9, height: 30, alignment: .center).padding(.all, 5)
            
        }
    }
}


struct GameHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        GameHeaderView(levelText: .constant("1"),
                       scoreText: .constant("76"),
                       timerText: .constant("60"),
                       bloodText: .constant("3"))
    }
}
