//
//  BatchVM.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/31.
//

import SwiftUI

class BatchVM: BaseVM<BatchEntity> {
    
    convenience init(repo: BatchRepo = BatchRepo()) {
        self.init(repo)
        getAll(url: Api.Batch.GetAll)
    }
}
