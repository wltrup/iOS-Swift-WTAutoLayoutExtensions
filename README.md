# WTAutoLayoutExtensions

[![CI Status](http://img.shields.io/travis/wltrup/WTAutoLayoutExtensions.svg?style=flat)](https://travis-ci.org/wltrup/WTAutoLayoutExtensions)
[![Version](https://img.shields.io/cocoapods/v/WTAutoLayoutExtensions.svg?style=flat)](http://cocoapods.org/pods/WTAutoLayoutExtensions)
[![Platform](https://img.shields.io/cocoapods/p/WTAutoLayoutExtensions.svg?style=flat)](https://developer.apple.com)
[![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-8.2-blue.svg)](https://developer.apple.com/xcode)
[![License](https://img.shields.io/cocoapods/l/WTAutoLayoutExtensions.svg?style=flat)](http://cocoapods.org/pods/WTAutoLayoutExtensionsblob/master/LICENSE)

## What

**WTAutoLayoutExtensions** adds extensions to `UIView` and `UILayoutGuide` to make it simpler
and more natural to use layout guides, layout anchors, and the rest of the auto-layout machinery,
with a consistent API and very little code.

Here's the full set of API additions to `UIView`. Look up the full documentation in the source
file, for details:

```swift
public extension UIView {

    /// Apple's standard distance between most UI elements, as a static property. No magic numbers!
    static public let standardValue: CGFloat

    /// Sets up commonly used priorities for the view's content compression resistance.
    public func setupCommonContentCompressionResistancePriorities()

    /// Sets up commonly used priorities for the view's content hugging property.
    public func setupCommonContentHuggingPriorities()

    /// Pins a view's edges to its superview's edges.
    public func wtPinToSuperview(with edgeInsets: UIEdgeInsets,
                                 useMargin: Bool,
                                 useSuperviewMargin: Bool,
                                 priority: UILayoutPriority,
                                 active: Bool)

    /// Centers a view in its superview.
    public func wtCenterInSuperview(useMargin: Bool,
                                    useSuperviewMargin: Bool,
                                    priority: UILayoutPriority,
                                    active: Bool)

    /// Creates layout constraints for the **width** or the **height** of a view
    /// or layout guide.
    public static func wtConstraint(on attribute: NSLayoutAttribute,
                                    _ item: WTAutoLayoutExtensionsAware,
                                    _ relation: NSLayoutRelation,
                                    _ constant: CGFloat,
                                    priority: UILayoutPriority,
                                    active: Bool) -> NSLayoutConstraint

    /// Creates layout constraints for the **aspect ratio** (width divided by height)
    /// of a view or layout guide.
    public static func wtAspectRatioConstraint(on item: WTAutoLayoutExtensionsAware,
                                               _ relation: NSLayoutRelation,
                                               _ ratio: CGFloat,
                                               priority: UILayoutPriority,
                                               active: Bool) -> NSLayoutConstraint

    /// Creates layout constraints between the **widths** or **heights** of two views,
    /// two layout guides, or a view and a layout guide (in either order).
    public static func wtConstraint(on attribute: NSLayoutAttribute,
                                    _ item1: WTAutoLayoutExtensionsAware,
                                    _ relation: NSLayoutRelation,
                                    _ item2: WTAutoLayoutExtensionsAware,
                                    times multiplier: CGFloat,
                                    plus constant: CGFloat,
                                    priority: UILayoutPriority,
                                    active: Bool) -> NSLayoutConstraint

    /// Creates layout constraints to align two views, two layout guides, or a view
    /// and a layout guide (in either order) on **compatible positional attributes**.
    public static func wtConstraint(_ item1: WTAutoLayoutExtensionsAware,
                                    _ attribute1: NSLayoutAttribute,
                                    _ relation: NSLayoutRelation,
                                    _ item2: WTAutoLayoutExtensionsAware,
                                    _ attribute2: NSLayoutAttribute,
                                    plus constant: CGFloat,
                                    priority: UILayoutPriority,
                                    active: Bool) -> NSLayoutConstraint

    /// Creates layout constraints to arrange two views, two layout guides, or a view
    /// and a layout guide (in either order) along the **horizontal** direction.
    public static func wtConstraint(_ item1: WTAutoLayoutExtensionsAware,
                                    leading item2: WTAutoLayoutExtensionsAware,
                                    offset relation: NSLayoutRelation,
                                    _ constant: CGFloat,
                                    priority: UILayoutPriority,
                                    active: Bool) -> NSLayoutConstraint

    /// Creates layout constraints to arrange two views, two layout guides, or a view
    /// and a layout guide (in either order) along the **horizontal** direction.
    public static func wtConstraint(_ item1: WTAutoLayoutExtensionsAware,
                                    trailing item2: WTAutoLayoutExtensionsAware,
                                    offset relation: NSLayoutRelation,
                                    _ constant: CGFloat,
                                    priority: UILayoutPriority,
                                    active: Bool) -> NSLayoutConstraint

    /// Creates layout constraints to arrange two views, two layout guides, or a view
    /// and a layout guide (in either order) along the **vertical** direction.
    public static func wtConstraint(_ item1: WTAutoLayoutExtensionsAware,
                                    above item2: WTAutoLayoutExtensionsAware,
                                    offset relation: NSLayoutRelation,
                                    _ constant: CGFloat,
                                    priority: UILayoutPriority,
                                    active: Bool) -> NSLayoutConstraint

    /// Creates layout constraints to arrange two views, two layout guides, or a view
    /// and a layout guide (in either order) along the **vertical** direction.
    public static func wtConstraint(_ item1: WTAutoLayoutExtensionsAware,
                                    below item2: WTAutoLayoutExtensionsAware,
                                    offset relation: NSLayoutRelation,
                                    _ constant: CGFloat,
                                    priority: UILayoutPriority,
                                    active: Bool) -> NSLayoutConstraint

    /// For the rare situation where the API defined above isn't sufficient, this
    /// method lets you directly create a constraint on a dimensional **anchor**.
    public static func wtConstraint(on dimensionalAnchor: NSLayoutDimension,
                                    _ relation: NSLayoutRelation,
                                    constant: CGFloat,
                                    priority: UILayoutPriority,
                                    active: Bool) -> NSLayoutConstraint

    /// For the rare situation where the API defined above isn't sufficient, this
    /// method lets you directly create a constraint on a pair of dimensional **anchors**.
    public static func wtConstraint(_ dimensionalAnchor1: NSLayoutDimension,
                                    _ relation: NSLayoutRelation,
                                    _ dimensionalAnchor2: NSLayoutDimension,
                                    times multiplier: CGFloat,
                                    plus constant: CGFloat,
                                    priority: UILayoutPriority,
                                    active: Bool) -> NSLayoutConstraint

    /// For the rare situation where the API defined above isn't sufficient, this
    /// method lets you directly create a constraint on a pair of positional **anchors**.
    public static func wtConstraint<T>(_ positionalAnchor1: NSLayoutAnchor<T>,
                                    _ relation: NSLayoutRelation,
                                    _ positionalAnchor2: NSLayoutAnchor<T>,
                                    plus constant: CGFloat,
                                    priority: UILayoutPriority,
                                    active: Bool) -> NSLayoutConstraint

    /// This method causes the layout guides of the recipient to be displayed as
    /// rectangles of "marching ants" with the given color. Useful for debugging.
    /// See acknowledgement note below.
    public func showLayoutGuides(color: UIColor)

}
```

## Examples

The full API list above may look anything but simple and natural, but here are a few examples
of how you'd use it. These examples are taken directly from the attached example project:

```swift
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

        // set size
        UIView.wtConstraint(on: .width,  u3, .equal, 80)
        UIView.wtConstraint(on: .height, u3, .equal, 80)

        // center it
        u3.wtCenterInSuperview()
```

As you can see, and I hope will agree, the method invocations at the call site read
**very** naturally. The API is very consistent:

- All methods which return constraints are `static` functions of `UIView`
- Return values can be ignored without having to use `_ =`, if you'd like
- Methods which constrain a single item, or a single common attribute of two items, are named
  `wtConstraint(on ...)` (the only exception being the aspect ratio one), and the item
  or attribute in question appears as the first argument
- Those which constrain different attributes of two items are named without the `on`
- The choice of naming the methods with the `wt` prefix was deliberate, to future-proof
  against additions of similarly-named methods to `UIView` and also because Xcode's
  autocompletion will narrow down the list rather nicely once you've typed `wtc`
- Some methods support multipliers and/or constants and, when they do, their places in
  the method signatures are very natural, such as
  `UIView.wtConstraint(on: .height, u1, .equal, u2, times: 1.5, plus: 20)`
- Methods also support priorities and active/inactive states
- All defaults have sensible values
- You're not forced to use `.equal`. You can equally as easily write something like
  `UIView.wtConstraint(on: .width, u1, .greaterThanOrEqual, u2, times: 1.5, plus: 20)`
  or `UIView.wtConstraint(on: .width, u1, .lessThanOrEqual, u2)`

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Changelog

Changes to **WTAutoLayoutExtensions** are listed
[here](https://github.com/wltrup/iOS-Swift-WTAutoLayoutExtensions/blob/master/CHANGELOG.md).

## Requirements

**WTAutoLayoutExtensions** deploys only to `iOS 9.0` and above.

## Installation

**WTAutoLayoutExtensions** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WTAutoLayoutExtensions"
```

## Author

Wagner Truppel, trupwl@gmail.com

## License

**WTAutoLayoutExtensions** is available under the MIT license. See the LICENSE file for more info.

## Acknowledgement

`showLayoutGuides(color:)` and its supporting code is based on and adapted from work done by Jack Cox.
Check his [blog post](https://www.captechconsulting.com/blogs/uilayoutguide--auto-layouts-invisible-helpers) and [github repo](https://github.com/jack-cox-captech/LayoutGuideExamples).

