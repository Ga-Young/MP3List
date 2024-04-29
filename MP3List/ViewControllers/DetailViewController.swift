//
//  LyricsViewController.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/29/24.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var lyricsTextVew: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    
    var data: TrackListResponse?
    
    var dismissHandler: (()->(Void))?
    
    private var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.loadTrackData()
    }
    
    func configure(with trackId: String) {
        viewModel = DetailViewModel()
        viewModel.trackID = trackId
    }
    
    func updateUI() {
         let lyricsText = viewModel.getLyrics()
        lyricsTextVew.text = viewModel.getLyrics()
        lyricsTextVew.textAlignment = .center
        
        titleLabel.text = data?.name
        artistLabel.text = data?.representationArtist.name
     }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.updateUI()
        }
        
        viewModel.onError = { [weak self] error in
            self?.showAlertWithError(error)
        }
    }
    
    private func showAlertWithError(_ message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func touchUpInside(_ sender: Any) {
        switch sender as? UIButton {
        case closeButton:
            dismiss(animated: true) {
                self.dismissHandler?()
            }
            break
        default:
            break
        }
    }
}
