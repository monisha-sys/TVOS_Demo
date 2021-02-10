//
//  DetailViewController.swift
//  DemoProjectOnTVOS
//
//  Created by Mounika Reddy on 10/02/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!  
    @IBOutlet weak var disLikeCountDisplayLabel: UILabel!
    @IBOutlet weak var viewCountDisplayLabel: UILabel!
    @IBOutlet weak var viewImageView: UIImageView!
    @IBOutlet weak var likeCountDisplayLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var dislikeImageView: UIImageView!
    @IBOutlet weak var heightConstriantTableView: NSLayoutConstraint!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    let playMenu = ["Resume","Play","Add To MyList"]
    let pngIcons = [UIImage(named: "resume"),UIImage(named: "play_hover"),UIImage(named: "addtoList_hover")]
    
    let giftMenu = ["Resume","Play","Add To MyList","Gift Now"]
    let giftIcons = [UIImage(named: "resume"),UIImage(named: "play_hover"),UIImage(named: "addtoList_hover"),UIImage(named: "gift")]
    
    let likeImage = UIImage(named: "like_fill")?.withRenderingMode(.alwaysTemplate)
    let image = UIImage(named: "dislike_fill")?.withRenderingMode(.alwaysTemplate)
    
    //Variables used in data passing from previous View
    var movieImage: String?
    var displayTitle: String?
    var year: String?
    var time: String?
    var descrip: String?
    var cast: String?
    var director: String?
    var myListObject: Bool?
    var preDuration: Int?
    var giftAllowance: Bool?
    var data:MovieDetails!
    let imageURLString = "https://services.brninfotech.com/tws/"

    
    var viewToFocus: UIView? = nil {
        didSet {
            if viewToFocus != nil {
                self.setNeedsFocusUpdate();
                self.updateFocusIfNeeded();
            }
        }
    }
    
    override weak var preferredFocusedView: UIView? {
        if viewToFocus != nil {
            return viewToFocus;
        } else {
            return super.preferredFocusedView;
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate=self
        tableView.dataSource = self
        
        alignmentOfLabels()
    }

   
    func alignmentOfLabels() {
        let url = URL(string: movieImage ?? "")
        displayImage.kf.setImage(with: url)
        movieTitle.text = displayTitle
        descriptionLabel.text = descrip
        castLabel.text = cast
        directorLabel.text = director
    }
    

    
    @IBAction func onTapLikeDisLike(_ sender: UIButton) {
        

    }

    
    
    
    
 // Mark: - tableview Delegates and datasource methods
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.giftAllowance == true {
            return giftMenu.count
        }
        else {
            return playMenu.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTableViewCell.self), for: indexPath) as? DetailTableViewCell {
            
            if self.giftAllowance == true {
                cell.displayTitle.text = giftMenu[indexPath.row]
                cell.pngImage.image = giftIcons[indexPath.row]
            }
            else {
                cell.displayTitle.text = playMenu[indexPath.row]
                cell.pngImage.image = pngIcons[indexPath.row]
            }
            
            if (self.myListObject != nil && self.myListObject == true) {
                if cell.displayTitle.text == "Add To MyList" {
                    cell.displayTitle.text = "Remove From MyList"
                    cell.pngImage.image = UIImage(named: "removeFromList_hover")
                }
            }
            if preDuration == nil || preDuration ?? 0 <= 15 {
                if indexPath.row == 0 {
                    cell.isHidden = true
                }
                else {
                    cell.isHidden = false
                }
            }
            else {
                cell.isHidden = false
            }
            if preDuration != nil && preDuration ?? 0 >= 15 {
                if cell.displayTitle.text == "Play" {
                    cell.displayTitle.text = "Play From Beginning"
                }
            }
            return cell
        }
        return UITableViewCell()

    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! DetailTableViewCell

        switch indexPath.row {
        case 0:
            // resume  Video
        print("resume")
        case 1:
            // play video
        print("playVideo")
            if let playerPage = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PlayerViewController.self)) as? PlayerViewController {
                if let trimmed = data.trailers![0].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    let imageURL = imageURLString + trimmed
                    playerPage.videoStreaming(video:imageURL )

                }
                self.navigationController?.pushViewController(playerPage, animated: true)
            }
        case 2:
            //add to my list
        print("added to wishlist")
        case 3:
            // gift now
        print("gift now")
        default:
            break
        }
        
    }
}
