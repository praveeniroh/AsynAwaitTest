//
//  ItemListRouterProtocol.swift
//  AsyncAwaitTest
//
//  Created by praveen-12298 on 14/12/24.
//

import UIKit

protocol ItemListRouterProtocol {}

class ItemListRouter: ItemListRouterProtocol {
    static func createModule() -> UIViewController {
        let view = ItemListViewController()
        let interactor = ItemListInteractor()
        let router = ItemListRouter()
        let presenter = ItemListPresenter(view: view, interactor: interactor, router: router)

        view.inject(presenter: presenter)
        return view
    }
}
