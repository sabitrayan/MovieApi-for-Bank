//
//  MoviesDetailViewController.swift
//  Jysan
//
//  Created by ryan on 6/22/21.
//

import UIKit

class MoviesDetailViewController: UIViewController {

    private let moviePosterView: UIImageView = {
        let posterView = UIImageView()
        return posterView
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.layer.cornerRadius = 8.0
        title.backgroundColor = UIColor.white
        title.font = UIFont.preferredFont(forTextStyle: .title2)
        return title
    }()

    private let yearLabel: UILabel = {
        let year = UILabel()
        year.font = UIFont.preferredFont(forTextStyle: .callout)
        return year
    }()

    private let genresLabel: UILabel = {
        let genre = UILabel()
        genre.font = UIFont.preferredFont(forTextStyle: .callout)
        return genre
    }()

    private let overviewLabel: UILabel = {
        let overview = UILabel()
        overview.font = UIFont.preferredFont(forTextStyle: .footnote)
        return overview
    }()

    private let runtimeLabel: UILabel = {
        let runtime = UILabel()
        runtime.font = UIFont.preferredFont(forTextStyle: .callout)
        return runtime
    }()

    private let revenueLabel: UILabel = {
        let revenue = UILabel()
        revenue.font = UIFont.preferredFont(forTextStyle: .callout)
        return revenue
    }()

    private let languagesLabel: UILabel = {
        let languages = UILabel()
        languages.font = UIFont.preferredFont(forTextStyle: .callout)
        return languages
    }()

    private let originalTitleLabel: UILabel = {
        let originalTitle = UILabel()
        originalTitle.font = UIFont.preferredFont(forTextStyle: .callout)
        return originalTitle
    }()

    private let originalLanguageLabel: UILabel = {
        let originalLanguage = UILabel()
        originalLanguage.font = UIFont.preferredFont(forTextStyle: .callout)
        return originalLanguage
    }()

    private let moviesDetailScrollView: UIScrollView = {
        let detailScrollView = UIScrollView()
        return detailScrollView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.moviePosterView.image = self.moviePoster
        self.yearLabel.text = String(format: "Launch Year: %@", self.year.prefix(4) as CVarArg)
        self.genresLabel.text = String(format: "Genre: %@", self.genres.joined(separator: ", "))
        getDetails()
        setupConstraints()
    }

    var movies: Movie? {
        didSet{
            if let movieTitle = movies?.title {
                titleLabel.text = movieTitle
            }
        }
    }
    var id: Int = 0
    var movieTitle: String = ""
    var moviePoster: UIImage? = nil
    var genres: [String] = []
    var year: String = ""
    lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    func getDetails() {
        self.moviesDetailScrollView.isScrollEnabled = true
        AlamofireService.getMovieWithDetails(movieId: self.id) { (movieWithDetails) in
            guard let movieDetails = movieWithDetails else {
                self.moviesDetailScrollView.isScrollEnabled = false
                return
            }
            self.titleLabel.text = self.title
            self.overviewLabel.text = movieDetails.overview

            self.revenueLabel.text = String(format: "Revenue: %@", self.currencyFormatter.string(from: NSNumber(value: movieDetails.revenue)) ?? "")

            self.runtimeLabel.text = String(format: "Runtime: %@ Minutes", movieDetails.runtime.description)
            self.languagesLabel.text = String(format: "Languages: %@", movieDetails.spokenLanguages.joined(separator: ", "))
            self.originalTitleLabel.text = String(format: "Original title: %@", movieDetails.originalTitle)
            self.originalLanguageLabel.text = String(format: "Original language: %@", movieDetails.originalLanguage)
        }
    }

    func setupConstraints(){
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(revenueLabel)
        view.addSubview(runtimeLabel)
        view.addSubview(languagesLabel)
        view.addSubview(originalTitleLabel)
        view.addSubview(originalLanguageLabel)
        view.addSubview(moviePosterView)
        view.addSubview(yearLabel)
        view.addSubview(genresLabel)

        moviePosterView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(moviePosterView.snp.bottom).inset(10)
            make.left.right.equalToSuperview().inset(10)
        }
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(10)
        }
        revenueLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(10)
        }

    }
}
