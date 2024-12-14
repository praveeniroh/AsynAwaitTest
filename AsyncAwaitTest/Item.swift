//
//  Item.swift
//  AsyncAwaitTest
//
//  Created by praveen-12298 on 14/12/24.
//


// API Response Model
struct Item: Decodable {
    let id: Int
    let title: String
}

// UI Data Model
struct ListUIData {
    let id: Int
    let displayTitle: String
}
