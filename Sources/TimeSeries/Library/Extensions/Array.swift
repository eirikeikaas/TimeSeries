//
//  Array.swift
//  Array
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import Foundation

internal extension Array where Element == Layer {
  var data: [ChartDouble] { self.flatMap { $0.data?.data ?? [] } }
  var allDates: [Date] { self.data.dates }
  var allValues: [Double] { self.data.values }
}

internal extension Array where Element == ChartDouble {
  var dates: [Date] { self.map { $0.date } }
  var values: [Double] { self.map { $0.value } }
  
  func sum(for date: Date, granularity: Calendar.Component) -> ChartDouble {
    let sum = self.filter { value in
      guard let interval = Calendar.current.dateInterval(of: granularity, for: date) else { return false }
      
      return interval.contains(value.date)
    }.values.sum()
    
    return ChartDouble(date: date, value: sum)
  }
  
  func sum(by granularity: Calendar.Component) -> [ChartDouble] {
    return dates.array(for: granularity).map { sum(for: $0, granularity: granularity) }
  }
}

public extension Array where Element == Date {
  func array(for component: Calendar.Component) -> [Date] {
    let dates = self.reduce(into: [Date]()) { acc, date in
      if let start = date.start(of: component), acc.first(where: { $0 == start }) == nil {
        acc.append(start)
      }
    }
    
    return dates
  }
}

public extension Array where Element == Double {
  func sum() -> Double {
    return self.reduce(into: 0) { $0 += $1 }
  }
  
  func first(value: Double, index: Int) -> Bool {
    return self.firstIndex(of: value) == index
  }
}

public extension Array where Element == Calendar.Component {
  func before(_ component: Calendar.Component) -> [Element] {
    return self.filter {
      let a = Calendar.Component.orderedCases.firstIndex(of: component)!
      let b = Calendar.Component.orderedCases.firstIndex(of: $0)!
      
      return a <= b
    }
  }
}
