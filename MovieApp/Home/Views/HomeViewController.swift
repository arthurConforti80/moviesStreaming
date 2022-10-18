//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 16/10/22.
//

import Foundation
import UIKit


class HomeViewController: UIViewController {
    
    let titleScreen = "MovieApp"
    let sizeFontTitle = 23
    let rowHeight = 120
    let deadLineAvarage = 6.0
    let titleAlert = "Alert"
    let messageAlert = "The movie don't have quality sufficient"
    let buttonAlert = "OK"
    
    var viewModel : HomeViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var itensMoview: [ItensMovies] = []

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchListGenres()
        setupBindable()
        configTitleLabel()
        configureTableView()
    }
    
    func configTitleLabel() {
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(sizeFontTitle))
        titleLabel.textAlignment = .center
        titleLabel.text = titleScreen
    }
    
    func configureTableView() {
        tableView.dataSource     = self
        tableView.delegate       = self
        tableView.separatorStyle = .singleLine
        tableView.rowHeight      = CGFloat(rowHeight)
        tableView.backgroundColor = UIColor.black
        tableView.register(cellType: SectionsTableViewCell.self, bundle: Bundle.main)
    }
    
    func setupBindable() {
        self.viewModel.updateListSections.bind { [weak self] updateListSections in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reponseList?.genres.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SectionsTableViewCell.self,
                                                 for: indexPath)
        let idGenre = viewModel.reponseList?.genres[indexPath.row].id ?? 0
        let name = viewModel.reponseList?.genres[indexPath.row].name ?? ""
        let itemMovies = viewModel.responseMoviesList?.results ?? []
        
        cell.delegate = self
        cell.configTitleLabel(name: name)
        cell.configCellTable(id: idGenre, model: itemMovies)
        return cell
    }
}

extension HomeViewController: CollectionViewDelegate {
    func collectionViewDidTapCell(_ cell: SectionsTableViewCell, movie: ItensMovies) {
        let avarege = movie.vote_average
        if avarege < Float(deadLineAvarage) {
            let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: buttonAlert, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            viewModel.goToDetail(id: movie.id)
        }
    }
}

