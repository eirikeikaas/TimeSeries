//
//  ConstantLayer.swift
//  ConstantLayer
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ConstantLayer: View {
  @EnvironmentObject var manager: ChartManager
  
  var value: Double
  var size: CGSize
  var color: Color?
  var label: Bool = true
  
  var rect: CGRect { manager.translate((Date(), value), size: size) }
  var scale: CGSize { manager.scale(size) }
  
  public var body: some View {
    ZStack(alignment: .bottomLeading) {
      Rectangle()
        .fill(color ?? .lightGray)
        .frame(width: scale.width, height: 2)
      if label {
        Text("\(Int(value))")
          .foregroundColor(color ?? .lightGray)
          .font(.footnote)
          .position(x: scale.width - 10, y: -10)
      }
    }
    .frame(width: scale.width, height: 2)
    .position(x: scale.width / 2, y: size.height - rect.size.height)
  }
}

internal struct ConstantLayer_Previews: PreviewProvider {
  static var previews: some View {
    ConstantLayer(value: 50, size: .preview)
      .environmentObject(ChartManager(layers: [Layer(type: .line)], style: ChartStyle()))
  }
}
