//
//  NetworkManager.swift
//  MoviesListTest
//
//  Created by Sofiia Lushchanets on 24.11.2020.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getTopRatedMoviesList(_ completion: @escaping ArgumentedClosure<[Movie]>)
    func getMoviePosterImage(posterString: String, _ completion: @escaping ArgumentedClosure<UIImage>)
}

final class NetworkManager: NetworkManagerProtocol {
    
    private var sessionManager = Alamofire.Session()
    
    // MARK: NetworkManagerProtocol
    func getTopRatedMoviesList(_ completion: @escaping ArgumentedClosure<[Movie]>) {
        sessionManager.request(Constants.topRatedMoviesUrl,
                               method: .get)
            .responseData(completionHandler: { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(MoviesResponse.self, from: data)
                        completion(response.results)
                    }
                    catch {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
    }
    
    func getMoviePosterImage(posterString: String, _ completion: @escaping ArgumentedClosure<UIImage>) {
        sessionManager.request("\(Constants.posterImageUrlBase)\(posterString)", method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data, let image = UIImage(data: data) else { return }
                completion(image)
            case .failure(let error):
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: Constants
extension NetworkManager {
    private enum Constants {
        static let topRatedMoviesUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=06c477fb6235927e8e8ea7e96b18133c"
        static let posterImageUrlBase = "https://image.tmdb.org/t/p/w500/"
    }
}
