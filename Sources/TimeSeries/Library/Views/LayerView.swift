//
//  LayerView.swift
//  LayerView
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

public struct LayerView: View {
  @EnvironmentObject var manager: ChartManager
  
  var layer: Layer
  var size: CGSize
  var data: [ChartDouble] { layer.data?.data ?? [] }
  var dates: [Date] { manager.layers.data.dates.array(for: manager.style.scope) }
  
  public var body: some View {
    ZStack() {
      ForEach(dates.indices, id: \.self) { idx in
        switch layer.type {
        case .bar:
          BarLayer(index: idx, size: size, value: data.sum(for: dates[idx], granularity: manager.style.scope), color: layer.color, labels: layer.labelType)
        case .dottedLine:
          DotLayer(index: idx, size: size, value: data.sum(for: dates[idx], granularity: manager.style.scope), color: layer.color, labels: layer.labelType)
          
          if idx + 1 < dates.endIndex {
            LineLayer(index: idx, size: size, cubic: false, current: data.sum(for: dates[idx], granularity: manager.style.scope), next: data.sum(for: dates[idx + 1], granularity: manager.style.scope), color: layer.color)
          }
        case .dottedLineCubic:
          DotLayer(index: idx, size: size, value: data.sum(for: dates[idx], granularity: manager.style.scope), color: layer.color, labels: layer.labelType)
          
          if idx + 1 < dates.endIndex {
            LineLayer(index: idx, size: size, cubic: true, current: data.sum(for: dates[idx], granularity: manager.style.scope), next: data.sum(for: dates[idx + 1], granularity: manager.style.scope), color: layer.color)
          }
        case .line:
          if idx + 1 < dates.endIndex {
            LineLayer(index: idx, size: size, cubic: false, current: data.sum(for: dates[idx], granularity: manager.style.scope), next: data.sum(for: dates[idx + 1], granularity: manager.style.scope), color: layer.color)
          }
        case .lineCubic:
          if idx + 1 < dates.endIndex {
            LineLayer(index: idx, size: size, cubic: true, current: data.sum(for: dates[idx], granularity: manager.style.scope), next: data.sum(for: dates[idx + 1], granularity: manager.style.scope), color: layer.color)
          }
        default:
          EmptyView()
        }
      }
      switch layer.type {
      case .trend(let from, let to, let value):
        TrendLayer(from: from, to: to, size: size, value: value, color: layer.color)
      case .direction(let start, let end):
        DirectionLayer(start: start, end: end, size: size, color: layer.color)
      case .constant(let value):
        ConstantLayer(value: value, size: size, color: layer.color)
      default:
        EmptyView()
      }
    }
    .frame(width: manager.scale(size).width, height: size.height)
    .offset(y: -24)
    //    .background(Color.purple.opacity(0.1))
    .padding(.vertical, 15)
  }
}


internal struct LayerView_Previews: PreviewProvider {
  static var previews: some View {
    LayerView(layer: Layer(type: .constant(value: 50)), size: CGSize(width: 200, height: 200))
      .environmentObject(ChartManager(layers: [Layer(type: .line)], style: ChartStyle()))
  }
}
