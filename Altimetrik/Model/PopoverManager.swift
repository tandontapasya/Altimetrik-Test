//  Created by Tapasya on 23/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

class PopoverManager: NSObject {
    private var popoverController: UIPopoverPresentationController?
    
    private weak var presentationController: UIViewController?
    private weak var presentingViewController: UIViewController?

    public init(presentationController: UIViewController,presentingViewController:UIViewController) {
        super.init()
        
        self.presentationController = presentationController
        self.presentingViewController = presentingViewController
        
        presentationController.modalPresentationStyle = UIModalPresentationStyle.popover
        popoverController = presentationController.popoverPresentationController
        popoverController?.permittedArrowDirections = [.up]
        popoverController?.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1.0)
    }
    
    func showPopover(from sourceView: UIView) {
        popoverController?.sourceRect = sourceView.bounds
        popoverController?.sourceView =  sourceView
        
        self.presentingViewController?.present(presentationController!, animated: true, completion: {
            self.presentationController!.view.superview?.layer.cornerRadius = 0
        })
    }
}
