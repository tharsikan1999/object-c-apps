//
//  ContentView.swift
//  FrameWorks
//
//  Created by Tharsikan Sathasivam on 2025-11-27.
//

import SwiftUI

struct FrameWorkGridView: View {
    @StateObject private var viewModel = FrameworkGridViewModel()
    
    let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(MockData.frameworks) { framework in
                        FrameWorkView(frameWork: framework).onTapGesture {
                            viewModel.selectedFramework = framework
                            
                        }
                    }
                }
                .padding()
            }
                .navigationTitle("Frameworks").sheet(isPresented: $viewModel.isDetailViewShowing) {
                    FrameWorkDetailsView( frameWork: viewModel.selectedFramework ?? MockData.sampleFramework, isdetailViewShowing: $viewModel.isDetailViewShowing)
                }
        }
        .padding(.horizontal, 10)
            
        
    }
}

struct FrameWorkView: View {
    let frameWork: Framework
   
    var body: some View {
        VStack {
            Image(frameWork.imageName)
                .resizable()
                .frame(width: 90, height: 90)
            Text(frameWork.name)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.label))
                .scaledToFit()
                .minimumScaleFactor(0.6)
                .padding(.top,10)
                
        }
    }
}


#Preview{
    FrameWorkGridView()
}
