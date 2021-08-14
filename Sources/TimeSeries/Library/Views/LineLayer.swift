//
//  LineLayer.swift
//  LineLayer
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

@available(iOS 15.0, *)
public struct LineLayer: View {
  @EnvironmentObject var manager: ChartManager
  
  var index: Int
  var size: CGSize
  var cubic: Bool
  var current: ChartDouble
  var next: ChartDouble
  var start: CGRect { manager.translate(current, size: size) }
  var end: CGRect { manager.translate(next, size: size) }
  var color: Color?
  
  var width: CGFloat { end.maxX - start.maxX }
  var inset: CGFloat { manager.style.diameter / 2 }
  
  public var body: some View {
    Path { path in
      path.move(to: CGPoint(x: 0, y: 0))
      if cubic {
        path.addLine(to: CGPoint(x: width, y: 0))
      }
      path.addLine(to: CGPoint(x: width, y: start.height - end.height))
    }
    .stroke(color ?? .lightGray, lineWidth: 2)
    .frame(width: 1, height: 1)
    .background(.red.opacity(0.1))
    .position(
      x: start.maxX,
      y: size.height - start.height
    )
  }
}

internal struct LineLayer_Previews: PreviewProvider {
  
  
  static var previews: some View {
    LineLayer(index: 1, size: .preview, cubic: true, current: ChartDouble(Date(), 50), next: ChartDouble(Date(), 100))
      .environmentObject(ChartManager(layers: [Layer(type: .line)], style: ChartStyle()))
  }
}
