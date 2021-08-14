//
//  DataSet.swift
//  DataSet
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

public typealias ChartDouble = (date: Date, value: Double)

public struct DataSet {
  static var empty = DataSet(data: [])
  public static var preview = DataSet(data: previewData)
  
  public var data: [ChartDouble]
}

fileprivate var previewData: [ChartDouble] = [
  (Date(), 0),
  (Date().adding(1, .month), 25),
  (Date().adding(2, .month), 50),
  (Date().adding(3, .month), 100),
  (Date().adding(4, .month), 105),
  (Date().adding(13, .weekOfYear), 105),
  (Date().adding(5, .month), 80),
  (Date().adding(6, .month), 100),
  (Date().adding(7, .month), 105),
  (Date().adding(8, .month), 120),
  (Date().adding(9, .month), 190),
  (Date().adding(10, .month), 170),
  (Date().adding(11, .month), 150),
  (Date().adding(12, .month), 105),
  (Date().adding(13, .month), 80),
  (Date().adding(14, .month), 100),
  (Date().adding(15, .month), 105),
  (Date().adding(16, .month), 120),
  (Date().adding(17, .month), 180),
  (Date().adding(18, .month), 170),
  (Date().adding(19, .month), 150),
  (Date().adding(20, .month), 210),
  (Date().adding(21, .month), 330),
  (Date().adding(24, .month), 420)
]
