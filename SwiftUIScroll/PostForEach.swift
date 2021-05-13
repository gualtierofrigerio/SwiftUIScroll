//
//  PostForEach.swift
//  SwiftUIScroll
//
//  Created by Gualtiero Frigerio on 28/08/2020.
//

import SwiftUI

struct PostForEach: View {
    var posts:[Post]
    var lazy:Bool = false
    
    var body: some View {
        RefreshableScrollView(action: refreshList) {
            if isLoading {
                VStack {
                    ProgressView()
                    Text("loading...")
                }
            }
            if lazy {
                LazyVStack {
                    ForEach(posts) { post in
                        PostView(post: post)
                    }
                }
            }
            else {
                VStack {
                    ForEach(posts) { post in
                        PostView(post: post)
                    }
                }
            }
        }
    }
    
    @State private var isLoading = false
    
    private func refreshList() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isLoading = false
        }
    }
}

struct PostForEach_Previews: PreviewProvider {
    static var previews: some View {
        PostForEach(posts:[])
    }
}
