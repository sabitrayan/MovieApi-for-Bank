//
//  MovieTableViewCell.swift
//  Jysan
//
//  Created by ryan on 6/21/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static var identifier = "movieCell"

    private let backgroundCardView: UIView = {
        let backView = UIView()
        backView.layer.cornerRadius = 8.0
        backView.backgroundColor = UIColor.white
        return backView
    }()
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .black
        return label
    }()


    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .black
        return label
    }()

    private let genresLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .black
        return label
    }()

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        setupConstraints()
//        backgroundColor = #colorLiteral(red: 0.7863221765, green: 0.7518113256, blue: 0.752297163, alpha: 1)
//        print("sukaaaaaaaa")
//        print(dateLabel)
//        print(genresLabel)
//    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        backgroundColor = #colorLiteral(red: 0.7863221765, green: 0.7518113256, blue: 0.752297163, alpha: 1)
       
        print(dateLabel)
        print(genresLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    var movieItem: Movie? {
        didSet {
            var genders: String = ""
            if let title = movieItem?.title {
                titleLabel.text = title
            }
            if let date = movieItem?.releaseDate {
                dateLabel.text = "Launch Year: \(date.prefix(4))"
            }

            if let genres = movieItem?.genres {
                for gender in genres {
                    if (!genders.contains(gender)) {
                        genders += gender
                        genders += ", "
                    }
                }
            }
            genders = String(genders.dropLast(2))
            self.genresLabel.text = genders
            if let icon = UIImage(named: "image_post") {
                movieImage.image = icon
            }

            print("I am here\(dateLabel)")
        }
    }

    func setupConstraints(){
        contentView.addSubview(movieImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(genresLabel)


        movieImage.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(movieImage.snp.right).offset(20)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(movieImage.snp.right).offset(20)
        }
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.left.equalTo(movieImage.snp.right).offset(20)
        }

    }

}
