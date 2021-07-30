//
//  ContentView.swift
//  SwiftUIScroll
//
//  Created by Gualtiero Frigerio on 24/08/2020.
//

import SwiftUI

struct ContentView: View {
    let model: ContentViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("PostList",
                               destination: PostList(posts: model.allPosts))
                    .padding()
                NavigationLink("PostForEach",
                               destination:PostForEach(posts:model.allPosts))
                    .padding()
                NavigationLink("PostForEach lazy",
                               destination:PostForEach(posts:model.allPosts, lazy: true))
                    .padding()
                NavigationLink("PostForEach Modifier",
                               destination:PostForEachModifier(posts:model.allPosts))
                    .padding()
                if #available(iOS 15.0, *) {
                    NavigationLink("PostForEach pull",
                                   destination: PostForEachPull(viewModel: model))
                        .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model:ContentViewModel())
    }
}
