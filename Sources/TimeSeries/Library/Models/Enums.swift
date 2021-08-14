//
//  Enums.swift
//  Enums
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import Foundation

public enum LayerType {
  case dottedLine
  case line
  case bar
  case lineCubic
  case dottedLineCubic
  case constant(value: Double)
  case trend(from: Date, to: Date, value: Double)
  case direction(start: ChartDouble, end: ChartDouble)
}

public enum TrendType {
  case constant(value: Double)
  case trend(before: Double, index: Int, after: Double)
  case direction(start: ChartDouble, end: ChartDouble)
}

public enum LabelType {
  case all
  case edge
  case none
}

public enum TargetStatus {
  case reached
  case ahead
  case behind
  case none
}

public enum AxisStyle {
  case label
  case tick
  case both
  case none
}
