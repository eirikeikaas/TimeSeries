//
//  Date.swift
//  Date
//
//  Created by Eirik Monslaup Eikås on 05/08/2021.
//

import SwiftUI

internal extension Date {
  func adding(_ number: Int, _ component: Calendar.Component) -> Date {
    return Calendar.current.date(byAdding: component, value: number, to: self) ?? self
  }
  
  func distance(to date: Date, granularity component: Calendar.Component) -> CGFloat {
    let components = Calendar.current.dateComponents([component], from: self, to: date)
    let distance = CGFloat(components.value(for: component) ?? 0)
    
    return distance
  }
  
  
  func start(of component: Calendar.Component) -> Date? {
    let components = Calendar.current.dateComponents(Set(Calendar.Component.orderedCases.before(component)), from: self)
    let date = Calendar.current.date(from: components)
    return date
  }
  
  func formatted(for granularity: Calendar.Component) -> String {
    let formatter = DateFormatter()
    
    switch granularity {
    case .month:
      formatter.dateFormat = "MMM"
    default:
      formatter.dateFormat = "dd/MM/YY"
    }
    
    return formatter.string(from: self)
  }
}

internal extension Calendar.Component {
  public static var orderedCases: [Calendar.Component] = [
    .nanosecond,
    .second,
    .minute,
    .hour,
    .day,
    .weekday,
    .weekOfMonth,
    .month,
    .quarter,
    .weekOfYear,
    .year,
    .era,
  ]
}
