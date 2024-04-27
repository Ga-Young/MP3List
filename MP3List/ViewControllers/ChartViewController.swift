//
//  ViewController.swift
//  MP3List
//
//  Created by Gayoung Kim on 4/22/24.
//

import UIKit
import Kingfisher

class ChartViewController: UIViewController {
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
    @IBOutlet weak var globalSocialChartView: UIView! {
        didSet {
            globalSocialChartView.layer.cornerRadius = 8
            globalSocialChartView.layer.masksToBounds = true
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
//            pageControl.numberOfPages = chartData.count / 5
//            pageControl.currentPage = 0
            pageControl.currentPageIndicatorTintColor = .purple
            pageControl.pageIndicatorTintColor = .lightGray
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
    
    var chartData: [ChartItem] = []
    let itemsPerPage = 5
    var genreThemeData: [[GenreThemeItem]] = []
    var audioData: [GenreThemeItem] = []
    var videoData: [VideoItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        pageControl.numberOfPages = chartData.count / 5
        pageControl.currentPage = 0
        
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
    
    func loadData() {
        chartData = [
            ChartItem(id: 1, title: "As It Was", artist: "Harry Styles", albumImageURL: URL(string: "https://cdn.music-flo.com/image/v2/album/981/836/05/04/405836981_602cbb8c_o.jpg?1613544332419/dims/resize/75x75/quality/90")!),
            ChartItem(id: 2, title: "About Damn Time", artist: "Lizzo", albumImageURL: URL(string: "https://cdn.music-flo.com/image/v2/album/981/836/05/04/405836981_602cbb8c_o.jpg?1613544332419/dims/resize/75x75/quality/90")!),
            ChartItem(id: 3, title: "First Class", artist: "Jack Harlow", albumImageURL: URL(string: "https://cdn.music-flo.com/image/v2/album/981/836/05/04/405836981_602cbb8c_o.jpg?1613544332419/dims/resize/75x75/quality/90")!),
            ChartItem(id: 4, title: "Wait For U", artist: "Future ft. Drake & Tems", albumImageURL: URL(string: "https://cdn.music-flo.com/image/v2/album/981/836/05/04/405836981_602cbb8c_o.jpg?1613544332419/dims/resize/75x75/quality/90")!),
            ChartItem(id: 5, title: "Running Up That Hill", artist: "Kate Bush", albumImageURL: URL(string: "https://cdn.music-flo.com/image/v2/album/981/836/05/04/405836981_602cbb8c_o.jpg?1613544332419/dims/resize/75x75/quality/90")!),
            ChartItem(id: 6, title: "Me Porto Bonito", artist: "Bad Bunny & Chencho Corleone", albumImageURL: URL(string: "https://cdn.music-flo.com/image/v2/album/981/836/05/04/405836981_602cbb8c_o.jpg?1613544332419/dims/resize/75x75/quality/90")!),
            ChartItem(id: 7, title: "Bad Habit", artist: "Steve Lacy", albumImageURL: URL(string: "https://cdn.music-flo.com/image/v2/album/981/836/05/04/405836981_602cbb8c_o.jpg?1613544332419/dims/resize/75x75/quality/90")!),
            ChartItem(id: 8, title: "Break My Soul", artist: "Beyoncé", albumImageURL: URL(string: "https://cdn.music-flo.com/image/v2/album/981/836/05/04/405836981_602cbb8c_o.jpg?1613544332419/dims/resize/75x75/quality/90")!),
            ChartItem(id: 9, title: "Sunroof", artist: "Nicky Youre & Dazy", albumImageURL: URL(string: "https://cdn.music-flo.com/image/v2/album/981/836/05/04/405836981_602cbb8c_o.jpg?1613544332419/dims/resize/75x75/quality/90")!),
            ChartItem(id: 10, title: "Late Night Talking", artist: "Harry Styles", albumImageURL: URL(string: "https://cdn.music-flo.com/image/v2/album/981/836/05/04/405836981_602cbb8c_o.jpg?1613544332419/dims/resize/75x75/quality/90")!)
        ]
        
        genreThemeData = [
            [
                GenreThemeItem(id: 1, title: "국내 발라드", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/cf603facfcbe45b5acf3421b0843f49a.jpg"),
                GenreThemeItem(id: 2, title: "해외 팝", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/5ecae7e786734835a7e396cb657fb597.jpg"),
                GenreThemeItem(id: 3, title: "국내 댄스/일렉", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200623/b2c7e8931da2470ab19f48ba82710024.jpg"),
                GenreThemeItem(id: 4, title: "국내 알앤비", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/8eccffe057a1428598f2611592b048c4.jpg"),
                GenreThemeItem(id: 5, title: "국내 힙합", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20220214/cbef061870cf416db7a8bc681cf33248.jpg")
            ],
            [
                GenreThemeItem(id: 1, title: "국내 발라드", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/cf603facfcbe45b5acf3421b0843f49a.jpg"),
                GenreThemeItem(id: 2, title: "해외 팝", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/5ecae7e786734835a7e396cb657fb597.jpg"),
                GenreThemeItem(id: 3, title: "국내 댄스/일렉", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200623/b2c7e8931da2470ab19f48ba82710024.jpg"),
                GenreThemeItem(id: 4, title: "국내 알앤비", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/8eccffe057a1428598f2611592b048c4.jpg"),
                GenreThemeItem(id: 5, title: "국내 힙합", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20220214/cbef061870cf416db7a8bc681cf33248.jpg")
            ],
            [
                GenreThemeItem(id: 1, title: "국내 발라드", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/cf603facfcbe45b5acf3421b0843f49a.jpg"),
                GenreThemeItem(id: 2, title: "해외 팝", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/5ecae7e786734835a7e396cb657fb597.jpg"),
                GenreThemeItem(id: 3, title: "국내 댄스/일렉", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200623/b2c7e8931da2470ab19f48ba82710024.jpg"),
                GenreThemeItem(id: 4, title: "국내 알앤비", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/8eccffe057a1428598f2611592b048c4.jpg"),
                GenreThemeItem(id: 5, title: "국내 힙합", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20220214/cbef061870cf416db7a8bc681cf33248.jpg")
            ]
        ]
        
        audioData = [
            GenreThemeItem(id: 1, title: "국내 발라드", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/cf603facfcbe45b5acf3421b0843f49a.jpg"),
            GenreThemeItem(id: 2, title: "해외 팝", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/5ecae7e786734835a7e396cb657fb597.jpg"),
            GenreThemeItem(id: 3, title: "국내 댄스/일렉", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200623/b2c7e8931da2470ab19f48ba82710024.jpg"),
            GenreThemeItem(id: 4, title: "국내 알앤비", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20200911/8eccffe057a1428598f2611592b048c4.jpg"),
            GenreThemeItem(id: 5, title: "국내 힙합", imageURL: "https://cdn.music-flo.com/poc/p/image/display/genre_rc/20220214/cbef061870cf416db7a8bc681cf33248.jpg")
        ]
        
        videoData = [
            VideoItem(id: 0, thumnailImageURL: "https://cdn.music-flo.com/image/thumnail/null/257/079/00/04/400079257_64b7934b_s.jpg?1689752395374", playTime: "03:19", title: "Shooting Star (Live Clip)", artist: "다원"),
            VideoItem(id: 1, thumnailImageURL: "https://cdn.music-flo.com/image/thumnail/null/257/079/00/04/400079257_64b7934b_s.jpg?1689752395374", playTime: "03:19",title: "Shooting Star (Live Clip)", artist: "다원"),
            VideoItem(id: 2, thumnailImageURL: "https://cdn.music-flo.com/image/thumnail/null/257/079/00/04/400079257_64b7934b_s.jpg?1689752395374", playTime: "03:19",title: "Shooting Star (Live Clip)", artist: "다원"),
            VideoItem(id: 3, thumnailImageURL: "https://cdn.music-flo.com/image/thumnail/null/257/079/00/04/400079257_64b7934b_s.jpg?1689752395374", playTime: "03:19",title: "Shooting Star (Live Clip)", artist: "다원"),
            VideoItem(id: 4, thumnailImageURL: "https://cdn.music-flo.com/image/thumnail/null/257/079/00/04/400079257_64b7934b_s.jpg?1689752395374", playTime: "03:19",title: "Shooting Star (Live Clip)", artist: "다원"),
            VideoItem(id: 5, thumnailImageURL: "https://cdn.music-flo.com/image/thumnail/null/257/079/00/04/400079257_64b7934b_s.jpg?1689752395374", playTime: "03:19",title: "Shooting Star (Live Clip)", artist: "다원"),
            VideoItem(id: 6, thumnailImageURL: "https://cdn.music-flo.com/image/thumnail/null/257/079/00/04/400079257_64b7934b_s.jpg?1689752395374", playTime: "03:19",title: "Shooting Star (Live Clip)", artist: "다원"),
            VideoItem(id: 7, thumnailImageURL: "https://cdn.music-flo.com/image/thumnail/null/257/079/00/04/400079257_64b7934b_s.jpg?1689752395374", playTime: "03:19",title: "Shooting Star (Live Clip)", artist: "다원"),
            VideoItem(id: 8, thumnailImageURL: "https://cdn.music-flo.com/image/thumnail/null/257/079/00/04/400079257_64b7934b_s.jpg?1689752395374", playTime: "03:19",title: "Shooting Star (Live Clip)", artist: "다원"),
            VideoItem(id: 9, thumnailImageURL: "https://cdn.music-flo.com/image/thumnail/null/257/079/00/04/400079257_64b7934b_s.jpg?1689752395374", playTime: "03:19",title: "Shooting Star (Live Clip)", artist: "다원"),
        ]
        
        var genreThemeViewheight = 0
        for genreThemeDatum in genreThemeData {
            genreThemeViewheight += Int(ceil(Double(genreThemeDatum.count) / 2.0))
        }
        genreThemeViewHeightConstraint.constant = CGFloat(90 * genreThemeViewheight + 50 * genreThemeData.count)
        audioViewHeightConstraint.constant = CGFloat(90 * ceil(Double(audioData.count) / 2.0) + 50)
        view.layoutIfNeeded()
    }
    
    func updateButtonSelection(selected button: UIButton) {
        [chartButton, genreThemeButton, audioButton, videoButton].forEach {
            $0?.isSelected = false
            $0?.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        }
        button.isSelected = true
        button.backgroundColor = UIColor(red: 3/255, green: 1/255, blue: 246/255, alpha: 1)
    }
}

extension ChartViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageControl.currentPage = Int(scrollView.contentOffset.x / width)
        
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

extension ChartViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       if collectionView === genreThemeCollectionView {
           return genreThemeData.count
       } else if collectionView === videoCollectionView {
           return 2
       } else {
           return 1
       }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === floChartCollectionView {
            return chartData.count
        } else if collectionView === genreThemeCollectionView {
            return genreThemeData[section].count
        } else if collectionView === audioCollectionView {
            return audioData.count
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
            let item = chartData[indexPath.row]
            cell.titleLabel.text = item.title
            cell.rankLabel.text = "\(item.id)"
            cell.artistLabel.text = item.artist
            cell.albumImageView.loadImage(from: item.albumImageURL)
        
            return cell

        } else if collectionView === genreThemeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreThemeCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
                fatalError("Unable to dequeue ImageCollectionViewCell")
            }
            let item = genreThemeData[indexPath.section][indexPath.row]
            cell.titleLabel.text = item.title
            cell.configureImage(with: item.imageURL)
            
            return cell
            
        } else if collectionView === audioCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AudioCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
                fatalError("Unable to dequeue ImageCollectionViewCell")
            }
            let item = audioData[indexPath.row]
            cell.titleLabel.text = item.title
            cell.configureImage(with: item.imageURL)
            
            return cell
            
        } else if collectionView === videoCollectionView {
            if indexPath.section == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigVideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell else {
                    fatalError("Unable to dequeue ImageCollectionViewCell")
                }
                let item = videoData[indexPath.row]
                cell.loadImage(with: item.thumnailImageURL)
                cell.playTimeLabel.text = item.playTime
                cell.titleLabel.text = item.title
                cell.artistLabel.text = item.artist
                
                return cell
                
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondVideoCollectionViewCell", for: indexPath) as? SecondVideoCollectionViewCell else {
                       fatalError("Unable to dequeue SecondVideoCollectionViewCell")
                }
                cell.videoData = Array(videoData.dropFirst())
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
                header.titleLabel.text = "장르 섹션 헤더"
                return header
                
            } else if collectionView === audioCollectionView {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AudioHeader", for: indexPath) as! CollectionViewHeaderView
                header.titleLabel.text = "오디오 섹션 헤더"
                return header
            }
        }
        
        fatalError("Unexpected kind or collectionView")
    }
}

extension ChartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === floChartCollectionView {
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

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

