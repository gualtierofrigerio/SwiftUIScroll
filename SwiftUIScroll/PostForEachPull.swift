//
//  PostForEachPull.swift
//  PostForEachPull
//
//  Created by Gualtiero Frigerio on 29/07/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct PostForEachPull: View {
    var viewModel: ContentViewModel
    
    var body: some View {
        ScrollViewPullRefresh {
            VStack {
                ForEach(posts) { post in
                    PostView(post: post)
                }
            }
        }
        .task {
            posts = await getPosts()
        }
        .refreshable {
            posts = await shufflePosts()
        }
    }
    
    @State private var posts: [Post] = []
    
    private func getPosts() async -> [Post] {
        viewModel.allPosts
    }
    
    private func shufflePosts() async -> [Post] {
        print("shufflePosts")
        await Task.sleep(2_000_000_000)
        return viewModel.allPosts.shuffled()
    }
}

@available(iOS 15.0, *)
struct PostForEachPull_Previews: PreviewProvider {
    static var previews: some View {
        PostForEachPull(viewModel: ContentViewModel())
    }
}
