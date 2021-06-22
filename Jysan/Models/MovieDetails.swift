//
//  MovieDetails.swift
//  Jysan
//
//  Created by ryan on 6/21/21.
//

import UIKit
class MovieDetails {
    let budget: Int64
    let genres: [String]
    let homepage: String?
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let revenue: Int64
    let runtime: Int
    let spokenLanguages: [String]
    let tagline: String
    let title: String
    let voteAverage: Double

    struct keys {
        static let budget = "budget"
        static let genres = "genres"
        static let homepage = "homepage"
        static let id = "id"
        static let originalLanguage = "original_language"
        static let originalTitle = "original_title"
        static let overview = "overview"
        static let releaseDate = "release_date"
        static let revenue = "revenue"
        static let runtime = "runtime"
        static let spokenLanguages = "spoken_languages"
        static let tagline = "tagline"
        static let title = "title"
        static let voteAverage = "vote_average"
    }

    init?(detailsDictionary: [String : Any]) {
        guard let id = detailsDictionary[keys.id] as? Int,
            let genres = detailsDictionary[keys.genres] as? [String],
            let originalLanguage = detailsDictionary[keys.originalLanguage] as? String,
            let originalTitle = detailsDictionary[keys.originalTitle] as? String,
            let overview = detailsDictionary[keys.overview] as? String,
            let releaseDate = detailsDictionary[keys.releaseDate] as? String,
            let revenue = detailsDictionary[keys.revenue] as? Int64,
            let runtime = detailsDictionary[keys.runtime] as? Int,
            let spokenLanguagesDict = detailsDictionary[keys.spokenLanguages] as? [[String : Any]],
            let tagline = detailsDictionary[keys.tagline] as? String,
            let voteAverage = detailsDictionary[keys.voteAverage] as? Double,
            let budget = detailsDictionary[keys.budget] as? Int64,
            let title = detailsDictionary[keys.title] as? String else {
            return nil
        }
        self.budget = budget
        self.genres = genres
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguagesDict.compactMap { (spokenDict) -> String? in
            return spokenDict["name"] as? String
        }
        self.tagline = tagline
        self.title = title
        self.voteAverage = voteAverage
        self.homepage = detailsDictionary[keys.homepage] as? String
    }
}


