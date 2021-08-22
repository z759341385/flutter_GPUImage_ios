import Flutter
import UIKit
import GPUImage

public class SwiftFlutterGpuimagePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_gpuimage", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterGpuimagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    let arguments = call.arguments as? [String: Any] ?? [:]
    if call.method == "progressImage" {
        
        guard let sourceImageData = arguments["sourceImage"] as? FlutterStandardTypedData, let sourceImage = UIImage(data: sourceImageData.data), let sourceImageSource = GPUImagePicture(image: sourceImage), let filtersJSON = arguments["filters"] as? [[String: Any]] else {
            result(nil)
            return
        }
        
        let filterGroup = GPUImageFilterGroup()
        
        sourceImageSource.addTarget(filterGroup)
        
        for dic in filtersJSON {
            let name = dic["name"] as? String ?? ""
            let data = dic["data"] as? [String: Any] ?? [:]
            if(name == "GPUImageLookupFilter") {
                let lookupImageData = Data(data["filterImage"] as? [UInt8] ?? [])
                guard let lookupImage = UIImage(data: lookupImageData), let lookupImageSource = GPUImagePicture(image: lookupImage) else {
                    break
                }
                let lookupFilter = GPUImageLookupFilter()
                
                filterGroup.addFilter(lookupFilter)
                
                sourceImageSource.addTarget(lookupFilter)
                sourceImageSource.processImage()
                
                lookupImageSource.addTarget(lookupFilter)
                lookupImageSource.processImage()
                

            }
        }
        
        let filterCount = filterGroup.filterCount()
        
        
        if filterCount > 1 {
            for index in 1..<filterCount {
                let frontFilter = filterGroup.filter(at: index - 1)
                let filter = filterGroup.filter(at: index)
                frontFilter?.addTarget(filter)
            }
        }
        
        if filterCount > 0, let first = filterGroup.filter(at: 0) {
            filterGroup.initialFilters = [ first ]
        }
        
        if filterCount > 0, let last = filterGroup.filter(at: filterCount - 1) {
            filterGroup.terminalFilter = last
        }
        
        sourceImageSource.processImage()
        
        filterGroup.useNextFrameForImageCapture()
        
        guard let resultImage = filterGroup.imageFromCurrentFramebuffer(), let data = resultImage.jpegData(compressionQuality: 1.0) else {
            result(nil)
            return
        }
        
        result(FlutterStandardTypedData(bytes: data))
        
        
//
//        let lookupImageData = dic["lookupImage"] as? FlutterStandardTypedData
//        let lookupImageGP = GPUImagePicture(image: lookupImage)
//
        
//        let lookupFilter = GPUImageLookupFilter()
        
//        sourceImageGP.addTarget(lookupFilter)
//        lookupImageGP.addTarget(lookupFilter)
        
//        sourceImageGP.processImage()
//        lookupImageGP.processImage()
        
//        lookupFilter.useNextFrameForImageCapture()
//
//        guard let resultImage = lookupFilter.imageFromCurrentFramebuffer(), let data = resultImage.jpegData(compressionQuality: 1.0) else {
//            result(nil)
//            return
//        }
//
//        result(FlutterStandardTypedData(bytes: data))
    } else {
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
