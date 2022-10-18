//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 18/10/22.
//


import Foundation
import Alamofire

protocol DetailViewModelCoordinatorDelegate: AnyObject {
    func didTapHome()
}

protocol DetailViewModelProtocol {
    var coordinatorDelegate : DetailViewModelCoordinatorDelegate?{get set}
    var responseDetail: DetailMovieResponse?{get set}
    var idMovie: Int {get set}
    func goToHome()
}

class DetailViewModel: DetailViewModelProtocol {
    var idMovie: Int = 0
    weak var coordinatorDelegate: DetailViewModelCoordinatorDelegate?
    var responseDetail: DetailMovieResponse?
    var updateInfo: Bindable<Bool> = Bindable(false)

    func goToHome() {
        self.coordinatorDelegate?.didTapHome()
    }
   
    func fetchDetail() {
        let request = AF.request("\(APIConstants.baseURL)movie/\(idMovie)?api_key=\(APIConstants.API_KEY )&language=en-US")
        request.responseDecodable(of: DetailMovieResponse.self) { (response) in
          guard let films = response.value else { return }
          self.responseDetail = films
          self.updateInfo.value = true
        }
    }
}


