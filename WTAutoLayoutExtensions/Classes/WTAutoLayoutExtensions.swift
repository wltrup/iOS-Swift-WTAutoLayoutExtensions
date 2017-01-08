/*
 WTAutoLayoutExtensions.swift
 WTAutoLayoutExtensions

 Created by Wagner Truppel on 2017.01.07

 The MIT License (MIT)

 Copyright (c) 2017 Wagner Truppel.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

 When crediting me (Wagner Truppel) for this work, please use one
 of the following two suggested formats:

 Uses "WTAutoLayoutExtensions" by Wagner Truppel
 https://github.com/wltrup

 or

 WTAutoLayoutExtensions by Wagner Truppel
 https://github.com/wltrup
 */

import UIKit


// MARK: - Common auto-layout tasks

public extension UIView {

    /// Apple's standard distance between most UI elements, as a static property
    /// rather than a magic number.
    ///
    public static let standardValue: CGFloat = 8

    /// Sets up priorities for the view's content compression resistance along both
    /// axes to 999, which is almost required but gives a little breathing room in
    /// order to avoid potential conflicts.
    ///
    /// Obviously, these may need to be changed on a case-by-case basis but this
    /// instance method takes care of the most common scenario.
    ///
    public func setupCommonContentCompressionResistancePriorities() {
        setContentCompressionResistancePriority(999, for: .horizontal)
        setContentCompressionResistancePriority(999, for: .vertical)
    }

    /// Sets up priorities for the view's content hugging property along both axes to
    /// `UILayoutPriorityDefaultLow`.
    ///
    /// Obviously, these may need to be changed on a case-by-case basis but this
    /// instance method takes care of the most common scenario.
    ///
    public func setupCommonContentHuggingPriorities() {
        setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .horizontal)
        setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .vertical)
    }

    /// This method pins a view's edges to its superview's edges, with given
    /// edge insets. You have a choice whether to pin the view's margin or actual
    /// edges to the superview's margin or actual edges. You can also set a priority
    /// and whether or not the pin is active (both settings apply to all generated
    /// constraints).
    ///
    /// - Parameters:
    ///
    ///   - edgeInsets: Defaults to `UIEdgeInsets.zero`.
    ///
    ///   - useMargin: When `true`, the view's margins are pinned,
    ///                rather than its actual edges. Defaults to `true`.
    ///
    ///   - useSuperviewMargin: When `true`, the superview's margins are used,
    ///                rather than its actual edges. Defaults to `true`.
    ///
    ///   - priority: The priority applied to all 4 constraints needed to perform
    ///               this task. Defaults to `UILayoutPriorityRequired`.
    ///
    ///   - active: The active state applied to all 4 constraints needed to perform
    ///               this task. Defaults to `true`.
    ///
    func wtPinToSuperview(with edgeInsets: UIEdgeInsets = UIEdgeInsets.zero,
                          useMargin: Bool = true, useSuperviewMargin: Bool = true,
                          priority: UILayoutPriority = UILayoutPriorityRequired,
                          active: Bool = true) {

        guard superview != nil else {
            fatalError("Attempt to pin view (\(self)) to its non-existing superview.")
        }

        let tself: NSLayoutAttribute = (useMargin ? .topMargin    : .top)
        let lself: NSLayoutAttribute = (useMargin ? .leftMargin   : .left)
        let bself: NSLayoutAttribute = (useMargin ? .bottomMargin : .bottom)
        let rself: NSLayoutAttribute = (useMargin ? .rightMargin  : .right)

        let tsuper: NSLayoutAttribute = (useSuperviewMargin ? .topMargin    : .top)
        let lsuper: NSLayoutAttribute = (useSuperviewMargin ? .leftMargin   : .left)
        let bsuper: NSLayoutAttribute = (useSuperviewMargin ? .bottomMargin : .bottom)
        let rsuper: NSLayoutAttribute = (useSuperviewMargin ? .rightMargin  : .right)

        UIView.wtConstraint(self, tself, .equal, superview!, tsuper,
                            plus:  edgeInsets.top, priority: priority, active: active)

        UIView.wtConstraint(self, lself, .equal, superview!, lsuper,
                            plus:  edgeInsets.left, priority: priority, active: active)

        UIView.wtConstraint(self, bself, .equal, superview!, bsuper,
                            plus: -edgeInsets.bottom, priority: priority, active: active)

        UIView.wtConstraint(self, rself, .equal, superview!, rsuper,
                            plus: -edgeInsets.right, priority: priority, active: active)

    }

    /// This method centers a view in its superview. You have a choice whether to
    /// pin the view's center-in-margin or its actual center to the superview's
    /// center-in-margin or its actual center. You can also set a priority and
    /// whether or not the constraints are active (both settings apply to the two
    /// generated constraints).
    ///
    /// - Parameters:
    ///
    ///   - useMargin: When `true`, the view's center-in-margin is used,
    ///                rather than its actual center. Defaults to `true`.
    ///
    ///   - useSuperviewMargin: When `true`, the superview's center-in-margin is used,
    ///                rather than its actual center. Defaults to `true`.
    ///
    ///   - priority: The priority applied to both constraints needed to perform
    ///               this task. Defaults to `UILayoutPriorityRequired`.
    ///
    ///   - active: The active state applied to both constraints needed to perform
    ///               this task. Defaults to `true`.
    ///
    func wtCenterInSuperview(useMargin: Bool = true, useSuperviewMargin: Bool = true,
                             priority: UILayoutPriority = UILayoutPriorityRequired,
                             active: Bool = true) {

        guard superview != nil else {
            fatalError("Attempt to center view (\(self)) in its non-existing superview.")
        }

        let xself: NSLayoutAttribute = (useMargin ? .centerXWithinMargins : .centerX)
        let yself: NSLayoutAttribute = (useMargin ? .centerYWithinMargins : .centerY)

        let xsuper: NSLayoutAttribute = (useSuperviewMargin ? .centerXWithinMargins : .centerX)
        let ysuper: NSLayoutAttribute = (useSuperviewMargin ? .centerYWithinMargins : .centerY)

        UIView.wtConstraint(self, xself, .equal, superview!, xsuper,
                            priority: priority, active: active)

        UIView.wtConstraint(self, yself, .equal, superview!, ysuper,
                            priority: priority, active: active)

    }

}


// MARK: - Constraining the width or height of a single view or layout guide

public extension UIView {

    /// This method creates and returns a layout constraint for the **width**
    /// or the **height** of a view or layout guide in a form that is easy to
    /// read and understand.
    ///
    /// The default priority is `UILayoutPriorityRequired`.
    /// The default value of `active` is `true`.
    ///
    /// The return value can be ignored without generating a compiler warning.
    ///
    @discardableResult
    public static func wtConstraint(on attribute: NSLayoutAttribute,
                                    _ item: WTAutoLayoutExtensionsAware,
                                    _ relation: NSLayoutRelation,
                                    _ constant: CGFloat,
                                    priority: UILayoutPriority = UILayoutPriorityRequired,
                                    active: Bool = true) -> NSLayoutConstraint {

        let anchorType = item.anchorType(for: attribute)

        guard anchorType.isDimension else {
            fatalError("Invalid attribute (\(attribute))")
        }

        return wtConstraint(on: anchorType.dimensionAnchor!, relation, constant: constant,
                            priority: priority, active: active)

    }

    /// This method creates and returns a layout constraint for the **aspect ratio**
    /// (width divided by height) of a view or layout guide, in a form that is easy
    /// to read and understand.
    ///
    /// The default priority is `UILayoutPriorityRequired`.
    /// The default value of `active` is `true`.
    ///
    /// The return value can be ignored without generating a compiler warning.
    ///
    @discardableResult
    public static func wtAspectRatioConstraint(on item: WTAutoLayoutExtensionsAware,
                                               _ relation: NSLayoutRelation,
                                               _ ratio: CGFloat,
                                               priority: UILayoutPriority = UILayoutPriorityRequired,
                                               active: Bool = true) -> NSLayoutConstraint {

        return wtConstraint(item.widthAnchor, relation, item.heightAnchor,
                            times: ratio, priority: priority, active: active)

    }

}


// MARK: - Constraining corresponding size attributes of views and/or layout guides

public extension UIView {

    /// This method creates and returns a layout constraint between the **widths**
    /// or **heights** of two views, two layout guides, or a view and a layout guide
    /// (in either order), in a form that is easy to read and understand.
    ///
    /// The default value of `multiplier` is 1.
    /// The default value of `constant` is 0.
    /// The default priority is `UILayoutPriorityRequired`.
    /// The default value of `active` is `true`.
    ///
    /// The return value can be ignored without generating a compiler warning.
    ///
    @discardableResult
    public static func wtConstraint(on attribute: NSLayoutAttribute,
                                    _ item1: WTAutoLayoutExtensionsAware,
                                    _ relation: NSLayoutRelation,
                                    _ item2: WTAutoLayoutExtensionsAware,
                                    times multiplier: CGFloat = 1,
                                    plus constant: CGFloat = 0,
                                    priority: UILayoutPriority = UILayoutPriorityRequired,
                                    active: Bool = true) -> NSLayoutConstraint {

        let anchor1Type = item1.anchorType(for: attribute)
        let anchor2Type = item2.anchorType(for: attribute)

        guard anchor1Type.isDimension else {
            fatalError("Invalid attribute (\(attribute))")
        }

        guard !item1.isEqualTo(item2) else {
            fatalError("Attempt to set a width or height constraint between an instance and itself")
        }

        return wtConstraint(anchor1Type.dimensionAnchor!, relation,
                            anchor2Type.dimensionAnchor!, times: multiplier, plus: constant,
                            priority: priority, active: active)

    }

}


// MARK: - Constraining compatible positional attributes of views and/or layout guides

public extension UIView {

    /// This method creates and returns a layout constraint to align two views,
    /// two layout guides, or a view and a layout guide (in either order) on
    /// **compatible positional attributes**, in a form that is easy to read and
    /// understand.
    ///
    /// The default value of `constant` is 0.
    /// The default priority is `UILayoutPriorityRequired`.
    /// The default value of `active` is `true`.
    ///
    /// The return value can be ignored without generating a compiler warning.
    ///
    @discardableResult
    public static func wtConstraint(_ item1: WTAutoLayoutExtensionsAware,
                                    _ attribute1: NSLayoutAttribute,
                                    _ relation: NSLayoutRelation,
                                    _ item2: WTAutoLayoutExtensionsAware,
                                    _ attribute2: NSLayoutAttribute,
                                    plus constant: CGFloat = 0,
                                    priority: UILayoutPriority = UILayoutPriorityRequired,
                                    active: Bool = true) -> NSLayoutConstraint {

        let anchor1Type = item1.anchorType(for: attribute1)
        let anchor2Type = item2.anchorType(for: attribute2)

        guard anchor1Type.isXAxis || anchor1Type.isYAxis else {
            fatalError("Invalid attribute (\(attribute1))")
        }

        guard anchor1Type.sameType(as: anchor2Type) else {
            fatalError("Incompatible attributes (\(attribute1), \(attribute2))")
        }

        if anchor1Type.isXAxis {
            return wtConstraint(anchor1Type.xAnchor!, relation,
                                anchor2Type.xAnchor!, plus: constant,
                                priority: priority, active: active)
        }
        else {
            return wtConstraint(anchor1Type.yAnchor!, relation,
                                anchor2Type.yAnchor!, plus: constant,
                                priority: priority, active: active)
        }

    }

}


// MARK: - Horizontally arranging views and/or layout guides with respect to each other

public extension UIView {

    /// This method creates and returns a layout constraint to arrange two views,
    /// two layout guides, or a view and a layout guide (in either order) along
    /// the **horizontal** direction, in a form that is easy to read and understand.
    ///
    /// The default value of `constant` is 0.
    /// The default priority is `UILayoutPriorityRequired`.
    /// The default value of `active` is `true`.
    ///
    /// The return value can be ignored without generating a compiler warning.
    ///
    @discardableResult
    public static func wtConstraint(_ item1: WTAutoLayoutExtensionsAware,
                                    leading item2: WTAutoLayoutExtensionsAware,
                                    offset relation: NSLayoutRelation,
                                    _ constant: CGFloat,
                                    priority: UILayoutPriority = UILayoutPriorityRequired,
                                    active: Bool = true) -> NSLayoutConstraint {

        return wtConstraint(item2, trailing: item1, offset: relation, constant,
                            priority: priority, active: active)

    }

    /// This method creates and returns a layout constraint to arrange two views,
    /// two layout guides, or a view and a layout guide (in either order) along
    /// the **horizontal** direction, in a form that is easy to read and understand.
    ///
    /// The default value of `constant` is 0.
    /// The default priority is `UILayoutPriorityRequired`.
    /// The default value of `active` is `true`.
    ///
    /// The return value can be ignored without generating a compiler warning.
    ///
    @discardableResult
    public static func wtConstraint(_ item1: WTAutoLayoutExtensionsAware,
                                    trailing item2: WTAutoLayoutExtensionsAware,
                                    offset relation: NSLayoutRelation,
                                    _ constant: CGFloat,
                                    priority: UILayoutPriority = UILayoutPriorityRequired,
                                    active: Bool = true) -> NSLayoutConstraint {

        return wtConstraint(item1, .leading, relation, item2, .trailing,
                            plus: constant, priority: priority, active: active)

    }

}


// MARK: - Vertically arranging views and/or layout guides with respect to each other

public extension UIView {

    /// This method creates and returns a layout constraint to arrange two views,
    /// two layout guides, or a view and a layout guide (in either order) along
    /// the **vertical** direction, in a form that is easy to read and understand.
    ///
    /// The default value of `constant` is 0.
    /// The default priority is `UILayoutPriorityRequired`.
    /// The default value of `active` is `true`.
    ///
    /// The return value can be ignored without generating a compiler warning.
    ///
    @discardableResult
    public static func wtConstraint(_ item1: WTAutoLayoutExtensionsAware,
                                    above item2: WTAutoLayoutExtensionsAware,
                                    offset relation: NSLayoutRelation,
                                    _ constant: CGFloat,
                                    priority: UILayoutPriority = UILayoutPriorityRequired,
                                    active: Bool = true) -> NSLayoutConstraint {

        return wtConstraint(item2, below: item1, offset: relation, constant,
                            priority: priority, active: active)

    }

    /// This method creates and returns a layout constraint to arrange two views,
    /// two layout guides, or a view and a layout guide (in either order) along
    /// the **vertical** direction, in a form that is easy to read and understand.
    ///
    /// The default value of `constant` is 0.
    /// The default priority is `UILayoutPriorityRequired`.
    /// The default value of `active` is `true`.
    ///
    /// The return value can be ignored without generating a compiler warning.
    ///
    @discardableResult
    public static func wtConstraint(_ item1: WTAutoLayoutExtensionsAware,
                                    below item2: WTAutoLayoutExtensionsAware,
                                    offset relation: NSLayoutRelation,
                                    _ constant: CGFloat,
                                    priority: UILayoutPriority = UILayoutPriorityRequired,
                                    active: Bool = true) -> NSLayoutConstraint {

        return wtConstraint(item1, .top, relation, item2, .bottom,
                            plus: constant, priority: priority, active: active)

    }

}


// MARK: - Constraining anchors directly

public extension UIView {

    /// For the rare situation where the API defined above isn't sufficient, this
    /// method lets you directly create a constraint on a dimensional **anchor**.
    ///
    /// The default priority is `UILayoutPriorityRequired`.
    /// The default value of `active` is `true`.
    ///
    /// The return value can be ignored without generating a compiler warning.
    ///
    @discardableResult
    public static func wtConstraint(on dimensionalAnchor: NSLayoutDimension,
                                    _ relation: NSLayoutRelation,
                                    constant: CGFloat,
                                    priority: UILayoutPriority = UILayoutPriorityRequired,
                                    active: Bool = true) -> NSLayoutConstraint {

        let c: NSLayoutConstraint
        switch relation {
        case .equal:
            c = dimensionalAnchor.constraint(equalToConstant: constant)
        case .greaterThanOrEqual:
            c = dimensionalAnchor.constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual:
            c = dimensionalAnchor.constraint(lessThanOrEqualToConstant: constant)
        }
        c.priority = priority
        c.isActive = active
        return c

    }

    /// For the rare situation where the API defined above isn't sufficient, this
    /// method lets you directly create a constraint on a pair of dimensional **anchors**.
    ///
    /// The default priority is `UILayoutPriorityRequired`.
    /// The default value of `active` is `true`.
    ///
    /// The return value can be ignored without generating a compiler warning.
    ///
    @discardableResult
    public static func wtConstraint(_ dimensionalAnchor1: NSLayoutDimension,
                                    _ relation: NSLayoutRelation,
                                    _ dimensionalAnchor2: NSLayoutDimension,
                                    times multiplier: CGFloat = 1,
                                    plus constant: CGFloat = 0,
                                    priority: UILayoutPriority = UILayoutPriorityRequired,
                                    active: Bool = true) -> NSLayoutConstraint {

        let c: NSLayoutConstraint
        switch relation {
        case .equal:
            c = dimensionalAnchor1.constraint(equalTo: dimensionalAnchor2,
                                              multiplier: multiplier,
                                              constant: constant)
        case .greaterThanOrEqual:
            c = dimensionalAnchor1.constraint(greaterThanOrEqualTo: dimensionalAnchor2,
                                              multiplier: multiplier,
                                              constant: constant)
        case .lessThanOrEqual:
            c = dimensionalAnchor1.constraint(lessThanOrEqualTo: dimensionalAnchor2,
                                              multiplier: multiplier,
                                              constant: constant)
        }
        c.priority = priority
        c.isActive = active
        return c

    }

    /// For the rare situation where the API defined above isn't sufficient, this
    /// method lets you directly create a constraint on a pair of positional **anchors**.
    ///
    /// The default priority is `UILayoutPriorityRequired`.
    /// The default value of `active` is `true`.
    ///
    /// The return value can be ignored without generating a compiler warning.
    ///
    @discardableResult
    public static func wtConstraint<T>(_ positionalAnchor1: NSLayoutAnchor<T>,
                                    _ relation: NSLayoutRelation,
                                    _ positionalAnchor2: NSLayoutAnchor<T>,
                                    plus constant: CGFloat = 0,
                                    priority: UILayoutPriority = UILayoutPriorityRequired,
                                    active: Bool = true) -> NSLayoutConstraint {

        let c: NSLayoutConstraint
        switch relation {
        case .equal:
            c = positionalAnchor1.constraint(equalTo: positionalAnchor2,
                                             constant: constant)
        case .greaterThanOrEqual:
            c = positionalAnchor1.constraint(greaterThanOrEqualTo: positionalAnchor2,
                                             constant: constant)
        case .lessThanOrEqual:
            c = positionalAnchor1.constraint(lessThanOrEqualTo: positionalAnchor2,
                                             constant: constant)
        }
        c.priority = priority
        c.isActive = active
        return c

    }

}


// MARK: - Showing layout guides

public extension UIView {

    /// This method causes the layout guides of the recipient to be displayed as
    /// rectangles of "marching ants" with the given color. Call it on a view, after
    /// the view has been laid out (say, in viewWillAppear: or viewDidAppear:).
    ///
    /// Adapted from
    /// https://www.captechconsulting.com/blogs/uilayoutguide--auto-layouts-invisible-helpers
    ///
    public func showLayoutGuides(color: UIColor = .red) {

        // recurse into subviews to show layout guides
        for sub in subviews {
            sub.showLayoutGuides()
        }

        // bail out if the view has no sublayers
        guard let verifiedSubLayers = self.layer.sublayers else { return }

        // clean up any old display layers
        for layer in verifiedSubLayers {
            if layer is LayoutGuideDisplayLayer {
                layer.removeFromSuperlayer()
            }
        }

        // add new display layers
        for guide in self.layoutGuides {
            let l = LayoutGuideDisplayLayer(guide: guide, color: color)
            self.layer.addSublayer(l)
        }
    }

}


/// Adapted from
/// https://www.captechconsulting.com/blogs/uilayoutguide--auto-layouts-invisible-helpers
///
public class LayoutGuideDisplayLayer: CAShapeLayer {

    init(guide: UILayoutGuide, color: UIColor = .red) {

        super.init()

        self.path = UIBezierPath(rect: guide.layoutFrame).cgPath
        self.strokeColor = color.cgColor
        self.lineWidth = 1
        self.lineDashPattern = [2, 2, 2, 2]
        self.fillColor = UIColor.clear.cgColor

        // animate the dashed line
        let anim = CABasicAnimation(keyPath: "lineDashPhase")
        anim.duration = 0.75
        anim.repeatCount = Float.infinity
        anim.fromValue = 0
        anim.toValue = 3
        self.add(anim, forKey: "lineDashPhase")

    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: - WTAutoLayoutExtensionsAware magic from here on

public enum AnchorType {

    case xAxis(NSLayoutXAxisAnchor)
    case yAxis(NSLayoutYAxisAnchor)
    case dimension(NSLayoutDimension)
    case none

    func sameType(as other: AnchorType) -> Bool {
        switch (self, other) {
        case (.xAxis(_), .xAxis(_)):
            return true
        case (.yAxis(_), .yAxis(_)):
            return true
        case (.dimension(_), .dimension(_)):
            return true
        case (.none, .none):
            return true
        default:
            return false
        }
    }

    var isXAxis: Bool {
        switch self {
        case .xAxis(_):
            return true
        default:
            return false
        }
    }

    var xAnchor: NSLayoutXAxisAnchor? {
        switch self {
        case .xAxis(let anchor):
            return anchor
        default:
            return nil
        }
    }

    var isYAxis: Bool {
        switch self {
        case .yAxis(_):
            return true
        default:
            return false
        }
    }

    var yAnchor: NSLayoutYAxisAnchor? {
        switch self {
        case .yAxis(let anchor):
            return anchor
        default:
            return nil
        }
    }

    var isDimension: Bool {
        switch self {
        case .dimension(_):
            return true
        default:
            return false
        }
    }

    var dimensionAnchor: NSLayoutDimension? {
        switch self {
        case .dimension(let anchor):
            return anchor
        default:
            return nil
        }
    }

}


public protocol WTAutoLayoutExtensionsAware {

    var  widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }

    func anchorType(for attribute: NSLayoutAttribute) -> AnchorType

}


extension WTAutoLayoutExtensionsAware {

    func isEqualTo(_ other: WTAutoLayoutExtensionsAware) -> Bool {
        return false
    }

}


extension WTAutoLayoutExtensionsAware where Self: Equatable {

    func isEqualTo(_ other: WTAutoLayoutExtensionsAware) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }

}


extension UIView: WTAutoLayoutExtensionsAware {}

extension WTAutoLayoutExtensionsAware where Self: UIView {

    public func anchorType(for attribute: NSLayoutAttribute) -> AnchorType {
        switch attribute {
        case .centerX:
            return .xAxis(centerXAnchor)
        case .centerXWithinMargins:
            return .xAxis(layoutMarginsGuide.centerXAnchor)
        case .leading:
            return .xAxis(leadingAnchor)
        case .leadingMargin:
            return .xAxis(layoutMarginsGuide.leadingAnchor)
        case .left:
            return .xAxis(leftAnchor)
        case .leftMargin:
            return .xAxis(layoutMarginsGuide.leftAnchor)
        case .right:
            return .xAxis(rightAnchor)
        case .rightMargin:
            return .xAxis(layoutMarginsGuide.rightAnchor)
        case .trailing:
            return .xAxis(trailingAnchor)
        case .trailingMargin:
            return .xAxis(layoutMarginsGuide.trailingAnchor)
        case .top:
            return .yAxis(topAnchor)
        case .bottom:
            return .yAxis(bottomAnchor)
        case .centerY:
            return .yAxis(centerYAnchor)
        case .lastBaseline:
            return .yAxis(lastBaselineAnchor)
        case .firstBaseline:
            return .yAxis(firstBaselineAnchor)
        case .topMargin:
            return .yAxis(layoutMarginsGuide.topAnchor)
        case .bottomMargin:
            return .yAxis(layoutMarginsGuide.bottomAnchor)
        case .centerYWithinMargins:
            return .yAxis(layoutMarginsGuide.centerYAnchor)
        case .width:
            return .dimension(widthAnchor)
        case .height:
            return .dimension(heightAnchor)
        default:
            return .none
        }
    }

}


extension UILayoutGuide: WTAutoLayoutExtensionsAware {}

extension WTAutoLayoutExtensionsAware where Self: UILayoutGuide {

    public func anchorType(for attribute: NSLayoutAttribute) -> AnchorType {
        switch attribute {
        case .centerX:
            return .xAxis(centerXAnchor)
        case .leading:
            return .xAxis(leadingAnchor)
        case .left:
            return .xAxis(leftAnchor)
        case .right:
            return .xAxis(rightAnchor)
        case .trailing:
            return .xAxis(trailingAnchor)
        case .top:
            return .yAxis(topAnchor)
        case .bottom:
            return .yAxis(bottomAnchor)
        case .centerY:
            return .yAxis(centerYAnchor)
        case .width:
            return .dimension(widthAnchor)
        case .height:
            return .dimension(heightAnchor)
        default:
            return .none
        }
    }
    
}

