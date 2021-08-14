//
//  FloatingPoint.swift
//  FloatingPoint
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import Foundation

internal extension FloatingPoint {
  func rounded(to n: Int) -> Self {
    let n = Self(n)
    return (self / n).rounded() * n
  }
}


