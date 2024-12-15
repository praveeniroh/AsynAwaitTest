//
//  ItemListInteractorProtocol.swift
//  AsyncAwaitTest
//
//  Created by praveen-12298 on 14/12/24.
//


import Foundation

protocol ItemListInteractorProtocol {
    func fetchListData() async throws -> [ListUIData]
}

class ItemListInteractor: ItemListInteractorProtocol {
    func fetchListData() async throws -> [ListUIData] {
        // Fetch data from API
        print("--> Thread: \(Thread.isMainThread)")
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode API response
        let items = try JSONDecoder().decode([Item].self, from: data)
        
        // Convert API response to ListUIData
        return items.map { item in
            ListUIData(id: item.id, displayTitle: "Task: \(item.title)")
        }
    }
}
