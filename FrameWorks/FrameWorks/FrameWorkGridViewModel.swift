//
//  FrameWorkGridViewModel.swift
//  FrameWorks
//
//  Created by Tharsikan Sathasivam on 2025-11-27.
//

import SwiftUI
import Combine

final class FrameworkGridViewModel: ObservableObject {

    @Published var selectedFramework: Framework? = nil {
        didSet {
            isDetailViewShowing = true
        }
    }

    @Published var isDetailViewShowing: Bool = false
}

    

