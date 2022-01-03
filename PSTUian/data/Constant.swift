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

let LOCAL_API_SERVER = "http://192.168.1.101:8888/PSTUian-web/api/mobile/v1"
let DEV_API_SERVER = "https://api-dev.pstuian.com/mobile/v1"
let BASE_API_URL = LOCAL_API_SERVER

let DEVICE_API_PATH = "\(BASE_API_URL)/device.php?call="
let CONFIG_API_PATH = "\(BASE_API_URL)/config.php?call="
let AUTH_API_PATH = "\(BASE_API_URL)/auth.php?call="
let SLIDER_API_PATH = "\(BASE_API_URL)/slider.php?call="
let FACULTY_API_PATH = "\(BASE_API_URL)/faculty.php?call="
let BATCH_API_PATH = "\(BASE_API_URL)/batch.php?call="
class Api {
    static let GET_CONFIG =  "\(CONFIG_API_PATH)getLatest"
    
    class Device {
        static let GetAll = "\(DEVICE_API_PATH)getAll"
        static let Register = "\(DEVICE_API_PATH)register"
        static let UpdateFcmToken = "\(DEVICE_API_PATH)updateFcmToken"
    }
    
    class Auth {
        static let SignIn = "\(AUTH_API_PATH)signIn"
        static let SignUpStudent = "\(AUTH_API_PATH)signUpStudent"
        static let SignUpTeacher = "\(AUTH_API_PATH)signUpTeacher"
        static let SignOut = "\(AUTH_API_PATH)signOut"
        static let SignOutFromAllDevice = "\(AUTH_API_PATH)signOutFromAllDevice"
        static let ChangePassword = "\(AUTH_API_PATH)changePassword"
        static let ForgotPassword = "\(AUTH_API_PATH)forgotPassword"
        static let EmailVerification = "\(AUTH_API_PATH)resendVerificationEmail"
    }
    
    class Slider {
        static let GetAll = "\(SLIDER_API_PATH)getAll"
    }
    
    class Faculty {
        static let GetAll = "\(FACULTY_API_PATH)getAll"
    }
    
    class Batch {
        static let GetAll = "\(BATCH_API_PATH)getAll"
    }
}

enum HTTP {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
}

class Key {
    class UserDefaults {
        static let DATA_REFRESH_VERSION = "data_refresh_version"
    }
    class KeyChain {
        static let AUTH_TOKEN = "auth_token"
        static let CONFIG = "config"
        static let DEVICE = "device"
        static let DEVICE_ID = "device_id"
        static let USER = "user"
        static let USER_TYPE = "user_type"
        class Account {
            static let PSTUIAN = "pstuian"
        }
    }
}

class Param {
    static let AUTH_TOKEN = "auth_token"
    static let FCM_TOKEN = "fcm_token"
}

enum UserType: String {
    case student = "student"
    case teacher = "teacher"
}
