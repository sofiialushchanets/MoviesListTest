//
//  MovieTableViewCellViewModel.swift
//  MoviesListTest
//
//  Created by Sofiia Lushchanets on 24.11.2020.
//

import Foundation
import ReactiveSwift

protocol MovieTableViewCellViewModelInput {
    func getPoster() -> UIImage?
    func getTitle() -> String?
    func getDescription() -> String?
}

protocol MovieTableViewCellViewModelOutput {
    var posterSignal: Signal<UIImage, Never> { get }
    var titleSignal: Signal<String, Never> { get }
    var descriptionSignal: Signal<String, Never> { get }
}

protocol MovieTableViewCellViewModelType {
    var input: MovieTableViewCellViewModelInput { get }
    var output: MovieTableViewCellViewModelOutput { get }
}

final class MovieTableViewCellViewModel: MovieTableViewCellViewModelType {
    var input: MovieTableViewCellViewModelInput { return self }
    var output: MovieTableViewCellViewModelOutput { return self }

    private var posterProperty = MutableProperty<UIImage?>(nil)
    private var titleProperty = MutableProperty<String?>(nil)
    private var descriptionProperty = MutableProperty<String?>(nil)

    private let networkManager: NetworkManagerProtocol = NetworkManager()

    // MARK: - MovieTableViewCellModelOutput
    let posterSignal: Signal<UIImage, Never>
    let titleSignal: Signal<String, Never>
    let descriptionSignal: Signal<String, Never>

    init(with movie: Movie) {
        posterSignal = posterProperty.signal.skipNil()
        titleSignal = titleProperty.signal.skipNil()
        descriptionSignal = descriptionProperty.signal.skipNil()
        titleProperty.value = movie.title
        descriptionProperty.value = movie.overview
        downloadImage(imageString: movie.poster)
    }

    private func downloadImage(imageString: String) {
        networkManager.getMoviePosterImage(posterString: imageString) { image in
            self.posterProperty.value = image
        }
    }

    // MARK: - MovieTableViewCellModelInput
    func getPoster() -> UIImage? {
        return posterProperty.value
    }

    func getTitle() -> String? {
        return titleProperty.value
    }

    func getDescription() -> String? {
        return descriptionProperty.value
    }
}

extension MovieTableViewCellViewModel: MovieTableViewCellViewModelInput {}
extension MovieTableViewCellViewModel: MovieTableViewCellViewModelOutput {}


