//
//  YAxis.swift
//  YAxis
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

internal struct YAxis: View {
  @EnvironmentObject var manager: ChartManager
  
  var size: CGSize
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      if manager.style.yContains([.label, .both]) {
        ForEach(manager.y(size).ticks.indices, id: \.self) { idx in
          HStack {
            Spacer()
            Text("\(Int(manager.y(size).ticks[idx]))")
              .font(.footnote)
              .foregroundColor(.tickTextColor)
              .multilineTextAlignment(.trailing)
              .lineLimit(1)
              .minimumScaleFactor(0.5)
            //.background(.yellow.opacity(0.2))
          }
          .frame(maxWidth: 60, maxHeight: manager.y(size).size)
          .padding(.vertical, 1)
          .position(x: 5, y: size.height - manager.translate(manager.y(size).ticks[idx], size: size).height)
        }
        // .background(.green.opacity(0.2))
      }
      
      if !manager.style.yContains([.none]) {
        Rectangle()
          .fill(Color.tickColor)
          .frame(width: 1, height: size.height - 4)
          .offset(x: 40, y: 4)
      }
      
      if manager.style.yContains([.tick, .both]) {
        ForEach(manager.y(size).ticks.indices, id: \.self) { idx in
          Rectangle()
            .fill(Color.tickColor)
            .frame(width: size.width - 40, height: 1)
            .fixedSize()
            .position(x: 20 + (size.width / 2), y: size.height - manager.translate(manager.y(size).ticks[idx], size: size).height)
        }
        .frame(width: size.width, height: size.height)
        .fixedSize()
      }
    }
    //    .background(.orange.opacity(0.1))
    .offset(x: 0, y: 0)
    
  }
}

internal struct XAxis_Previews: PreviewProvider {
  static var previews: some View {
    XAxis(size: .preview)
  }
}
