//
//  ViewController.swift
//  DemoProjectOnTVOS
//
//  Created by Mounika Reddy on 10/02/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var focusedImageView: UIImageView!
    @IBOutlet weak var focusedImageTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var request:URLRequest!
    var dataTask:URLSessionDataTask!
    var defaultImageStyle:String!
    var convertedData = [MovieDetails]()
    fileprivate let rowHeight = UIScreen.main.bounds.height * 0.2
    var listSelectedIndex: Int? = -1
    var carouselSelectedIndex: Int? = -1
    let imageURLString = "https://services.brninfotech.com/tws/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate=self
        tableView.dataSource = self
        
        convertedData = movieDetails()

    }


    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as? TableViewCell {
            
            cell.setData(title: "Movies", data: convertedData)
            cell.selectedAsset(index: carouselSelectedIndex ?? -1)
            cell.delegate = self
            return cell
            
        }
        return UITableViewCell()
    }
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return rowHeight * 1.6
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionHeaderHeight = rowHeight * 0.01
        return sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedIndexPath != nil) {
            listSelectedIndex = context.nextFocusedIndexPath?.section
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = titleLabel.font.withSize(22)
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: (rowHeight) * 0.05)
        titleLabel.text = ""
        headerView.addSubview(titleLabel)
        return headerView
    }

    
}

extension ViewController {
    
    func movieDetails()->[MovieDetails]{

         var output:[MovieDetails]!

         request=URLRequest(url: URL(string: "https://services.brninfotech.com/tws/MovieDetails2.php?mediaType=movies")!)

         request.httpMethod="GET"
         dataTask=URLSession.shared.dataTask(with: request, completionHandler: { (data, connDetils, err) in
             do{
                 output = try JSONDecoder().decode([MovieDetails].self,from:data!)
               print(output.count)
               }

             catch{
                 print("something went wrong")
             }
         })
         dataTask.resume()

         while (output==nil){

         }
         return output

     }

}

extension ViewController : TableViewCellDelegate {
    func carouselPassing(object: Any, selectedIndex: Int) {
        
        self.carouselSelectedIndex = selectedIndex
        if object is MovieDetails {
            if let carouselObj = object as? MovieDetails {
                if let detailPage = self.storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
                    
                    detailPage.data = carouselObj
                    if let trimmed = carouselObj.posters![0].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                        let imageURL = imageURLString + trimmed
                        detailPage.movieImage = imageURL
                    }
                    detailPage.displayTitle = carouselObj.title
                    if carouselObj.story != nil && carouselObj.story != "" {
                        detailPage.descrip = carouselObj.story!
                    }else {
                        detailPage.descrip = ""
                    }
                    detailPage.director = carouselObj.director!
                    self.navigationController?.pushViewController(detailPage, animated: true)

                }
            }
        }
        
    }
    
    
    func carouselFocused(object: Any) {
        
        if object is MovieDetails {
            if let menuObj = object as? MovieDetails {
                if let trimmed = menuObj.posters![0].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    let imageURL = imageURLString + trimmed
                    self.focusedImageView.contentMode = .scaleAspectFit
                    self.focusedImageView.kf.setImage(with: URL(string: imageURL))
                }
                self.focusedImageTitle.text = menuObj.title
                if menuObj.story != nil && menuObj.story != "" {
                self.descriptionLabel.text = menuObj.story
                }else {
                    self.descriptionLabel.text = ""
                }
            }

        }
    }
    
    func carouselSelected(type: String) {
        print("selected")
    }
    
}
