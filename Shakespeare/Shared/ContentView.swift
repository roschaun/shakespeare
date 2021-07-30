//
//  ContentView.swift
//  Shared
//
//  Created by Roschaun Johnson on 7/30/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Shakespeare")
            .padding()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
