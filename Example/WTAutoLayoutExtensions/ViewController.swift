//
//  ViewController.swift
//  WTAutoLayoutExtensions
//
//  Created by Wagner Truppel on 12/26/2016.
//  Copyright (c) 2016 Wagner Truppel. All rights reserved.
//

import UIKit
import WTAutoLayoutExtensions

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let u0 = UIView()
        u0.translatesAutoresizingMaskIntoConstraints = false
        u0.backgroundColor = .green
        view.addSubview(u0)

        let insets = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
        u0.wtPinToSuperview(with: insets)

        let u1 = UIView()
        u1.translatesAutoresizingMaskIntoConstraints = false
        u1.backgroundColor = .red
        view.addSubview(u1)

        let u2 = UIView()
        u2.translatesAutoresizingMaskIntoConstraints = false
        u2.backgroundColor = .blue
        view.addSubview(u2)

        let leftGuide = UILayoutGuide()
        view.addLayoutGuide(leftGuide)

        let middleGuide = UILayoutGuide()
        view.addLayoutGuide(middleGuide)

        let rightGuide = UILayoutGuide()
        view.addLayoutGuide(rightGuide)

        // unbroken leading-to-trailing chain
        UIView.wtConstraint(view, .leadingMargin, .equal, leftGuide, .leading)
        UIView.wtConstraint(leftGuide, .trailing, .equal, u1, .leading)
        UIView.wtConstraint(u1, .trailing, .equal, middleGuide, .leading)
        UIView.wtConstraint(middleGuide, .trailing, .equal, u2, .leading)
        UIView.wtConstraint(u2, .trailing, .equal, rightGuide, .leading)
        UIView.wtConstraint(rightGuide, .trailing, .equal, view, .trailingMargin)

        // equal horizontal spaces
        UIView.wtConstraint(on: .width, middleGuide, .equal, leftGuide)
        UIView.wtConstraint(on: .width, middleGuide, .equal, rightGuide)

        // set aspect ratios
        UIView.wtAspectRatioConstraint(on: u1, .equal, 1)
        UIView.wtAspectRatioConstraint(on: u2, .equal, 2)

        // set heights
        UIView.wtConstraint(on: .height, u1, .equal, 100)
        UIView.wtConstraint(on: .height, u1, .equal, u2, times: 1.5, plus: 20)

        // arrange vertically
        UIView.wtConstraint(u1, .top, .equal, view, .topMargin, plus: 50)
        UIView.wtConstraint(u1, above: u2, offset: .equal, 100)

        // set layout guide heights
        UIView.wtConstraint(leftGuide, .top, .equal, u1, .top)
        UIView.wtConstraint(leftGuide, .bottom, .equal, u2, .bottom)
        //
        UIView.wtConstraint(middleGuide, .top, .equal, u1, .top)
        UIView.wtConstraint(middleGuide, .bottom, .equal, u2, .bottom)
        //
        UIView.wtConstraint(rightGuide, .top, .equal, u1, .top)
        UIView.wtConstraint(rightGuide, .bottom, .equal, u2, .bottom)

        let u3 = UIView()
        u3.translatesAutoresizingMaskIntoConstraints = false
        u3.backgroundColor = .yellow
        view.addSubview(u3)

        // set size
        UIView.wtConstraint(on: .width,  u3, .equal, 80)
        UIView.wtConstraint(on: .height, u3, .equal, 80)

        // center it
        u3.wtCenterInSuperview()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.showLayoutGuides(color: .white)
    }

}

