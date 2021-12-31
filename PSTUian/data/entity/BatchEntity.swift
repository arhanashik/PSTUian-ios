//
//  BatchEntity.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/31.
//

import SwiftUI

struct BatchEntity: Codable, Identifiable {
    let id: Int
    let name: String
    let title: String?
    let session: String
    let facultyId: Int
    let totalStudent: Int
    let registeredStudent: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case title
        case session
        case facultyId = "faculty_id"
        case totalStudent = "total_student"
        case registeredStudent = "registered_student"
    }
    
    static func example1() -> BatchEntity {
        return BatchEntity(id: 1, name: "Ag 1st Batch", title: "Ag 1st Batch", session: "2000-2001", facultyId: 1, totalStudent: 10, registeredStudent: 2)
    }
    
    static func example2() -> BatchEntity {
        return BatchEntity(id: 2, name: "Cse 11th Batch", title: "Cse 12th Batch", session: "2013-2014", facultyId: 2, totalStudent: 65, registeredStudent: 6)
    }
    
    static func example3() -> BatchEntity {
        return BatchEntity(id: 3, name: "Cse 12th Batch", title: "Cse 12th Batch", session: "2014-2015", facultyId: 2, totalStudent: 78, registeredStudent: 3)
    }
}
