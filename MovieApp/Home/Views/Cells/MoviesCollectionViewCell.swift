//
//  MoviesCollectionViewCell.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 18/10/22.
//

import UIKit


class MoviesCollectionViewCell: UICollectionViewCell {
    
    let urlImage = "https://image.tmdb.org/t/p/w500/"
    
    static let identifier = "MoviesCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(poster: String) {
        guard let url = URL(string: "\(urlImage)\(poster )") else {
           return
       }
        posterImageView.load(url: url)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
