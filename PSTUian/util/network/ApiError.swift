//
//  ApiError.swift
//  PSTUian
//
//  Created by Md Hasnain on 2021/12/28.
//

import Foundation

enum ApiError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case server(error: String?)
    case unknown
    
    // for user
    var localizedDescription: String {
        switch self {
        case .badURL, .parsing, .unknown:
            return "Sorry, something went wrong."
        case .badResponse(_):
            return "Sorry, could not connect to the server."
        case .url(let error):
            return error?.localizedDescription ?? "Sorry, something went wrong."
        case .server(let error):
            return error ?? "Sorry, could not connect to the server."
        }
    }
    
    // for debugging
    var description: String {
        switch self {
        case .badURL:
            return "invalid url"
        case .badResponse(let statusCode):
            return "bad response with status code \(statusCode)"
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .server(let error):
            return error ?? "server error"
        case .unknown:
            return "unknown error"
        }
    }
}
