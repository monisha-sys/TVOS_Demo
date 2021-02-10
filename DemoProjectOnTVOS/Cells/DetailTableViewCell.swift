//
//  DetailTableViewCell.swift
//  DemoProjectOnTVOS
//
//  Created by Mounika Reddy on 10/02/21.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pngImage: UIImageView!
    @IBOutlet weak var displayTitle: UILabel!
    
    public var focusedScale: CGFloat = 1.04
    
    public override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        super.didUpdateFocus(in: context, with: coordinator)
        backgroundColor = isFocused ? UIColor.white : .clear
        if self == context.nextFocusedView {
            self.displayTitle?.textColor = .darkGray
            let templateImage = pngImage.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            pngImage.image = templateImage
            pngImage.tintColor = .darkGray
   //         self.pngImage.tintColor = .darkGray
            coordinator.addCoordinatedAnimations({
                self.layer.transform = CATransform3DMakeScale(self.focusedScale, self.focusedScale, 1)
            }, completion: nil)
        }
        else if self == context.previouslyFocusedView {
            self.displayTitle?.textColor = .white
            let templateImage = pngImage.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            pngImage.image = templateImage
            pngImage.tintColor = .white
            coordinator.addCoordinatedAnimations({
                self.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
