//
//  RepoError.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/31.
//

import SwiftUI

enum RepoError: Error, CustomStringConvertible {
    case apiError(error: ApiError?)
    case localError(error: String?)
    case unknown
    
    // for user
    var localizedDescription: String {
        switch self {
            case .apiError(let error):
            return error?.localizedDescription ?? "Sorry, could not connect to the server."
            case .localError(let error):
                return error ?? "Sorry, something went wrong in repo."
            case .unknown:
                return "Sorry, something went wrong."
        }
    }
    
    // for debugging
    var description: String {
        switch self {
        case .apiError(let error):
            return error?.localizedDescription ?? "server error"
        case .localError(let error):
            return error ?? "local repo error"
        case .unknown:
            return "unknown error"
        }
    }
}
