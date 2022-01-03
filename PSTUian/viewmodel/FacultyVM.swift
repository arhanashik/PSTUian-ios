//
//  FacultyViewModel.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//

import SwiftUI

class FacultyVM: BaseVM<FacultyEntity> {
    
    convenience init(repo: FacultyRepo = FacultyRepo()) {
        self.init(repo)
        getAll(url: Api.Faculty.GetAll)
    }
}
