//
//  TrendLayer.swift
//  TrendLayer
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

@available(macOS 12.0, iOS 15.0, *)
public struct TrendLayer: View {
  @EnvironmentObject var manager: ChartManager
  
  var from: Date
  var to: Date
  var size: CGSize
  var value: Double
  var color: Color?
  var label: Bool = true
  
  var fromRect: CGRect { manager.translate(ChartDouble(from, value), size: size) }
  var toRect: CGRect { manager.translate(ChartDouble(to, value), size: size) }
  
  var width: CGFloat { max(toRect.minX - fromRect.minX, manager.x(size).spacedSize) }
  
  public var body: some View {
    ZStack(alignment: .bottomLeading) {
      if label {
        Text("\(Int(value))")
          .font(.footnote)
          .foregroundColor(color ?? .lightGray)
          .position(x: width - 10, y: -10)
      }
      Capsule()
        .fill(color ?? .lightGray)
        .frame(width: width, height: 8, alignment: .topLeading)
        .opacity(0.6)
    }
    .frame(width: width, height: 8)
    .fixedSize()
    .position(x: (width / 2) + fromRect.minX, y: size.height - fromRect.height)
  }
}

@available(macOS 12.0, iOSApplicationExtension 15.0, *)
internal struct TrendLayer_Previews: PreviewProvider {
  static var previews: some View {
    TrendLayer(from: Date(), to: Date(), size: .preview, value: 1)
      .environmentObject(ChartManager(layers: [Layer(type: .line)], style: ChartStyle()))
  }
}
