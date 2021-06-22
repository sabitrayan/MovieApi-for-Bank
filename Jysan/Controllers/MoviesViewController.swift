//
//  MoviesViewController.swift
//  Jysan
//
//  Created by ryan on 6/21/21.
//

import UIKit

class MoviesViewController: UIViewController {

    private var movies: [Movie] = [] {
        didSet {
            moviesTableView .reloadData()
//            print("sukaaaaaa")
//            print(movies)
        }

    }

    var moviesTableView: UITableView = {
        let table = UITableView()
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        navigationItem.title = "main_title"
        //moviesTableView.reloadData()
        getMovies()
    }

    private func setupTableView() {
        view.addSubview(moviesTableView)
        moviesTableView.backgroundColor = #colorLiteral(red: 0.7890606523, green: 0.7528427243, blue: 0.7524210811, alpha: 1)
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.frame = view.bounds
    }

    func getMovies() {
//        self.mainActivityIndicator.startAnimating()
        AlamofireService.getMovies { (moviesArray) in
            //self.mainActivityIndicator.stopAnimating()
            self.movies = moviesArray
            self.moviesTableView.isHidden = false
            self.moviesTableView.reloadData()
        }
    }
}


extension MoviesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell

        cell.movieItem = movies[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = MoviesDetailViewController()
//        let cell  = tableView.cellForRow(at: indexPath) as? MovieTableViewCell
//        cell?.movieItem = movies[indexPath.row]
////        print("rayan")
////        print(cell?.movieItem)
//        navigationController?.pushViewController(vc, animated: true)
//    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoviesDetailViewController()
        vc.title = movies[indexPath.row].title
        vc.year = movies[indexPath.row].releaseDate
        vc.moviePoster = movies[indexPath.row].image
        vc.genres = movies[indexPath.row].genres
        vc.id = movies[indexPath.row].id

        navigationController?.pushViewController(vc, animated: true)
    }
}


