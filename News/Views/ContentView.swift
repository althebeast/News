//
//  ContentView.swift
//  News
//
//  Created by Alperen Sarışan on 27.02.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTabView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            BookmarkTabView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    ContentView()
}
