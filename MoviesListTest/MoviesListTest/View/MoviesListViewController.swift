//
//  MoviesListViewController.swift
//  MoviesListTest
//
//  Created by Sofiia Lushchanets on 24.11.2020.
//

import UIKit
import ReactiveSwift

final class MoviesListViewController: UIViewController {
    private var viewModel: MoviesListViewModelType?
    private var movieCellsViewModels = [MovieTableViewCellViewModel]()

    @IBOutlet weak var moviesListTableView: UITableView!

    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel?.input.start()
        registerCell()
    }

    private func registerCell() {
        moviesListTableView.register(UINib(nibName: MovieTableViewCell.reuseID, bundle: nil),
                                     forCellReuseIdentifier: MovieTableViewCell.reuseID)
    }

    // MARK: bind view model
    private func bindViewModel() {
        viewModel = MoviesListViewModel()
        viewModel?
            .output
            .moviesSignal
            .observe(on: UIScheduler())
            .observeValues({ [weak self] value in
                value.forEach { movie in
                    self?.movieCellsViewModels.append(MovieTableViewCellViewModel(with: movie))
                }
                self?.moviesListTableView.reloadData()
            })
    }
}

// MARK: UITableViewDataSource
extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCellsViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let cellViewModel = movieCellsViewModels[indexPath.row]
        cell.viewModel = cellViewModel
        cell.movieTitleLabel.text = cellViewModel.getTitle()
        cell.movieDescriptionLabel.text = cellViewModel.getDescription()
        cell.posterImageView.image = cellViewModel.getPoster()

        return cell
    }
}
