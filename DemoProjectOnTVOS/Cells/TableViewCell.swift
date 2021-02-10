//
//  TableViewCell.swift
//  DemoProjectOnTVOS
//
//  Created by Mounika Reddy on 10/02/21.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleDisplay: UILabel!
    var arrayItems = [Any]()
    weak var delegate: TableViewCellDelegate?
    let imageURLString = "https://services.brninfotech.com/tws/"
    var defaultImageStyle:String!
    
    func setData(title:String,data:[Any]){
        self.titleDisplay.text=title
        self.arrayItems = data
        self.collectionView.reloadData()
    }
    
    
    func selectedAsset(index:Int) {
        if index > -1 {
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: false)
            }
        }
        else {
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayItems.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as? CollectionViewCell {
            let object = arrayItems[indexPath.row]
            cell.imageView.layer.cornerRadius = 15
            cell.imageView.contentMode = .scaleAspectFit
            cell.imageView.clipsToBounds = true
            
            if object is MovieDetails {
                if let categoryObj = object as? MovieDetails {
                    if let trimmed = categoryObj.posters![0].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                        let imageURL = imageURLString + trimmed
                        cell.imageView.kf.setImage(with: URL(string: imageURL))
                    }

                }
            }

            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let object = arrayItems[indexPath.row]
        print(indexPath)
        //Categories
        if object is MovieDetails {
            if let categoryObj = object as? MovieDetails {
                self.delegate?.carouselPassing(object: categoryObj,selectedIndex: indexPath.item)
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        collectionView.remembersLastFocusedIndexPath = true
        //Previous Index Focus
        if let previousIndexPath = context.previouslyFocusedIndexPath,
            let cell = collectionView.cellForItem(at: previousIndexPath)
        {
            cell.transform = .identity
        }
        //Next Index Focus
         if let indexPath = context.nextFocusedIndexPath {
            let object = arrayItems[indexPath.row]
            if object is MovieDetails {
                if let categoryObj = object as? MovieDetails {
                    self.delegate?.carouselFocused(object: categoryObj)
                }
            }
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 300, height: 400)
        
    }



}
protocol TableViewCellDelegate : class {
    func carouselSelected(type: String)
    func carouselFocused(object: Any)
    func carouselPassing(object: Any,selectedIndex:Int)
}

extension TableViewCellDelegate {
    
    func carouselSelected(type: String) {
        
    }
    func carouselFocused(object: Any) {
        
    }
    func carouselPassing(object: Any) {
        
    }
}
