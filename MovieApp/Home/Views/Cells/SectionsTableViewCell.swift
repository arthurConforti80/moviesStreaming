//
//  SectionsTableViewCell.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 17/10/22.
//

import UIKit

protocol CollectionViewDelegate: AnyObject {
    func collectionViewDidTapCell(_ cell: SectionsTableViewCell, movie: ItensMovies)
}

class SectionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    weak var delegate: CollectionViewDelegate?
    
    var itensMoview: [ItensMovies] = []
    var selectedMovie: ItensMovies!
    var id: Int = 0
    var cellHidden: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configTitleLabel(name: String) {
        loading.stopAnimating()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textAlignment = .left
        titleLabel.text = name
    }
    
    func configCellTable(id: Int, model: [ItensMovies]) {
        for byItem in model {
            if byItem.genre_ids.contains(id) {
                self.itensMoview.append(byItem)
            }
        }
        
        configCollectionView()
    }
    
    func configCollectionView() {
        contentView.backgroundColor = .black
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 128, height: 80)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    func startLoading() {
        loading.startAnimating()
    }
    
}

extension SectionsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let teste = self.itensMoview.count
        print(teste)
        return self.itensMoview.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(poster: self.itensMoview[indexPath.row].poster_path)
        cell.isHidden = cellHidden
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMovie = self.itensMoview[indexPath.row]
        delegate?.collectionViewDidTapCell(self, movie: self.selectedMovie)
    }
}
