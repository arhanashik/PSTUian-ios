//
//  Alerts.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/02.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
    var action: () -> Void = {}
}

struct AlertContext {
    static let success = AlertItem(
        title: Text("Success!"),
        message: Text("Operation successful. Everything seems alright!"),
        buttonTitle: Text("Dismiss")
    )
    
    static let error = AlertItem(
        title: Text("Ops, failed!"),
        message: Text("Please check if everything is alright and try again. Sorry for the inconvenience."),
        buttonTitle: Text("Dismiss")
    )
    
    static let loading = AlertItem(
        title: Text("Loading"),
        message: Text("Please wait while the operation is being completed"),
        buttonTitle: Text("Cancel")
    )
    
    static let confirmation = AlertItem(
        title: Text("Confirmation"),
        message: Text("Are you surely want to do this?"),
        buttonTitle: Text("Confirm")
    )
}
