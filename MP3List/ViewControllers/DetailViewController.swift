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
    
    private var viewModel = LyricsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
         let lyricsText = viewModel.getLyrics()
        lyricsTextVew.text = lyricsText.isEmpty ? "가사 정보 없음" : lyricsText
        lyricsTextVew.textAlignment = .center
        
        titleLabel.text = data?.name
        artistLabel.text = data?.representationArtist.name
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
