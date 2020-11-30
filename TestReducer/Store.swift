//
//  Store.swift
//  StoreExample
//
//  Created by dph on 2020/11/30.
//

import Foundation
import Combine


class Store<State, Action>: ObservableObject {
    typealias Reducer = (State, Action) -> State
    private var reducer: Reducer
    
    
    private var lock: NSLock = NSLock()
    private var _state: State
    var state: State {
        lock.lock()
        
        defer {
            lock.unlock()
        }
        
        return _state
    }
    
    
    var objectWillChange = PassthroughSubject<Store, Never>()
    
    
    
    
    init(initial: State, reducer: @escaping Reducer) {
        self._state = initial
        self.reducer = reducer
    }
    
    func dispartcher(action: Action) {
        lock.lock()
        let newState = self.reducer(self._state, action)
        self._state = newState
        lock.unlock()
        objectWillChange.send(self)
    }
}
