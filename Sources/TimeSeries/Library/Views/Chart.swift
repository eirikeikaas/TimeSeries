//
//  ContentView.swift
//  Shared
//
//  Created by Eirik Monslaup Eikås on 25/07/2021.
//

import SwiftUI

var dataset = DataSet(data: [
  (Date(), 0),
  (Date(), 25),
  (Date(), 50),
  (Date(), 100),
  (Date(), 105),
  (Date(), 80),
  (Date(), 100),
  (Date(), 105),
  (Date(), 120),
  (Date(), 190),
  (Date(), 170),
  (Date(), 150),
  (Date(), 105),
  (Date(), 80),
  (Date(), 100),
  (Date(), 105),
  (Date(), 120),
  (Date(), 180),
  (Date(), 170),
  (Date(), 150),
  (Date(), 210),
  (Date(), 330),
  (Date(), 400)
])

@available(macOS 12.0, iOS 15.0, *)
public struct Chart: View {
  @ObservedObject var manager: ChartManager
  
  var style: ChartStyle
  var title: String? = "Title"
  var targetText: String? = "+500kr"
  var targetStatus: TargetStatus = .ahead
  
  var axesOffset: CGFloat { style.xContains([.tick]) ? 40 : 0 }
  
  public init(_ layers: [Layer], style: ChartStyle = ChartStyle()) {
    self.manager = ChartManager(layers: layers, style: style)
    self.style = style
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      TitleView(title: title, targetText: targetText, targetStatus: targetStatus)
        .padding(style.showAxes ? 0 : 5)
        .offset(x: 0, y: style.showAxes ? 0 : 30)
      GeometryReader { reader in
        ZStack() {
          if !style.yContains([.none]) {
            YAxis(size: reader.size)
          }
          Rectangle()
            .fill(Color.lightGray.opacity(0.1))
            .frame(width: reader.size.width, height: reader.size.height + 12)
            .offset(x: 40, y: -15)
            .cornerRadius(4)
          ScrollView(.horizontal, showsIndicators: false) {
            ZStack() {
              if !style.xContains([.none]) {
                XAxis(size: reader.size)
              }
              ForEach(manager.layers.indices, id: \.self) { i in
                LayerView(layer: manager.layers[i], size: reader.size)
                  .zIndex(manager.layers[i].index)
              }
            }
            .frame(width: manager.scale(reader.size).width, height: manager.scale(reader.size).height + 40)
            .fixedSize()
            .delaysTouches()
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged { print($0) })
            
          }
//          .background(.red.opacity(0.1))
          .frame(width: reader.size.width - 40, height: reader.size.height + 20)
          .fixedSize()
          .offset(x: 20, y: 14)
        }
        .frame(width: reader.size.width, height: reader.size.height + 6)
        .fixedSize()
      }
    }
    .accentColor(.green)
    .environmentObject(manager)
  }
}

@available(macOS 12.0, iOS 15.0, *)
internal struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    //    ScrollView(.vertical) {
    //      VStack(spacing: 50) {
    //        Group {
    //          ContentView(dataset: .constant(dataset), type: .bar, showAxes: true, trend: nil, labels: .none)
    //
    //          ContentView(dataset: .constant(dataset), type: .bar, showAxes: true, trend: nil, labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .bar, showAxes: false, trend: nil, labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .bar, showAxes: true, trend: nil, labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .dottedLine, showAxes: false, trend: nil, labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .line, showAxes: true, trend: nil, labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .dottedLineCubic, showAxes: false, trend: nil, labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .lineCubic, showAxes: true, trend: nil, labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .bar, showAxes: false, trend: .constant(value: 50), labels: .none, title: nil)
    //        }
    //        .frame(minWidth: 200, minHeight: 75, alignment: .topLeading)
    //        Group {
    //          ContentView(dataset: .constant(dataset), type: .line, showAxes: true, trend: .constant(value: 50), labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .dottedLineCubic, showAxes: true, trend: .constant(value: 50), labels: .all)
    //          ContentView(dataset: .constant(dataset), type: .bar, showAxes: true, trend: .trend(before: 50, index: 4, after: 90), labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .line, showAxes: true, trend: .trend(before: 50, index: 4, after: 90), labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .dottedLineCubic, showAxes: true, trend: .trend(before: 50, index: 4, after: 90), labels: .all)
    //          ContentView(dataset: .constant(dataset), type: .bar, showAxes: true, trend: .direction(start: 0, end: 180), labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .dottedLine, showAxes: true, trend: .direction(start: 0, end: 180), labels: .none)
    //          ContentView(dataset: .constant(dataset), type: .dottedLine, showAxes: true, trend: .direction(start: 0, end: 180), dataFocus: true, labels: .edge)
    //          ContentView(dataset: .constant(dataset), type: .dottedLineCubic, showAxes: true, trend: .direction(start: 0, end: 180), dataFocus: true, labels: .edge)
    //        }
    //        .frame(minWidth: 200, minHeight: 200, alignment: .topLeading)
    //      }
    //      .frame(minWidth: 300, minHeight: 700, alignment: .topLeading)
    //      .fixedSize()
    //    }
    
    Chart([
      Layer(type: .bar, data: dataset)
    ])
      .padding(10)
      .previewLayout(.fixed(width: 300, height: 200))
    Chart([
      Layer(type: .bar, data: .preview),
      Layer(type: .dottedLine, labelType: .none, data: .preview, color: .accentColor),
      Layer(type: .dottedLineCubic, labelType: .none, data: .preview),
      Layer(type: .trend(from: Date(), to: Date().adding(1, .month), value: 100), labelType: .none),
      Layer(type: .constant(value: 50), labelType: .none)
    ], style: NoAxesChartStyle())
      .frame(width: 300, height: 200)
      .padding(10)
      .previewLayout(.fixed(width: 300, height: 200))
  }
}

@available(macOS 12.0, iOS 15.0, *)
public struct Candle: View {
  var index: Int
  var focus: Bool
  
  public var body: some View {
    Circle()
      .fill(focus ? .accentColor : Color.lightGray)
      .frame(width: 10, height: 10, alignment: .center)
      .offset(x: 10 * CGFloat(index), y: CGFloat(-dataset.data[index].value) * 10)
  }
}

@available(macOS 12.0, iOS 15.0, *)
public extension View {
  func delaysTouches(for duration: TimeInterval = 0.25, onTap action: @escaping () -> Void = {}) -> some View {
    modifier(DelaysTouches(duration: duration, action: action))
  }
}

fileprivate struct DelaysTouches: ViewModifier {
  @State private var disabled = false
  @State private var touchDownDate: Date? = nil
  
  var duration: TimeInterval
  var action: () -> Void
  
  func body(content: Content) -> some View {
    Button(action: action) {
      content
    }
    .buttonStyle(DelaysTouchesButtonStyle(disabled: $disabled, duration: duration, touchDownDate: $touchDownDate))
    .disabled(disabled)
  }
}

@available(macOS 12.0, iOS 15.0, *)
fileprivate struct DelaysTouchesButtonStyle: ButtonStyle {
  @Binding var disabled: Bool
  var duration: TimeInterval
  @Binding var touchDownDate: Date?
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .onChange(of: configuration.isPressed, perform: handleIsPressed)
  }
  
  private func handleIsPressed(isPressed: Bool) {
    if isPressed {
      let date = Date()
      touchDownDate = date
      
      DispatchQueue.main.asyncAfter(deadline: .now() + max(duration, 0)) {
        if date == touchDownDate {
          disabled = true
          
          DispatchQueue.main.async {
            disabled = false
          }
        }
      }
    } else {
      touchDownDate = nil
      disabled = false
    }
  }
}
