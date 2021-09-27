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
        
        guard let sourceImageData = arguments["sourceImage"] as? FlutterStandardTypedData, let sourceImage = UIImage(data: sourceImageData.data), let updatedImage = sourceImage.updateImageOrientationUpSide(), let filtersJSON = arguments["filters"] as? [[String: Any]] else {
            result(nil)
            return
        }
                
        let operationGroup = OperationGroup()
        
        var filters: [BasicOperation] = []
        
        for dic in filtersJSON {
            let name = dic["name"] as? String ?? ""
            let data = dic["data"] as? [String: Any] ?? [:]
            if(name == "GPUImageLookupFilter") {
                let lookupImageData = Data(data["filterImage"] as? [UInt8] ?? [])
                guard let lookupImage = UIImage(data: lookupImageData) else {
                    break
                }
                let lookupImageSource = PictureInput(image: lookupImage)
                
                let lookupFilter = LookupFilter()
                lookupFilter.lookupImage = lookupImageSource
                filters.append(lookupFilter)

               
            }else if(name == "BrightnessAdjustment"){
                var brightnessAdj:BrightnessAdjustment!
                let value = data["value"] as?Float  ?? 0.0
                brightnessAdj = BrightnessAdjustment()
                brightnessAdj.brightness = value
                filters.append(brightnessAdj)
              
            }else if(name == "ExposureAdjustment"){
                var exposureAdj:ExposureAdjustment!
                let value = data["value"] as?Float  ?? 0.0
                exposureAdj = ExposureAdjustment()
                exposureAdj.exposure = value
                filters.append(exposureAdj)
            }else if(name == "ContrastAdjustment"){
                var contrastAdj:ContrastAdjustment!
                let value = data["value"] as?Float  ?? 1.0
                contrastAdj = ContrastAdjustment()
                contrastAdj.contrast = value
                filters.append(contrastAdj)
            }else if(name == "SaturationAdjustment"){
                var saturationAdj:SaturationAdjustment!
                let value = data["value"] as?Float  ?? 1.0
                saturationAdj = SaturationAdjustment()
                saturationAdj.saturation = value
                filters.append(saturationAdj)
            }else if(name == "Vibrance"){
                var vibranceAdj:Vibrance!
                let value = data["value"] as?Float  ?? 0.0
                vibranceAdj = Vibrance()
                vibranceAdj.vibrance = value
                filters.append(vibranceAdj)
            }else if(name == "Haze"){
                var hazeAdj:Haze!
                let distance = data["distance"] as?Float  ?? 0.0
                let slope = data["slope"] as?Float  ?? 0.0
                hazeAdj = Haze()
                hazeAdj.distance = distance
                hazeAdj.slope = slope
                filters.append(hazeAdj)
            }else if(name == "OpacityAdjustment"){
                var opacityAdj:OpacityAdjustment!
                let value = data["opacity"] as?Float  ?? 0.0
                opacityAdj = OpacityAdjustment()
                opacityAdj.opacity = value
                filters.append(opacityAdj)
            }else if(name == "RGBAdjustment"){
                var rgbAdj:RGBAdjustment!
                let red = data["red"] as?Float  ?? 0.0
                let green = data["green"] as?Float  ?? 0.0
                let blue = data["blue"] as?Float  ?? 0.0
                rgbAdj = RGBAdjustment()
                rgbAdj.red = red
                rgbAdj.green = green
                rgbAdj.blue = blue
                filters.append(rgbAdj)
            }
        }
        operationGroup.configureGroup { input, output in
            for(index, filter) in filters.enumerated() {
                if index == 0 {
                    input.addTarget(filter)
                }
                if filters.count > 1 && index != 0 {
                    filters[index - 1].addTarget(filter)
                }
                if index == filters.count - 1 {
                    filter.addTarget(output)
                }
            }
        }
        
        let resultImage = updatedImage.filterWithOperation(operationGroup)
        
        guard let data = resultImage.jpegData(compressionQuality: 1.0) else {
            result(nil)
            return
        }
        
        result(FlutterStandardTypedData(bytes: data))
    }else {
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
