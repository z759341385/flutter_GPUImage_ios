package com.swifter.flutter_gpuimage

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import jp.co.cyberagent.android.gpuimage.GPUImage
import jp.co.cyberagent.android.gpuimage.filter.GPUImageFilterGroup
import jp.co.cyberagent.android.gpuimage.filter.GPUImageLookupFilter
import java.io.ByteArrayOutputStream

class FlutterGpuimagePlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_gpuimage")
        channel.setMethodCallHandler(this)
        this.context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        val arguments = call.arguments as? Map<String, Any> ?: mapOf()
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "progressImage" -> {

                val sourceImageData = arguments["sourceImage"] as? ByteArray
                val sourceImageBitmap =
                    sourceImageData?.let { BitmapFactory.decodeByteArray(it, 0, it.size) }

                val filtersJSON = arguments["filters"] as? List<Map<String, Any>>
                if (filtersJSON == null) {
                    result.success(null)
                    return
                }

                val gpuImage = GPUImage(this.context)
                gpuImage.setImage(sourceImageBitmap)

                val gpuImageGroup = GPUImageFilterGroup()
                filtersJSON.forEach { it ->
                    val name = it["name"] as? String ?: ""
                    val data = it["data"] as? Map<String, Any> ?: mapOf()
                    if (name == "GPUImageLookupFilter") {

                        val lookupImageDataList = data["filterImage"] as? List<Int> ?: listOf()
                        var lookupImageData =
                            ByteArray(lookupImageDataList.size) { pos -> lookupImageDataList[pos].toByte() }
                        val lookupImageBitmap =
                            lookupImageData?.let { BitmapFactory.decodeByteArray(it, 0, it.size) }

                        val lookupFilter = GPUImageLookupFilter()
                        lookupFilter.bitmap = lookupImageBitmap

                        gpuImageGroup.addFilter(lookupFilter)
                    }
                }
                gpuImage.setFilter(gpuImageGroup)
                result.success(gpuImage.bitmapWithFilterApplied.toByteArray())
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

fun Bitmap.toByteArray(): ByteArray {
    ByteArrayOutputStream().apply {
        compress(Bitmap.CompressFormat.JPEG, 100, this)
        return toByteArray()
    }
}
