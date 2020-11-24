//
//  MovieTableViewCell.swift
//  MoviesListTest
//
//  Created by Sofiia Lushchanets on 24.11.2020.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: MovieTableViewCellViewModelType? {
        didSet {
            bindViewModel()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        movieTitleLabel.text = nil
        movieDescriptionLabel.text = nil
        posterImageView.image = nil
    }

    func bindViewModel() {
        viewModel?
            .output
            .posterSignal
            .observeValues({ [weak self] value in
                self?.posterImageView.image = value
                self?.activityIndicator.stopAnimating()
            })

        viewModel?
            .output
            .titleSignal
            .observeValues({ [weak self] value in
                self?.movieTitleLabel.text = value
            })

        viewModel?
            .output
            .descriptionSignal
            .observeValues({ [weak self] value in
                self?.movieDescriptionLabel.text = value
            })
    }
}
