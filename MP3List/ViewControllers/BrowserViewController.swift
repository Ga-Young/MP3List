//
//  ViewController.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/22/24.
//

import UIKit
import Kingfisher

extension BrowserViewController {
    struct SegueIdentifier {
        static let PresentDetail = "PresentDetail"
    }
}

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
    @IBOutlet weak var floChartLable: UILabel!
    @IBOutlet weak var floChartUpdateLable: UILabel!
    @IBOutlet weak var floChartDescriptionLable: UILabel!
    
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
    @IBOutlet weak var globalChartLable: UILabel!
    @IBOutlet weak var globalChartUpdateLable: UILabel!
    @IBOutlet weak var globalChartDescriptionLable: UILabel!
    
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case SegueIdentifier.PresentDetail:
            if let viewController = segue.destination as? DetailViewController, let data = sender as? TrackListResponse {
                viewController.data = data
                viewController.dismissHandler = {
               
                    self.updateUI()
                }
            }
            
        default:
            break
        }
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
        
        pageControl.numberOfPages = viewModel.numberOfTracksInChart(chartIndex: 0) / 5
        globalChartPageControl.numberOfPages = viewModel.numberOfTracksInChart(chartIndex: 1) / 5
        
        updateButtonSelection(selected: chartButton)
        
        floChartLable.text = viewModel.chartName(at: 0)
        floChartUpdateLable.text = viewModel.chartUpdateDate(at: 0)
        floChartDescriptionLable.text = viewModel.chartDescription(at: 0)
        globalChartLable.text = viewModel.chartName(at: 1)
        globalChartUpdateLable.text = viewModel.chartUpdateDate(at: 1)
        globalChartDescriptionLable.text = viewModel.chartDescription(at: 1)
        
        floChartCollectionView.reloadData()
        globalChartCollectionView.reloadData()
        genreThemeCollectionView.reloadData()
        audioCollectionView.reloadData()
        videoCollectionView.reloadData()
        
        var genreThemeViewheight = 0
        for section in viewModel.getSectionList() {
            genreThemeViewheight += Int(ceil(Double(section.shortcutList.count) / 2.0))
        }
        genreThemeViewHeightConstraint.constant = CGFloat(90 * genreThemeViewheight + 50 * viewModel.numberOfSection() + 15 * (viewModel.numberOfSection() - 1))
        
        audioViewHeightConstraint.constant = CGFloat(90 * ceil(Double(viewModel.numberOfProgramsInCategory()) / 2.0) + 50)
        view.layoutIfNeeded()
    }
    
    private func showAlertWithError(_ message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
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
           return viewModel.numberOfSection()
       } else if collectionView === videoCollectionView {
           return 2
       } else {
           return 1
       }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === floChartCollectionView, viewModel.hasFirstChart(at: 0) {
            return viewModel.numberOfTracksInChart(chartIndex: 0)
        } else if collectionView === globalChartCollectionView, viewModel.hasFirstChart(at: 1) {
            return viewModel.numberOfTracksInChart(chartIndex: 1)
        } else if collectionView === genreThemeCollectionView, viewModel.hasFirstSection() {
            return viewModel.numberOfShortcutList(at: section)
        } else if collectionView === audioCollectionView, viewModel.hasFirstProgramCategory() {
            return viewModel.numberOfProgramsInCategory()
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
            if indexPath.row < viewModel.numberOfTracksInChart(chartIndex: 0) {
                let item = viewModel.trackForItem(at: indexPath, chartType: .flo)
                cell.titleLabel.text = item?.name
                cell.rankLabel.text = "\(indexPath.row + 1)"
                cell.artistLabel.text = item?.representationArtist.name
                loadImage(with: item?.album.imgList.first?.url, imageView: cell.albumImageView)
            }
        
            return cell

        } else if collectionView === globalChartCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GlobalChartCollectionViewCell", for: indexPath) as? ChartCollectionViewCell else {
                fatalError("Unable to dequeue ChartCollectionViewCell")
            }
            if indexPath.row < viewModel.numberOfTracksInChart(chartIndex: 1) {
                let item = viewModel.trackForItem(at: indexPath, chartType: .global)
                cell.titleLabel.text = item?.name
                cell.rankLabel.text = "\(indexPath.row + 1)"
                cell.artistLabel.text = item?.representationArtist.name
                loadImage(with: item?.album.imgList.first?.url, imageView: cell.albumImageView)
            }
        
            return cell

        } else if collectionView === genreThemeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreThemeCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
                fatalError("Unable to dequeue ImageCollectionViewCell")
            }
            if indexPath.row < viewModel.numberOfShortcutList(at: indexPath.section) {
                let item = viewModel.itemInSection(at: indexPath)
                cell.titleLabel.text = item?.name
                cell.configureImage(with: item?.imgList.first?.url)
            }
            
            return cell
            
        } else if collectionView === audioCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AudioCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
                fatalError("Unable to dequeue ImageCollectionViewCell")
            }
            if indexPath.row < viewModel.numberOfProgramsInCategory() {
                let item = viewModel.programCategoryAt(index: indexPath.row)
                cell.titleLabel.text = item?.displayTitle
                cell.configureImage(with: item?.imgUrl)
            }

            return cell
            
        } else if collectionView === videoCollectionView {
            if indexPath.section == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigVideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell else {
                    fatalError("Unable to dequeue VideoCollectionViewCell")
                }
                if indexPath.row < viewModel.numberOfVideoList() {
                    let item = viewModel.videoAt(index: indexPath.row)
                    cell.loadImage(with: item?.thumbnailImageList.first?.url)
                    cell.playTimeLabel.text = item?.playTm
                    cell.titleLabel.text = item?.videoNm
                    cell.artistLabel.text = item?.representationArtist.name
                }
     
                return cell
                
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondVideoCollectionViewCell", for: indexPath) as? SecondVideoCollectionViewCell else {
                       fatalError("Unable to dequeue SecondVideoCollectionViewCell")
                }
           
                cell.videoData = viewModel.videoListDropFirst()
                
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
                
                if viewModel.hasFirstSection() {
                    header.titleLabel.text = viewModel.nameOfSection(at: indexPath.section)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chartType: ChartType = collectionView === floChartCollectionView ? .flo : .global
        let item = viewModel.trackForItem(at: indexPath, chartType: chartType)
        
        performSegue(withIdentifier: SegueIdentifier.PresentDetail, sender: item)
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

