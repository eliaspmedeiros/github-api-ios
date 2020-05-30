//
//  RepositoryModel.swift
//  GitApi
//
//  Created by Elias Medeiros on 29/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import Foundation

struct RepositoryListModel: Decodable {
    let totalCount: Int
    let items: [RepositoryModel]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

struct RepositoryModel: Decodable {
    let id: Int
    let name: String
    let starCount: Int
    let owner: Owner

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case starCount = "stargazers_count"
        case owner 
    }
}

struct Owner: Decodable {
    let name: String
    let picture: String

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case picture = "avatar_url"
    }
}
