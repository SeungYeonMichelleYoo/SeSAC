//
//  MovieModel.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/05.
//

import Foundation

struct MovieModel {
    let movieTitle: String
    let genre: String
    let rate: Double
    let posterImage: String
    let releasedDate: String
    let overview: String
    let castedList: [PeopleModel] //= [new PeopleModel(personName: personName, personImage: personImage), new PeopleModel(personName: personName2)
    let crewList: [PeopleModel]
    let youtubeKey: String
}

