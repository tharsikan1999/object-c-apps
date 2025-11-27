//
//  FrameWorkDetailsView.swift
//  FrameWorks
//
//  Created by Tharsikan Sathasivam on 2025-11-27.
//

import SwiftUI

struct FrameWorkDetailsView: View {
    
    
    var frameWork: Framework = MockData.sampleFramework
    
    @Binding var isdetailViewShowing: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isdetailViewShowing = false
                }) {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.label))
                }
                .padding(.trailing, 20)
                .padding(.top, 20)
            }

            Spacer()

            VStack {
                FrameWorkView(frameWork: frameWork)
                Text(frameWork.description)
                    .font(.body)
                    .foregroundColor(Color(.label))
                    .padding()

                FButton(title: "Learn More") {
                    // Open the framework URL
                    if let url = URL(string: frameWork.urlString) {
                        #if canImport(UIKit)
                        UIApplication.shared.open(url)
                        #endif
                    }
                    
                } .padding(.top, 100)
                
            }
            .padding(.top, 30)

            Spacer()
            
        }
    }
}

#Preview {
    FrameWorkDetailsView(
        frameWork: MockData.sampleFramework,
        isdetailViewShowing: .constant(true)
    )
    .padding()
}
