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
import android.graphics.Matrix
import android.media.ExifInterface
import jp.co.cyberagent.android.gpuimage.GPUImage
import jp.co.cyberagent.android.gpuimage.filter.GPUImageFilterGroup
import jp.co.cyberagent.android.gpuimage.filter.GPUImageLookupFilter
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream

class FlutterGpuimagePlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_gpuimage")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
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
                result.success(sourceImageData?.orientation()?.let {
                    gpuImage.bitmapWithFilterApplied.rotate(
                        it
                    )?.toByteArray()
                })
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

fun ByteArray.orientation(): Int {
    val stream = ByteArrayInputStream(this)
    val ei = ExifInterface(stream)
    return ei.getAttributeInt(
        ExifInterface.TAG_ORIENTATION,
        ExifInterface.ORIENTATION_UNDEFINED
    )
}

fun Bitmap.toByteArray(): ByteArray {
    ByteArrayOutputStream().apply {
        compress(Bitmap.CompressFormat.JPEG, 100, this)
        return toByteArray()
    }
}

private fun Bitmap.rotate(orientation: Int): Bitmap? {
    var angle = when (orientation) {
        ExifInterface.ORIENTATION_ROTATE_90 ->
            90f
        ExifInterface.ORIENTATION_ROTATE_180 ->
            180f

        ExifInterface.ORIENTATION_ROTATE_270 ->
            270f

        ExifInterface.ORIENTATION_NORMAL -> 0f
        else -> 0f
    }
    val matrix = Matrix()
    matrix.postRotate(angle)
    return Bitmap.createBitmap(this, 0, 0, this.width, this.height, matrix, true)
}
