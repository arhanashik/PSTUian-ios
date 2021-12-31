//
//  SliderModel.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/02.
//

import SwiftUI

struct SliderEntity: Codable, Identifiable {
    let id: Int
    let title: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageUrl = "image_url"
    }
    
    static func example1() -> SliderEntity {
        let slider = SliderEntity(id: 1, title: "Slider 1", imageUrl: "http://192.168.1.105:8888/PSTUian-web/uploads/slider/nil_komol.jpeg")
        return slider
    }
    
    static func example2() -> SliderEntity {
        let slider = SliderEntity(id: 2, title: "Slider 2", imageUrl: "slider2")
        return slider
    }
    
    static func example3() -> SliderEntity {
        let slider = SliderEntity(id: 3, title: "Slider 3", imageUrl: "slider3")
        return slider
    }
}
