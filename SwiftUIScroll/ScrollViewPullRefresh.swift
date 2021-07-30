//
//  ScrollViewPull.swift
//  ScrollViewPull
//
//  Created by Gualtiero Frigerio on 29/07/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct ScrollViewPullRefresh<Content:View>: View {
    @Environment(\.refresh) var refreshAction: RefreshAction?
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack {
            if isRefreshing {
                ProgressView()
            }
        }
        GeometryReader { geometry in
            ScrollView {
                content()
                    .anchorPreference(key: OffsetPreferenceKey.self, value: .top) {
                        geometry[$0].y
                    }
            }
            .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                if offset > threshold && isRefreshing == false {
                    if let action = refreshAction {
                        Task {
                            isRefreshing = true
                            await action()
                            withAnimation {
                                isRefreshing = false
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var content: () -> Content
    @State private var isRefreshing = false
    private let threshold = 50.0
}

@available(iOS 15.0, *)
struct ScrollViewPullRefresh_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewPullRefresh {
            Text("test")
        }
    }
}

fileprivate struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
