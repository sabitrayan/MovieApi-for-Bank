//
//  AlomofireService.swift
//  Jysan
//
//  Created by ryan on 6/21/21.
//

import Foundation
import Alamofire
import UIKit

class AlamofireService {
    static let moviesURL = "https://desafio-mobile.nyc3.digitaloceanspaces.com/movies"

    static func getMovies(completion: @escaping([Movie]) -> ()) {
        AF.request(moviesURL).responseJSON { (response) in
            guard let responseData = response.data else {
                completion([])
                return
            }
            print("DATA: \(responseData)")
            do {
                if let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String : Any]] {

                    print("DICT: \(dict)")
                    var moviesArray: [Movie] = []
                    for movieDict in dict {
                        if let movie = Movie(movieDictionary: movieDict) {
                            moviesArray.append(movie)
                            movie.downloadImage()
                        }
                    }
                    print("ARRAY: \(moviesArray)")
                    completion(moviesArray)
                } else {
                    completion([])
                }
            } catch {
                completion([])
            }
        }
    }

    static func getMovieWithDetails(movieId: Int, completion: @escaping(MovieDetails?) -> ()) {
        var movieStringId: String = ""
        movieStringId += "/"
        movieStringId += movieId.description
        let movieWithDetailsURL = "\(moviesURL)\(movieStringId)"
        var request = URLRequest(url: URL(string: movieWithDetailsURL)!)
        request.cachePolicy = .returnCacheDataElseLoad
        AF.request(request).responseJSON { (response) in
            guard let responseData = response.data else {
                completion(nil)
                return
            }
            do {
                if let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any] {
                    if let movieWithDetails = MovieDetails.init(detailsDictionary: dict) {
                        completion(movieWithDetails)
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }
    }

    static func getImage(stringURL: String, completion: @escaping (UIImage?) -> ()) {
        AF.request(stringURL).responseData { (response) in
            if let data = response.data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
