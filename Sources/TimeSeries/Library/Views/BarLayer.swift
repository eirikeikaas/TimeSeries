//
//  BarLayer.swift
//  BarLayer
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

@available(iOS 15.0, *)
public struct BarLayer: View {
  @EnvironmentObject var manager: ChartManager
  var index: Int
  var size: CGSize
  var value: ChartDouble
  var rect: CGRect { manager.translate(value, size: size) }
  var color: Color?
  var labels: LabelType
  
  public var body: some View {
    ZStack(alignment: .bottomLeading) {
      VStack {
        Spacer()
        Rectangle()
          .fill(color ?? .lightGray)
          .cornerRadius(4)
          .frame(idealWidth: manager.x(size).size, minHeight: 5, idealHeight: rect.height)
          .fixedSize()
      }
      if labels == .all {
        Text("\(Int(value.value))")
          .foregroundColor(color ?? .lightGray)
          .frame(width: 30)
          .multilineTextAlignment(.center)
          .offset(x: -5, y: -rect.height)
      }
    }
    .frame(height: size.height)
    .position(x: rect.maxX, y: rect.minY)
  }
}

internal struct BarLayer_Previews: PreviewProvider {
  static var previews: some View {
    BarLayer(index: 1, size: .preview, value: ChartDouble(Date(), 50), labels: .none)
      .environmentObject(ChartManager(layers: [Layer(type: .line)], style: ChartStyle()))
  }
}
