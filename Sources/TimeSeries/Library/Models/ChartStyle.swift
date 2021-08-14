//
//  ChartStyle.swift
//  ChartStyle
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

public class ChartStyle {
  var xAxisStyle: AxisStyle { .both }
  var yAxisStyle: AxisStyle { .both }
  var showAxes: Bool { true }
  var scope: Calendar.Component = .month
  var diameter: Double { 6 }
  var size: CGFloat { 20 }
  var spacing: CGFloat { 10 }
  var spacedSize: CGFloat { size + spacing }
  
  public init() {
    
  }
  
  func xContains(_ options: [AxisStyle]) -> Bool {
    return options.contains(where: { $0 == xAxisStyle })
  }

  func yContains(_ options: [AxisStyle]) -> Bool {
    return options.contains(where: { $0 == yAxisStyle })
  }
}

public class NoAxesChartStyle: ChartStyle {
  override var showAxes: Bool { false }
}
