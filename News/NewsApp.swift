//
//  NewsApp.swift
//  News
//
//  Created by Alperen Sarışan on 27.02.2024.
//

import SwiftUI

@main
struct NewsApp: App {
    
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
