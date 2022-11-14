//
//  ContentView.swift
//  TicTacBomb
//
//  Created by Chris K on 11/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GameSessionView().configureView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
