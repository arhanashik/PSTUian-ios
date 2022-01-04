//
//  Converter.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/03.
//

import SwiftUI

// Convert Encodable to dictonary
extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
