//
//  RefreshableScrollView.swift
//  SwiftUIScroll
//
//  Created by Gualtiero Frigerio on 13/05/21.
//

import SwiftUI

/// Enable pull down to refresh by wrapping the view inside a GeometryReader
/// and a ScrollView
struct RefreshableScrollView<Content:View>: View {
    init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.refreshAction = action
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                content()
                    .anchorPreference(key: OffsetPreferenceKey.self, value: .top) {
                        geometry[$0].y
                    }
            }
            .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                if offset > threshold {
                    refreshAction()
                }
            }
        }
    }
    
    // MARK: - Private
    
    private var content: () -> Content
    private var refreshAction: () -> Void
    private let threshold:CGFloat = 50.0
}

struct RefreshableScrollViewModifier: ViewModifier {
    var action: () -> Void
    
    func body(content: Content) -> some View {
        RefreshableScrollView(action: action) {
            content
        }
    }
}

fileprivate struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
