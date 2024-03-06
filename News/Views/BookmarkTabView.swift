//
//  BookmarkTabView.swift
//  News
//
//  Created by Alperen Sarışan on 6.03.2024.
//

import SwiftUI

struct BookmarkTabView: View {
    
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    
    var body: some View {
        NavigationStack {
            ArticleListView(articles: articleBookmarkVM.bookmarks)
                .overlay(overlayView(isEmpty: articleBookmarkVM.bookmarks.isEmpty))
                .navigationTitle("Saved Articles")
            
            
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceHolderView(text: "No saved articles", image: Image(systemName: "bookmark"))
        }
    }
}

#Preview {
    
    BookmarkTabView()
        .environmentObject(ArticleBookmarkViewModel())
    
}
