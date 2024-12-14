//
//  ItemListPresenterProtocol.swift
//  AsyncAwaitTest
//
//  Created by praveen-12298 on 14/12/24.
//


import Foundation

protocol ItemListPresenterProtocol: AnyObject {

    func viewDidLoad()
    func pullToRefreshTriggerred()
}

class ItemListPresenter: ItemListPresenterProtocol {
    private weak var view: ItemListViewProtocol?
    private let interactor: ItemListInteractorProtocol
    private let router: ItemListRouterProtocol

    init(view: ItemListViewProtocol, interactor: ItemListInteractorProtocol, router: ItemListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        Task {
            do {
                view?.showLoading()
                let items = try await interactor.fetchListData()
                view?.showItems(items)
            } catch {
                view?.showError(error.localizedDescription)
            }
            view?.hideLoading()
        }
    }

    func pullToRefreshTriggerred() {
        Task {
            do {
                let items = try await interactor.fetchListData()
                view?.showItems(items)
            } catch {
                view?.showError(error.localizedDescription)
            }
            view?.endPullToRefreshing()
        }
    }
}
