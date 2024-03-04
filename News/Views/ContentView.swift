//
//  ContentView.swift
//  News
//
//  Created by Alperen Sarışan on 27.02.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ArticleListView(articles: Article.previewData)
    }
}

#Preview {
    ContentView()
}
