//
//  PostForEachModifier.swift
//  SwiftUIScroll
//
//  Created by Gualtiero Frigerio on 13/05/21.
//

import SwiftUI

struct PostForEachModifier: View {
    var posts:[Post]
    
    var body: some View {
        LazyVStack {
            if isLoading {
                ProgressView()
            }
            ForEach(posts) { post in
                PostView(post: post)
            }
        }
        .modifier(RefreshableScrollViewModifier(action: refreshAction))
    }
    
    @State private var isLoading = false
    
    private func refreshAction() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
        }
    }
}

struct PostForEachModifier_Previews: PreviewProvider {
    static var previews: some View {
        PostForEachModifier(posts:[])
    }
}
