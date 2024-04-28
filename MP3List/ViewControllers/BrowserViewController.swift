//
//  ViewController.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/22/24.
//

import UIKit
import Kingfisher

class BrowserViewController: UIViewController {
    @IBOutlet weak var chartButton: UIButton! {
        didSet {
            chartButton.layer.cornerRadius = 15
            chartButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var genreThemeButton: UIButton! {
        didSet {
            genreThemeButton.layer.cornerRadius = 15
            genreThemeButton.clipsToBounds = true
            
        }
    }
    @IBOutlet weak var audioButton: UIButton! {
        didSet {
            audioButton.layer.cornerRadius = 15
            audioButton.clipsToBounds = true
            
        }
    }
    @IBOutlet weak var videoButton: UIButton! {
        didSet {
            videoButton.layer.cornerRadius = 15
            videoButton.clipsToBounds = true
            
        }
    }
    
    @IBOutlet weak var contentsScrollView: UIScrollView! {
        didSet {
            contentsScrollView.delegate = self
        }
    }
    
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var floChartView: UIView! {
        didSet {
            floChartView.layer.cornerRadius = 8
            floChartView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var floChartCollectionView: UICollectionView! {
        didSet {
            floChartCollectionView.delegate = self
            floChartCollectionView.dataSource = self
            floChartCollectionView.isPagingEnabled = true
        }
    }
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.currentPage = 0
            pageControl.currentPageIndicatorTintColor = .purple
            pageControl.pageIndicatorTintColor = .lightGray
        }
    }
    
    @IBOutlet weak var globalChartView: UIView! {
        didSet {
            globalChartView.layer.cornerRadius = 8
            globalChartView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var globalChartCollectionView: UICollectionView! {
        didSet {
            globalChartCollectionView.delegate = self
            globalChartCollectionView.dataSource = self
            globalChartCollectionView.isPagingEnabled = true
        }
    }
    
    @IBOutlet weak var globalChartPageControl: UIPageControl! {
        didSet {
            globalChartPageControl.currentPage = 0
            globalChartPageControl.currentPageIndicatorTintColor = .purple
            globalChartPageControl.pageIndicatorTintColor = .lightGray
        }
    }
    
    @IBOutlet weak var genreThemeView: UIView!
    @IBOutlet weak var genreThemeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var genreThemeCollectionView: UICollectionView! {
        didSet {
            genreThemeCollectionView.delegate = self
            genreThemeCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var audioView: UIView!
    @IBOutlet weak var audioViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var audioCollectionView: UICollectionView! {
        didSet {
            audioCollectionView.delegate = self
            audioCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoCollectionView: UICollectionView! {
        didSet {
            videoCollectionView.delegate = self
            videoCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    let itemsPerPage = 5
    private var viewModel = ChartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        
        bindViewModel()
        viewModel.loadChartData()
        
        chartButton.isSelected = true
        genreThemeButton.isSelected = false
        audioButton.isSelected = false
        videoButton.isSelected = false
    }
    
    @IBAction func touchUpInside(_ sender: Any) {
        switch sender as? UIButton {
        case chartButton:
            let chartPosition = chartView.frame.origin
            contentsScrollView.setContentOffset(chartPosition, animated: true)
            break
            
        case genreThemeButton:
            let genrePosition = genreThemeView.frame.origin
            contentsScrollView.setContentOffset(CGPoint(x: 0, y: genrePosition.y), animated: true)
            break
            
        case audioButton:
            let audioPosition = audioView.frame.origin
            contentsScrollView.setContentOffset(CGPoint(x: 0, y: audioPosition.y), animated: true)
            break
            
        case videoButton:
            let videoPosition = videoView.frame.origin
            contentsScrollView.setContentOffset(CGPoint(x: 0, y: videoPosition.y), animated: true)
            break
            
        default:
            break
        }
        
        if let button = sender as? UIButton {
            updateButtonSelection(selected: button)
        }
    }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.updateUI()
        }
        
        viewModel.onError = { [weak self] error in
            self?.showAlertWithError(error)
        }
    }
    
    private func updateUI() {
        indicatorView.isHidden = true
        indicatorView.stopAnimating()
        
        pageControl.numberOfPages = viewModel.chartList[0].trackList.count / 5
        
        globalChartPageControl.numberOfPages = viewModel.chartList[0].trackList.count / 5
        
        floChartCollectionView.reloadData()
        globalChartCollectionView.reloadData()
        genreThemeCollectionView.reloadData()
        audioCollectionView.reloadData()
        videoCollectionView.reloadData()
        
        var genreThemeViewheight = 0
        for section in viewModel.sectionList {
            genreThemeViewheight += Int(ceil(Double(section.shortcutList.count) / 2.0))
        }
        genreThemeViewHeightConstraint.constant = CGFloat(90 * genreThemeViewheight + 50 * viewModel.sectionList.count)
        audioViewHeightConstraint.constant = CGFloat(90 * ceil(Double(viewModel.programCategory.count) / 2.0) + 50)
        view.layoutIfNeeded()
    }
    
    private func showAlertWithError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func updateButtonSelection(selected button: UIButton) {
        [chartButton, genreThemeButton, audioButton, videoButton].forEach {
            $0?.isSelected = false
            $0?.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        }
        button.isSelected = true
        button.backgroundColor = UIColor(red: 3/255, green: 1/255, blue: 246/255, alpha: 1)
    }
    
    func loadImage(with urlString: String?, imageView: UIImageView) {
        guard let url = URL(string: urlString!) else {
            print("Invalid URL")
            return
        }
        
        imageView.kf.setImage(with: url)
    }
}

extension BrowserViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let pageIndex = Int(scrollView.contentOffset.x / width)
        
        if scrollView == floChartCollectionView {
            pageControl.currentPage = pageIndex
        } else if scrollView == globalChartCollectionView {
            globalChartPageControl.currentPage = pageIndex
        }
        
 
        let scrollPosition = scrollView.contentOffset.y
        if scrollPosition >= chartView.frame.minY && scrollPosition < genreThemeView.frame.minY {
            updateButtonSelection(selected: chartButton)
        } else if scrollPosition >= genreThemeView.frame.minY && scrollPosition < audioView.frame.minY {
            updateButtonSelection(selected: genreThemeButton)
        } else if scrollPosition >= audioView.frame.minY && scrollPosition < videoView.frame.minY {
            updateButtonSelection(selected: audioButton)
        } else if scrollPosition >= videoView.frame.minY {
            updateButtonSelection(selected: videoButton)
        }
    }
}

extension BrowserViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       if collectionView === genreThemeCollectionView {
           return viewModel.sectionList.count
       } else if collectionView === videoCollectionView {
           return 2
       } else {
           return 1
       }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === floChartCollectionView, viewModel.chartList.indices.contains(0) {
            return viewModel.chartList[0].trackList.count
        } else if collectionView === globalChartCollectionView, viewModel.chartList.indices.contains(1) {
            return viewModel.chartList[1].trackList.count
        } else if collectionView === genreThemeCollectionView, viewModel.sectionList.indices.contains(0) {
            return viewModel.sectionList[section].shortcutList.count
        } else if collectionView === audioCollectionView, viewModel.programCategory.indices.contains(0) {
            return viewModel.programCategory.count
        } else if collectionView === videoCollectionView {
            return 1
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === floChartCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FloChartCollectionViewCell", for: indexPath) as? ChartCollectionViewCell else {
                fatalError("Unable to dequeue ChartCollectionViewCell")
            }
            if indexPath.row < viewModel.chartList[0].trackList.count {
                let item = viewModel.chartList[0].trackList[indexPath.row]
                cell.titleLabel.text = item.name
                cell.rankLabel.text = "\(indexPath.row + 1)"
                cell.artistLabel.text = item.representationArtist.name
                loadImage(with: item.album.imgList.first?.url, imageView: cell.albumImageView)
            }
        
            return cell

        } else if collectionView === globalChartCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GlobalChartCollectionViewCell", for: indexPath) as? ChartCollectionViewCell else {
                fatalError("Unable to dequeue ChartCollectionViewCell")
            }
            if indexPath.row < viewModel.chartList[1].trackList.count {
                let item = viewModel.chartList[1].trackList[indexPath.row]
                cell.titleLabel.text = item.name
                cell.rankLabel.text = "\(indexPath.row + 1)"
                cell.artistLabel.text = item.representationArtist.name
                loadImage(with: item.album.imgList.first?.url, imageView: cell.albumImageView)
            }
        
            return cell

        } else if collectionView === genreThemeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreThemeCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
                fatalError("Unable to dequeue ImageCollectionViewCell")
            }
            if indexPath.row < viewModel.sectionList[indexPath.section].shortcutList.count {
                let item = viewModel.sectionList[indexPath.section].shortcutList[indexPath.row]
                cell.titleLabel.text = item.name
                cell.configureImage(with: item.imgList.first?.url)
            }
            
            return cell
            
        } else if collectionView === audioCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AudioCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
                fatalError("Unable to dequeue ImageCollectionViewCell")
            }
            if indexPath.row < viewModel.programCategory.count {
                let item = viewModel.programCategory[indexPath.row]
                cell.titleLabel.text = item.displayTitle
                cell.configureImage(with: item.imgUrl)
            }

            return cell
            
        } else if collectionView === videoCollectionView {
            if indexPath.section == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigVideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell else {
                    fatalError("Unable to dequeue VideoCollectionViewCell")
                }
                if indexPath.row < viewModel.videoList.count {
                    let item = viewModel.videoList[indexPath.row]
                    cell.loadImage(with: item.thumbnailImageList.first?.url)
                    cell.playTimeLabel.text = item.playTm
                    cell.titleLabel.text = item.videoNm
                    cell.artistLabel.text = item.representationArtist.name
                }
     
                return cell
                
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondVideoCollectionViewCell", for: indexPath) as? SecondVideoCollectionViewCell else {
                       fatalError("Unable to dequeue SecondVideoCollectionViewCell")
                }
                if viewModel.videoList.indices.contains(1) {
                    cell.videoData = Array(viewModel.videoList.dropFirst())
                }
                
                return cell
            }
            
        } else {
            fatalError("Unexpected collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if collectionView === genreThemeCollectionView {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GenreThemeHeader", for: indexPath) as! CollectionViewHeaderView
                
                if viewModel.sectionList.indices.contains(0) {
                    header.titleLabel.text = viewModel.sectionList[indexPath.section].name
                }
                
                return header
                
            } else if collectionView === audioCollectionView {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AudioHeader", for: indexPath) as! CollectionViewHeaderView
                
                header.titleLabel.text = "오디오"

                return header
            }
        }
        
        fatalError("Unexpected kind or collectionView")
    }
}

extension BrowserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === floChartCollectionView || collectionView === globalChartCollectionView {
            return CGSize(width: collectionView.bounds.size.width, height: 60)
        } else if collectionView === genreThemeCollectionView || collectionView === audioCollectionView {
            let width = (collectionView.frame.size.width - 10) / 2
            return CGSize(width: width, height: 80)
        } else if collectionView === videoCollectionView {
            let width = collectionView.frame.size.width
            return indexPath.section == 0 ? CGSize(width: width, height: 250) : CGSize(width: width, height: 200)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
}

