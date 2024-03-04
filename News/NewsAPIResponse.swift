//
//  NewsAPIResponse.swift
//  News
//
//  Created by Alperen Sarışan on 27.02.2024.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
}
