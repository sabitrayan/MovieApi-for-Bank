//
//  GenreTableViewCell.swift
//  Jysan
//
//  Created by ryan on 6/22/21.
//

import UIKit

class GenreTableViewCell: UITableViewCell{

    static var identifier = "genreCell"

    private let movieImageView: UITableView = {
        let view = UITableView()
        return view
    }()

    private let movieNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let oveviewLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let scoreLabel: UILabel = {
        let label = UILabel()
        return label
    }()


    private struct Constant {
        static let imageScale: CGFloat = 0.6
        static let animationTime = 0.3
    }

    //  MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //  MARK: - Setup Views
    func setContentForCell(data: Movie) {

        movieNameLabel.text = data.title
        scoreLabel.text = String(data.voteAverage)
    }
    var genreItem: Genre? {
        didSet {

            if let nameLabel = genreItem?.name {
                movieNameLabel.text = nameLabel
            }

        }
    }
}
