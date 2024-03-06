//
//  NewsTabView.swift
//  News
//
//  Created by Alperen Sarışan on 4.03.2024.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .task(id: articleNewsVM.fetchTaskToken, {
                    await loadTask()
                })
                .refreshable {
                    refreshTask()
                }
                .navigationTitle(articleNewsVM.fetchTaskToken.category.text)
                .toolbar(content: {
                    menu
                })
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsVM.phase {
        case .empty: ProgressView()
        case .success(let articles) where articles.isEmpty: EmptyPlaceHolderView(text: "No Articles", image: nil)
        case .failure(let error): RetryView(text: error.localizedDescription) {
            //TODO: Refresh the news API
            refreshTask()
        }
            
        default: EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    private func loadTask() async {
            await articleNewsVM.loadArticles()
    }
    
    private func refreshTask() {
        articleNewsVM.fetchTaskToken = FetchTaskToken(category: articleNewsVM.fetchTaskToken.category, token: Date())
    }
    
    private var menu: some View {
        
        Menu {
            Picker("Category", selection: $articleNewsVM.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
                .foregroundStyle(ColorScheme(.dark) == .dark ? Color(.white) : Color(.black))
        }
        
    }
}

#Preview {
    NewsTabView()
        .environmentObject(ArticleBookmarkViewModel())
}
