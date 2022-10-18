//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 16/10/22.
//


import Foundation
import Alamofire

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func didTapMoviewDetail(id: Int)
}

protocol HomeViewModelProtocol {
    var coordinatorDelegate : HomeViewModelCoordinatorDelegate?{get set}
    var reponseList: GenresResponse?{get set}
    var responseMoviesList: ListMovieResponse?{get set}
    var updateListSections: Bindable<Bool> { get set }
    func goToDetail(id: Int)
}

class HomeViewModel: HomeViewModelProtocol {
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    var reponseList: GenresResponse?
    var responseMoviesList: ListMovieResponse?
    var updateListSections: Bindable<Bool> = Bindable(false)
    var itemMoviews: [ItensMovies] = []
    
    func goToDetail(id: Int) {
        self.coordinatorDelegate?.didTapMoviewDetail(id: id)
    }
   
    func fetchListGenres() {
        
        let request = AF.request("\(APIConstants.baseURL )genre/movie/list?api_key=\(APIConstants.API_KEY )&language=en-US")
        request.responseDecodable(of: GenresResponse.self) { (response) in
          guard let films = response.value else { return }
          self.reponseList = films
          self.fetchListMovies(page: "1")
        }
    }
    
    func fetchListMovies(page: String) {
        let request = AF.request("\(APIConstants.baseURL )discover/movie?page=\(page)&api_key=\(APIConstants.API_KEY )")
        request.responseDecodable(of: ListMovieResponse.self) { (response) in
            guard let films = response.value else { return }
            self.responseMoviesList = films
            for itens in self.responseMoviesList?.results ?? [] {
                self.itemMoviews.append(itens)
            }
            if page == "3" {
                self.removeGenresEmptys()
            } else {
                // chamando outras vezes para popular mais a tela
                let time = page == "1" ? "2" : "3"
                self.fetchListMovies(page: time)
            }
        }
    }
    
    // retirando os generos que não tem filmes
    func removeGenresEmptys() {
        var index: Int = 0
        var searchCheck: Int = 0
        for loopGenres in self.reponseList?.genres ?? [] {
            index += 1
            searchCheck = 0
            for checkGenres in self.itemMoviews {
                if checkGenres.genre_ids.contains(loopGenres.id) {
                    searchCheck = searchCheck + 1
                }
            }
            if searchCheck == 0 {
                index = index - 1
                self.reponseList?.genres.remove(at: index)
            }
        }
        self.updateListSections.value = true
    }
}

