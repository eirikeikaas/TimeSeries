//
//  TitleView.swift
//  TitleView
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

@available(macOS 12.0, iOS 15.0, *)
public struct TitleView: View {
  var title: String?
  var targetText: String?
  var targetStatus: TargetStatus?
  
  public var body: some View {
    HStack {
      if title != nil {
        Text(title ?? "")
          .font(.subheadline)
        
        Spacer(minLength: 30)
        if let text = targetText, let status = targetStatus {
          Group {
            switch status {
            case .reached:
              Group {
                Text(text)
                  .padding(.vertical, 2)
                  .padding(.horizontal, 4)
                  .foregroundColor(Color.white)
                  .background(Color.accentColor)
                  .cornerRadius(5)
              }
            case .ahead:
              Group {
                Text(text)
                  .foregroundColor(.accentColor)
              }
            case .behind:
              Group {
                Text(text)
              }
            case .none:
              Group {
                Text(text)
              }
            }
          }
          .font(.caption)
        }
      }
    }
  }
}

@available(macOS 12.0, iOS 15.0, *)
internal struct TitleView_Previews: PreviewProvider {
  static var previews: some View {
    TitleView()
  }
}
