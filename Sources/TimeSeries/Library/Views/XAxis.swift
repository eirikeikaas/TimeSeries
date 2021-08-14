//
//  XAxis.swift
//  XAxis
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

@available(macOS 12.0, iOS 15.0, *)
internal struct XAxis: View {
  @EnvironmentObject var manager: ChartManager
  
  var size: CGSize
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      if manager.style.xContains([.tick, .both]) {
        Rectangle()
          .fill(Color.tickColor)
          .frame(width: 1, height: size.height)
          .position(x: 0, y: size.height / 2)
          .offset(x: 0, y: -4)
      }
      ForEach(manager.x(size).ticks.indices, id: \.self) { tick in
        if manager.style.xContains([.label, .both]) {
          Text(manager.x(size).ticks[tick].formatted(for: manager.style.scope))
            .font(.footnote)
            .foregroundColor(.tickTextColor)
            .multilineTextAlignment(.trailing)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .rotationEffect(.degrees(90), anchor: .bottom)
            .position(x:manager.translate(manager.x(size).ticks[tick], size: size).minX, y: size.height)
            .offset(x: manager.style.size / 2, y: 10)
        }
        
        if manager.style.xContains([.tick, .both]) {
          Rectangle()
            .fill(Color.tickColor)
            .frame(width: 1, height: size.height)
            .fixedSize()
            .position(x: manager.translate(manager.x(size).ticks[tick], size: size).maxX, y: size.height / 2)
            .offset(x: manager.style.spacedSize / 2, y: -4)
        }
      }
    }
    .frame(width: manager.scale(size).width, height: manager.scale(size).height)
    .fixedSize()
//    .background(.purple.opacity(0.1))
    .position(x: manager.scale(size).width / 2, y: size.height / 2)
  }
}

@available(macOS 12.0, iOS 15.0, *)
internal struct YAxis_Previews: PreviewProvider {
  static var previews: some View {
    YAxis(size: .preview)
  }
}
