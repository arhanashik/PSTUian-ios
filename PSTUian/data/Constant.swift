//
//  Constant.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/02.
//

import SwiftUI

let primaryColor = Color(hex: 0x008577)
let color4B4B4B = Color(hex: 0x4B4B4B)

let lightGray = Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1)

let LOCAL_API_SERVER = "http://192.168.1.105:8888/PSTUian-web/api/mobile/v1"
let DEV_API_SERVER = "https://api-dev.pstuian.com/mobile/v1"
let BASE_API_URL = DEV_API_SERVER

let SLIDER_API_URL = "\(BASE_API_URL)/slider.php?call=getAll"

let FACULTY_API_PATH = "\(BASE_API_URL)/faculty.php?call="
class Api {
    class Faculty {
        static let GetAll = "\(FACULTY_API_PATH)getAll"
    }
}
