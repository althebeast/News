//
//  ArticleRowView.swift
//  News
//
//  Created by Alperen Sarışan on 27.02.2024.
//

import SwiftUI

struct ArticleRowView: View {
    
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    let article: Article
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: article.imageURL) { image in
                switch image {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }
                @unknown default:
                    fatalError()
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)
                
                HStack {
                    Text(article.captionText)
                        .lineLimit(1)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    
                    Spacer()
                    
                    Button(action: {
                        //save action
                        toggleBookmark(for: article)
                    }, label: {
                        Image(systemName: articleBookmarkVM.isBookmarked(for: article) ? "bookmark.fill" : "bookmark")
                    })
                    .buttonStyle(.bordered)
                    
                    Button(action: {
                        //share action
                        presentShareSheet(url: article.articleURL)
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                    })
                    .buttonStyle(.bordered)
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    private func toggleBookmark(for article: Article) {
        if articleBookmarkVM.isBookmarked(for: article) {
            articleBookmarkVM.removeBookmark(for: article)
        } else {
            articleBookmarkVM.addBookmark(for: article)
        }
    }
}

extension View {
    
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
    
}

#Preview {
    ArticleRowView(article: .previewData[0])
        .environmentObject(ArticleBookmarkViewModel())
}
