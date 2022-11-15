//
//  GameGuessView.swift
//  TicTacBomb
//
//  Created by Chris K on 11/20/22.
//

import SwiftUI

struct GameGuessView: View {
    @Binding var imageKey: String
    @Binding var scale: CGFloat
    
    var body: some View {
        ZStack {
            Color.white // For the background. If you don't need a background, you don't need the ZStack.
          
            LinearGradient(
                gradient: Gradient(colors: [.yellow, .orange]),
                startPoint: .top,
                endPoint: .bottom)
            .mask(Image(systemName: imageKey)
                .resizable()
                .padding()
                .aspectRatio(contentMode: .fit))
        }
    }
}

struct GameGuessView_Previews: PreviewProvider {
    static var previews: some View {
        GameGuessView(imageKey: .constant("sun.max.fill"),
                      scale: .constant(2.0))
    }
}
