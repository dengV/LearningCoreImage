# [fit] Learning CoreImage

## Guanshan Liu
### [@guanshanliu](https://twitter.com/guanshanliu/)

---

# Who Am I

- Working on TTPod for iOS at Alibaba Inc.
- Most time I do UI stuffs
- [@guanshanliu](https://twitter.com/guanshanliu/) on Twitter, not famous YET
- Email: guanshan.liu@gmail.com

---

# What is CoreImage

CoreImage is a powerful image processing framework that allow you to easily add awesome effects to still images and live video. It is built on top of OpenGL, and uses shaders to do image processing.

---

# What is CoreImage

- It uses GPU to process image data by default
- You can choose to use CPU as well
- Introduced in OS X 10.4, iOS 5
- You can create custom image kernels in iOS 8

---

# Overview

- **CIContext** It's where all image processing happens. Similar to CoreGraphics or OpenGL context.
- **CIImage** An image abstraction.
- **CIFilter** A filter takes one or more images as input, produces a CIImage object as output based on key-value pairs of input parameters.

---

# CIContext

- **GPU-based** Faster, but is limited to the hardware texture size of the GPU. Also it cannot continue to run if your app is in background.
- **CPU-based** Slower, but can handle any size and can continue to run in the background.

---

# CIImage

It can be created in many ways:

- Raw pixel data: NSData, CVPixelBufferRef, etc.
- Image data classes: UIImage, CGImageRef, etc.
- OpenGL textures

---

# CIFilter
## Builtin Filters

- **In Objective-C**

```objectivec
[CIFilter filterNamesInCategory:kCICategoryBuiltIn]
```

- **In Swift**

```swift
CIFilter.filterNamesInCategory(kCICategoryBuiltIn)
```

---

# CIFilter

Each filter has a dictionary containing filter's name, the kinds of input parameters the filters takes, the default and acceptable values, and its category.

---

# CIFilter

In Objective-C

```objectivec
NSArray *filters = [CIFilter filterNamesInCategory:kCICategoryBuiltIn]; 
for (NSString *filterName in filters) {
	CIFilter *fltr = [CIFilter filterWithName:filterName];
	NSLog(@"%@", [fltr attributes]); 
}
```

In Swift

```swift
let filterNames = CIFilter.filterNamesInCategory(kCICategoryBuiltIn) as [String]
for filterName in filterNames {
	let filter = CIFilter(name: filterName)
	println(filter.attributes())
}
```

---

# Demo 
# [fit] Sepia Tone Filter

---

# Auto-Enhancement

CIImage has a method *autoAdjustmentFilters* that returns an array of filters including red eye reduction, flesh tone, etc. 

You can use the array to apply a filter chain to an image.

---

# Demo
# [fit] Filter Chain

---

# Demo
# [fit] Custom Image Kernel

---

# Demo
# [fit] Live Video Filter

---

# Resources

- WWDC sessions
	1. 2011: 129, 422
	1. 2012: 510, 511
	1. 2013: 509
	1. 2014: 514, 515
- [Beginning Core Image in iOS 6](http://www.raywenderlich.com/22167/beginning-core-image-in-ios-6)

---

# [fit] Thank you!