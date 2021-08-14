//
//  DotLayer.swift
//  DotLayer
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

@available(macOS 12.0, iOS 15.0, *)
public struct DotLayer: View {
  @EnvironmentObject var manager: ChartManager
  
  var index: Int
  var size: CGSize
  var value: ChartDouble
  var rect: CGRect { manager.translate( value, size: size) }
  var color: Color?
  var labels: LabelType
  
  @State var active: Bool = false
  
  var rest: CGFloat { (manager.y(size).spacing - manager.style.diameter) / 2}
  var showLabel: Bool {
    if labels == .all { return true }
    
    let sum =  manager.layers.data.sum(by: manager.style.scope).map { $0.value }
    
    if labels == .edge {
      let first = sum.first(value: value.value, index: index)
      let edge = value.value == sum.max() || value.value == sum.min()
      
      return first && edge
    }
    
    return false
  }
  
  public var body: some View {
    ZStack(alignment: .bottomLeading) {
      Circle()
        .fill(.white)
        .frame(width: manager.style.diameter, height: manager.style.diameter, alignment: .bottomLeading)
        .overlay(
          Circle()
            .stroke(color ?? .lightGray, lineWidth: 2)
        )
      if showLabel {
        Text("\(Int(value.value))")
          .foregroundColor(color ?? .lightGray)
          .multilineTextAlignment(.center)
          .font(.footnote)
          .frame(width: 40)
          .position(x: 0, y: -10)
      }
    }
    //.background(.red)
    .frame(width: 1, height: 1)
    .fixedSize()
    .zIndex(5)
    .position(
      x: rect.maxX,
      y: size.height - rect.size.height
    )
  }
}

@available(macOS 12.0, iOS 15.0, *)
internal struct DotLayer_Previews: PreviewProvider {
  static var previews: some View {
    DotLayer(index: 1, size: .preview, value: ChartDouble(Date(), 50), labels: .none)
      .environmentObject(ChartManager(layers: [Layer(type: .line)], style: ChartStyle()))
  }
}
