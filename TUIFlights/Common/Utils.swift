//
//  Utils.swift
//  Common
//
//  Created by Anderson F Carvalho on 16/08/23.
//

import Foundation

public extension String {

    func hasCaseAndDiacriticInsensitivePrefix(_ prefix: String) -> Bool {
        guard let range = self.range(of: prefix, options: [.caseInsensitive, .diacriticInsensitive]) else {
            return false
        }

        return range.lowerBound == startIndex
    }
}
