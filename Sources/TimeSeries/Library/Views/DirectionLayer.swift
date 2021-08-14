//
//  DirectionLayer.swift
//  DirectionLayer
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

@available(macOS 12.0, iOS 15.0, *)
public struct DirectionLayer: View {
  @EnvironmentObject var manager: ChartManager
  
  var start: ChartDouble
  var end: ChartDouble
  var size: CGSize
  var color: Color?
  
  var startRect: CGRect { manager.translate(start, size: size) }
  var endRect: CGRect { manager.translate(end, size: size) }
  
  public var body: some View {
    ZStack {
    Path { path in
      path.move(to: CGPoint(x: startRect.maxX, y: size.height - startRect.size.height))
      path.addLine(to: CGPoint(x: endRect.maxX, y: size.height - endRect.size.height))
    }
    .stroke(color ?? .lightGray, lineWidth: 2)
    }
    .frame(width: 1, height: 1)
    .foregroundColor(color ?? .lightGray)
    .background(.orange.opacity(0.2))
    .position(x: 0, y: 0)
  }
}

@available(macOS 12.0, iOS 15.0, *)
internal struct DirectionLayer_Previews: PreviewProvider {
  static var previews: some View {
    DirectionLayer(start: ChartDouble(Date(), 50), end: ChartDouble(Date(), 100), size: .preview)
  }
}
