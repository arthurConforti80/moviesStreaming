//
//  DetailsViewControllers.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 18/10/22.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    let titleScreen = "Details Movies"
    let urlImage = "https://image.tmdb.org/t/p/w500/"
    let sizeFontTitle = 23
    let sizeFontAvaregeVoted = 12
    let sizeFontDescription = 15
    let textAvarege = "Avarage: "
    let attrs = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
    ]
    
    @IBOutlet weak var imagemPoster: UIImageView!
    @IBOutlet weak var titleMoview: UILabel!
    @IBOutlet weak var avarage_voted: UILabel!
    @IBOutlet weak var avarege_number: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    
    var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        viewModel.fetchDetail()
        setupBindable()
    }
    
    func setupHeader() {
        self.title = titleScreen
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setupBindable() {
        self.viewModel.updateInfo.bind { [weak self] updateInfo in
            guard let self = self else { return }
            self.configPoster()
            self.configLabels()
            self.configText()
        }
    }
    
    func configPoster() {
        guard let url = URL(string: "\(urlImage)\(viewModel.responseDetail?.backdrop_path ?? "" )") else {
           return
       }
        imagemPoster.load(url: url)
    }
    
    func configLabels() {
        titleMoview.textColor = UIColor.white
        titleMoview.font = UIFont.boldSystemFont(ofSize: CGFloat(sizeFontTitle))
        titleMoview.textAlignment = .center
        titleMoview.text = viewModel.responseDetail?.title
        
        avarage_voted.textColor = UIColor.white
        avarage_voted.font = UIFont.systemFont(ofSize: CGFloat(sizeFontAvaregeVoted), weight: .bold)
        avarage_voted.textAlignment = .center
        avarage_voted.text = "\(textAvarege)\(viewModel.responseDetail?.vote_average ?? 0.0)"
    }
    
    func configText() {
        let attributedString = NSMutableAttributedString(string: viewModel.responseDetail?.overview ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        descriptions.attributedText = attributedString
        descriptions.textColor = UIColor.white
        descriptions.font = UIFont.systemFont(ofSize: CGFloat(sizeFontDescription), weight: .regular)
        descriptions.textAlignment = .left
    }
}
