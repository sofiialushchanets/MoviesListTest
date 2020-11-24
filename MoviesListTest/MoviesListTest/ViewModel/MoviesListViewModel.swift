//
//  MoviesListViewModel.swift
//  MoviesListTest
//
//  Created by Sofiia Lushchanets on 24.11.2020.
//

import Foundation
import ReactiveSwift

protocol MoviesListViewModelInput {
    func start()
}

protocol MoviesListViewModelOutput {
    var moviesSignal: Signal<[Movie], Never> { get }
}

protocol MoviesListViewModelType {
    var input: MoviesListViewModelInput { get }
    var output: MoviesListViewModelOutput { get }
}

final class MoviesListViewModel: MoviesListViewModelType {
    var input: MoviesListViewModelInput { return self }
    var output: MoviesListViewModelOutput { return self }

    private var moviesProperty = MutableProperty<[Movie]?>(nil)
    private let networkManager: NetworkManagerProtocol = NetworkManager()

    // MARK: - MoviesListModelOutput
    let moviesSignal: Signal<[Movie], Never>

    // MARK: - MoviesListModelInput
    func start() {
        networkManager.getTopRatedMoviesList { movies in
            self.moviesProperty.value = movies
        }
    }

    init() {
        self.moviesSignal = moviesProperty.signal.skipNil()
    }
}

extension MoviesListViewModel: MoviesListViewModelInput {}
extension MoviesListViewModel: MoviesListViewModelOutput {}
