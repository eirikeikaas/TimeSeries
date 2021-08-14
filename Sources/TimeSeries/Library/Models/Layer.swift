//
//  Layer.swift
//  Layer
//
//  Created by Eirik Monslaup Eikås on 04/08/2021.
//

import SwiftUI

public struct Layer {
  public var type: LayerType
  public var labelType: LabelType = .none
  public var data: DataSet?
  public var index: Double = 1.0
  public var color: Color?
  
  public init(type: LayerType, labelType: LabelType = .none, data: DataSet? = nil, index: Double = 1.0, color: Color? = nil) {
    self.type = type
    self.labelType = labelType
    self.data = data
    self.index = index
    self.color = color
  }
}
