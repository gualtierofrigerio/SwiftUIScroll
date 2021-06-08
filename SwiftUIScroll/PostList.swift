//
//  PostList.swift
//  SwiftUIScroll
//
//  Created by Gualtiero Frigerio on 25/08/2020.
//

import SwiftUI

struct PostList: View {
    @State var posts:[Post]
    
    var body: some View {
        VStack {
            Text("there are \(posts.count) posts")
            if #available(iOS 15.0, *) {
                List(posts) { post in
                    PostView(post: post)
                }
                .refreshable {
                    await refreshListAsync()
                }
            } else {
                List(posts) { post in
                    PostView(post: post)
                }
            }
        }
    }
    
    @State private var isRefreshing = false
    
    @available(iOS 15.0, *)
    private func refreshListAsync() async {
        if isRefreshing == false {
            isRefreshing = true
            self.posts = await shufflePosts(posts)
            print(" do nothing ...")
            isRefreshing = false
        }
    }
    
    @available(iOS 15.0, *)
    private func shufflePosts(_ posts: [Post]) async -> [Post] {
        return posts.shuffled()
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList(posts:[])
    }
}
