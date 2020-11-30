//
//  ContentView.swift
//  StoreExample
//
//  Created by dph on 2020/11/30.
//

import SwiftUI



enum ButtonAction {
    case increase
    case decrease
}


struct ContentView: View {
    @ObservedObject var store: Store = Store<Int, ButtonAction>(initial: 0) { (count, action) -> Int in
        if action == .increase {
            return count + 1
        } else {
            return count - 1
        }
    }
    
    
    var body: some View {
        Text("\(self.store.state)")
        Button("increase") {
            self.store.dispartcher(action: .increase)
        }
        Button("decrease"){
            self.store.dispartcher(action: .decrease)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
