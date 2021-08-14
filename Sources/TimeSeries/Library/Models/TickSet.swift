//
//  Ticks.swift
//  Ticks
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

public struct TickSet<T> {
  var ticks: [T]
  var size: CGFloat
  var spacing: CGFloat
  var spacedSize: CGFloat { size + spacing }
  
  static func xTicks(with layers: [Layer], for size: CGSize, in scope: Calendar.Component, style: ChartStyle) -> TickSet<Date> {
    guard let start = layers.allDates.min(), let end = layers.allDates.max() else { return TickSet<Date>(ticks: [], size: 20, spacing: 10) }
    var ticks: [Date] = []
    let components = Calendar.current.dateComponents([scope], from: start, to: end)
    let distance = components.value(for: scope) ?? 0
    
    for i in 0..<distance {
      guard let date = Calendar.current.date(byAdding: scope, value: i, to: start) else { continue }
      
      ticks.append(date)
    }
    
    return TickSet<Date>(ticks: ticks, size: style.size, spacing: style.spacing)
  }
  
  static func yTicks(with layers: [Layer], for size: CGSize, style: ChartStyle) -> TickSet<Double> {
    var ticks: [Double] = []
    let scale = scale(for: layers)
    
    for i in 0..<scale.count {
      ticks.append(scale.size * Double(i))
    }
    
    let height = (size.height + 12) / CGFloat(ticks.count)
    
    return TickSet<Double>(ticks: ticks, size: height, spacing: 5)
  }
  
  static func scale(for layers: [Layer]) -> (count: Int, size: Double, height: Double) {
    let max = layers.allValues.max() ?? 0
    var factor = 10.0
    
    while max / factor > 10 {
      factor *= 10
    }
    
    let size = (max / 10).rounded(to: Int(0.5 * factor))
    let height = max.rounded(to: Int(2.5 * factor)) + (1 * factor)
    
    return (
      count: 12,
      size: size,
      height: height
    )
  }
}
