//
//  CollectionViewCell.swift
//  DemoProjectOnTVOS
//
//  Created by Mounika Reddy on 10/02/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    public var focusedScale: CGFloat = 1.15
    
    public override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        super.didUpdateFocus(in: context, with: coordinator)
        backgroundColor = isFocused ? UIColor.clear : .clear
        if self == context.nextFocusedView {
            coordinator.addCoordinatedAnimations({
                self.layer.transform = CATransform3DMakeScale(self.focusedScale, self.focusedScale, 1)
            }, completion: nil)
            }
        else if self == context.previouslyFocusedView {
            coordinator.addCoordinatedAnimations({
                self.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }

    
    
}
