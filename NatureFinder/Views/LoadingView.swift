//
//  LoadingView.swift
//  NatureFinder
//
//  Created by Anna on 5/6/23.
//

import Foundation
import SwiftUI

struct LoadingView: View {

    let loadingState: LoadingState
    
    var body: some View {
        switch loadingState {
        case .loading:
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: 100)
                .scaleEffect(1.5, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .foregroundColor(.white)
                .background(Color(.systemBlue))
                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                .padding()
        case .idle, .success, .failure:
            EmptyView()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(loadingState: .loading)
    }
}
