# FocusTvButton

Light wrapper of UIButton that allow extra customization for tvOS

![](art/preview.gif)

## Description

FocusTvButton allows the customization of UIButtons in tvOS, adding extra properties to customize layout attributes which are not customizable on UIButtons out of the box.

Custom properties:

- Focused background color
- Unfocused background color
- Corner radius
- Scale factor when focused
- Shadow radius when focused
- Shadow opacity when focused
- Shadow color
- Shadow offset when focused
- Duration of the focus animation
- Title color when focuses/unfocused

## Requirements

- tvOS 9.0+
- Xcode 7.3+

## Usage

FocusTvButton can be integrated both programatically or embedded in a xib file.

## Programatically

FocusTvButton is a subclass of UIButton, so it can be created and used as a regular UIButton.

```swift
let myButton = FocusTvButton()
myButton.focusedBackgroundColor = UIColor.redColor()
myButton.normalBackgroundColor = UIColor.whiteColor()
myButton.cornerRadius = 12.0
```

## Embedded in a xib or storyboard file

Due to the fact that FocusTvButton is a subclass of UIButton, the first step is to drag and drop a regular UIButton from the Object library to your view.

![](art/buttonObjectLibrary.png)

Then changes the value of "Custom Class" to "FocusTvButton", and changes the Button type to "Custom" to avoid the default focus behaviour.

![](art/buttonCustomClass.png) ![](art/buttonTypeCustom.png)

And that's all...

The custom properties can be configured directly on the Storyboard using IBInspectables.

![](art/ibinspectables.png)

## Installation

### Cocoapods

To integrate FocusTvButton into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
platform :tvos, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'FocusTvButton', :git => 'https://github.com/dcordero/FocusTvButton.git'
end
```

### Manually

If you prefer, you can also integrate FocusTvButton into your project manually, just copying FocusTvButton.swift to your project.

