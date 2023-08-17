//
//  Combine+CancelBag.swift
//  Common
//
//  Created by Anderson F Carvalho on 17/08/23.
//

import Foundation
import Combine

public final class CancelBag {
    public var subscriptions = Set<AnyCancellable>()
    public init() {
        subscriptions = Set<AnyCancellable>()
    }
}

public extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
