//
//  ShadowLayer.swift
//  Beerer
//
//  Created by Leonardo Razovic on 18/03/18.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit

class ShadowLayer: UIView {

        override var bounds: CGRect {
            didSet {
                setupShadow()
            }
        }

        private func setupShadow() {
            self.layer.shadowOffset = CGSize(width: 4, height: 4)
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.48
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }

