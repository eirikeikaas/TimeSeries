//
//  ChartManager.swift
//  ChartManager
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

public class ChartManager: ObservableObject {
  @Published private(set) var layers: [Layer]
  var style: ChartStyle
  
  init(layers: [Layer], style: ChartStyle) {
    self.layers = layers
    self.style = style
  }
  
  func y(_ size: CGSize) -> TickSet<Double> {
    return TickSet<Double>.yTicks(with: layers, for: size, style: style)
  }
  
  func x(_ size: CGSize) -> TickSet<Date> {
    return TickSet<Date>.xTicks(with: layers, for: size, in: style.scope, style: style)
  }
  
  func scale(_ size: CGSize) -> CGSize {
    guard let startDate = layers.allDates.min() else { return .zero }
    guard let endDate = layers.allDates.max() else { return .zero }
    let distance = startDate.distance(to: endDate, granularity: style.scope)
    
    print(startDate, endDate, y(size).spacedSize * distance)
    
    return CGSize(
      width: x(size).spacedSize * distance,
      height: size.height
    )
  }
  
  func translate(_ value: ChartDouble, size: CGSize) -> CGRect {
    guard let startDate = layers.allDates.min() else { return .zero }
    let distance = startDate.distance(to: value.date, granularity: style.scope)
    
    print(distance, x(size).size, x(size).spacedSize, x(size).spacedSize * distance)
    
    return CGRect(
      x: x(size).spacedSize * distance,
      y: size.height / 2,
      width: y(size).size,
      height: value.value / TickSet<Date>.scale(for: layers).height * size.height
    )
  }
  
  func translate(_ date: Date, size: CGSize) -> CGRect {
    return translate(ChartDouble(date, 0), size: size)
  }
  
  func translate(_ value: Double, size: CGSize) -> CGRect {
    return translate(ChartDouble(Date(), value), size: size)
  }
  
  func offsetFor(index: Int, size: CGSize) -> CGFloat {
    return 0
  }
}
