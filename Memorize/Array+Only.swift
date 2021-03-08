//
//  Array+Only.swift
//  Memorize
//
//  Created by Rokas Mikelionis on 2021-01-18.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
