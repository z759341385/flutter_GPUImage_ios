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
        
        guard let sourceImageData = arguments["sourceImage"] as? FlutterStandardTypedData else{
            result(nil)
            return
        }
        guard let sourceImage = UIImage(data: sourceImageData.data) else{
            return
        }
       let updatedImage = sourceImage
//        guard let updatedImage = sourceImage.updateImageOrientationUpSide() else{
//            return
//        }
        guard let filtersJSON = arguments["filters"] as? [[String: Any]] else {
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

                do{
                    let lookupImageSource:PictureInput
                    try lookupImageSource = PictureInput(image: lookupImage)
                    let lookupFilter = LookupFilter()
                    lookupFilter.lookupImage = lookupImageSource
                    filters.append(lookupFilter)
                }catch{}
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
            }else if(name == "HighlightsAndShadows"){
                var highlightsAndShadows:HighlightsAndShadows
                let shadows = data["shadows"] as?Float  ?? 0.0
                let highlights = data["highlights"] as?Float  ?? 0.0
                highlightsAndShadows = HighlightsAndShadows()
                highlightsAndShadows.shadows = shadows
                highlightsAndShadows.highlights = highlights
                filters.append(highlightsAndShadows)
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
            }else if(name == "Vignette"){
                var vignette:Vignette!
                let position_x = data["position_x"] as?Float ?? 0.5
                let position_y = data["position_y"] as?Float ?? 0.5
                let color_red = data["color_red"] as?Float ?? 0.0
                let color_green = data["color_green"] as?Float ?? 0.0
                let color_blue = data["color_blue"] as?Float ?? 0.0
                let start = data["start"] as?Float ?? 0.0
                let end = data["end"] as?Float ?? 0.0

                vignette = Vignette()
                vignette.center = Position(position_x,position_y)
                vignette.color = Color(red:color_red,green:color_green,blue:color_blue)
                vignette.start = start
                vignette.end = end
                filters.append(vignette)
            }else if(name == "GaussianBlur"){
                var gaussianBlur:GaussianBlur!
                let blurRadiusInPixels = data["blurRadiusInPixels"] as?Float  ?? 0.0
                gaussianBlur = GaussianBlur()
                gaussianBlur.blurRadiusInPixels = blurRadiusInPixels
                filters.append(gaussianBlur)
            }else if(name == "OverlayBlend"){
                let blendImageData = Data(data["blendImage"] as? [UInt8] ?? [])
                guard let blendImage = UIImage(data: blendImageData) else { continue }
                UIGraphicsBeginImageContextWithOptions(CGSize(width: blendImage.size.width, height: blendImage.size.height),
                        false, 1)
                blendImage.draw(in: CGRect(origin: .zero, size: blendImage.size))
                guard let fixedBlendImage = UIGraphicsGetImageFromCurrentImageContext() else { continue }
                UIGraphicsEndImageContext()
                do{
                    let blendImageSource:PictureInput
                    try blendImageSource = PictureInput(image: fixedBlendImage)
                    let filter = OverlayBlend()
                    blendImageSource.addTarget(filter)
                    blendImageSource.processImage()
                    filters.append(filter)
                }catch{
                    print(error)
                }


            }else if(name == "LightenBlend"){
                let blendImageData = Data(data["blendImage"] as? [UInt8] ?? [])
                guard let blendImage = UIImage(data: blendImageData) else {
                    continue
                }
                do{
                    let blendImageSource:PictureInput
                    try blendImageSource = PictureInput(image: blendImage)
                    let filter = LightenBlend()
                    blendImageSource.addTarget(filter)
                    blendImageSource.processImage()
                    filters.append(filter)
                }catch{
                    print(error)

                }
            }else if(name == "SubtractBlend"){
                let blendImageData = Data(data["blendImage"] as? [UInt8] ?? [])
                guard let blendImage = UIImage(data: blendImageData) else {
                    continue
                }
                do{
                    let blendImageSource: PictureInput
                         try blendImageSource = PictureInput(image: blendImage)
                         let filter = SubtractBlend()
                         blendImageSource.addTarget(filter)
                         blendImageSource.processImage()
                         filters.append(filter)
                }catch{

                }

            }else if(name == "ScreenBlend"){
                let blendImageData = Data(data["blendImage"] as? [UInt8] ?? [])
                guard let blendImage = UIImage(data: blendImageData) else {
                    continue
                }

                do{
                    let blendImageSource:PictureInput
                   try blendImageSource = PictureInput(image: blendImage)
                    let filter = ScreenBlend()
                    blendImageSource.addTarget(filter)
                    blendImageSource.processImage()
                    filters.append(filter)
                }catch{}

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

        do{
            let resultImage:PlatformImageType?
            try resultImage = updatedImage.filterWithOperation(operationGroup)
            guard let data = resultImage?.jpegData(compressionQuality: 1.0) else {
                result(nil)
                return
            }
            result(FlutterStandardTypedData(bytes: data))

        }catch{

        }


    }else if(call.method == "testMethod"){
     
    }else {
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
