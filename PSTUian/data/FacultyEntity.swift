//
//  FacultyEntity.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//

import SwiftUI

struct FacultyEntity: Codable, Identifiable {
    let id: Int
    let shortTitle: String
    let title: String
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case shortTitle = "short_title"
        case title
        case icon
    }
    
    static func example1() -> FacultyEntity {
        let faculty = FacultyEntity(id: 1, shortTitle: "Ag", title: "Agriculture", icon: "http://192.168.1.105:8888/PSTUian-web/uploads/slider/nil_komol.jpeg")
        return faculty
    }
    
    static func example2() -> FacultyEntity {
        let faculty = FacultyEntity(id: 1, shortTitle: "CSE", title: "Computer Science And Engineering", icon: "pstulogo")
        return faculty
    }
}
