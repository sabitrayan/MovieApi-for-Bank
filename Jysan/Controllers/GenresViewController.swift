//
//  GenresViewController.swift
//  Jysan
//
//  Created by ryan on 6/21/21.
//

import UIKit

class GenresViewController: UITabBarController {

    var moviesTableView: UITableView = {
        let table = UITableView()
        table.register(GenreTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        table.rowHeight = 100
        return table
    }()

    private let navigationView: UIView = {
        let view = UIView()
        return view
    }()

    private let genreMovieLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let backButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private let searchButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    @objc private func searchAction(_ sender: Any) {
        let vc = SearchViewController()
        present(vc, animated: true, completion: nil)
    }

    var genre = Genre()

    private var movies: [Movie] = [] {
        didSet {
            moviesTableView.reloadData()
        }
    }


    func getMovies() {
        AlamofireService.getMovies { (moviesArray) in
            self.movies = moviesArray
            self.moviesTableView.isHidden = false
            self.moviesTableView.reloadData()
        }
    }

    private func hideLayout() {
        let backButtonWidth = backButton.frame.width
        backButton.transform = CGAffineTransform(translationX: -backButtonWidth, y: 0)
        let titleLabelHeight = titleLabel.frame.height * 2
        titleLabel.transform = CGAffineTransform(translationX: 0, y: -titleLabelHeight)
        let searchButtonWidth = searchButton.frame.width
        searchButton.transform = CGAffineTransform(translationX: searchButtonWidth, y: 0)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        genreMovieLabel.text = genre.name
        hideLayout()
        setupConstraints()
    }

    func setupConstraints(){
        view.addSubview(moviesTableView)

        moviesTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        hideLayout()
    }



}


extension GenresViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GenreTableViewCell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.identifier, for: indexPath) as! GenreTableViewCell
        cell.setContentForCell(data: movies[indexPath.row])
        return cell
    }
}

extension GenresViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if movies.count == indexPath.row + 1 {
           // fetchDataMovies()
        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoviesDetailViewController()
        vc.title = movies[indexPath.row].title
        vc.year = movies[indexPath.row].releaseDate
        vc.moviePoster = movies[indexPath.row].image
        vc.genres = movies[indexPath.row].genres
        vc.id = movies[indexPath.row].id
        vc.year = movies[indexPath.row].releaseDate
        navigationController?.pushViewController(vc, animated: true)
    }
}

