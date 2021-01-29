//
//  ViewController.swift
//  ToolTips
//
//  Created by Shilpa Kumari on 29/01/21.
//  Copyright © 2021 Shilpa Kumari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var isToolTipShown: Bool = false
    private var toolTip: ToolTipView!
    @IBOutlet weak var showTootipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showTooltipTapped(_ sender: UIButton) {
        isToolTipShown ? removeToolTip() : showToolTip()
        isToolTipShown = !isToolTipShown
    }
    
    private func showToolTip() {
        let tooltipViewWidth: CGFloat = 200
        let tooltipViewHeight: CGFloat = 200
        let rect = CGRect(x: showTootipButton.frame.midX-tooltipViewWidth/2, y: showTootipButton.frame.minY-tooltipViewHeight, width: tooltipViewWidth, height: tooltipViewHeight)
        toolTip = ToolTipView(frame: rect, cornerRadius: 10.0, text: "Hello! ")
        UIApplication.shared.keyWindow?.addSubview(toolTip)
        performShow(toolTip)
    }
    
    private func performShow(_ v: UIView?) {
        v?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.3, delay: 0.05, options: .curveEaseOut, animations: {
            v?.transform = .identity
        }) { finished in
        }
    }
    
    private func removeToolTip() {
        performHide(toolTip)
    }
    
    private func performHide(_ v: UIView?) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            v?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { finished in
            self.toolTip.removeFromSuperview()
        }
    }
}

