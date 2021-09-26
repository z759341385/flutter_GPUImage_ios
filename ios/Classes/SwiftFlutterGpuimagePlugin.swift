import Flutter
import UIKit
import BBMetalImage

public class SwiftFlutterGpuimagePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_gpuimage", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterGpuimagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    let arguments = call.arguments as? [String: Any] ?? [:]
    
    if call.method == "progressImage" {
        
        guard let sourceImageData = arguments["sourceImage"] as? FlutterStandardTypedData, let sourceImage = UIImage(data: sourceImageData.data), let updatedImage = sourceImage.updateImageOrientationUpSide(), let filtersJSON = arguments["filters"] as? [[String: Any]] else {
            result(nil)
            return
        }
        
        var targetImage = updatedImage
        
        for dic in filtersJSON {
            let name = dic["name"] as? String ?? ""
            let data = dic["data"] as? [String: Any] ?? [:]
            if(name == "GPUImageLookupFilter") {
                let lookupImageData = Data(data["filterImage"] as? [UInt8] ?? [])
                guard let metalTexture = lookupImageData.bb_metalTexture else {
                    continue
                }
                guard let resultImage = BBMetalLookupFilter(lookupTable: metalTexture).filteredImage(with: targetImage) else {
                    continue
                }
                targetImage = resultImage
            }
        }
        
//        operationGroup.configureGroup { input, output in
//            for(index, filter) in filters.enumerated() {
//                if index == 0 {
//                    input.addTarget(filter)
//                }
//                if filters.count > 1 {
//                    filters[index - 1].addTarget(filter)
//                }
//                if index == filters.count - 1 {
//                    filter.addTarget(output)
//                }
//            }
//        }
        
//        let resultImage = updatedImage.filterWithOperation(operationGroup)
        
        guard let data = targetImage.jpegData(compressionQuality: 1.0) else {
            result(nil)
            return
        }
        
        result(FlutterStandardTypedData(bytes: data))
    } else {
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
