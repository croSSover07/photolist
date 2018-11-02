package com.example.flutterapp

import android.app.WallpaperManager
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.Intent.FLAG_ACTIVITY_NEW_TASK
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import kotlinx.coroutines.experimental.GlobalScope
import kotlinx.coroutines.experimental.launch
import java.net.URL

class MainActivity() : FlutterActivity() {

    companion object {
        private const val CHANNEL = "flutter/app"
        private const val WALLPAPER_METHOD = "setWallByUrl"

        private const val INSTA_METHOD = "showInstaProfile"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { methodCall, result ->
            when(methodCall.method) {
                WALLPAPER_METHOD ->  setWallpaper(methodCall.arguments.toString(), this)
                INSTA_METHOD -> showInstaProfile(methodCall.arguments.toString())
            }
        }
    }

    private fun setWallpaper(url: String, context: Context) {
        val manager = WallpaperManager.getInstance(context)
        GlobalScope.launch {
            val bitmap = BitmapFactory.decodeStream(URL(url).openStream())

            val uriImage = MediaStore.Images.Media.insertImage(
                context.contentResolver, bitmap, Uri.parse(url).lastPathSegment, null
            ).let { Uri.parse(it) }
            val intent = manager.getCropAndSetWallpaperIntent(uriImage).setFlags(FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(intent)
        }
    }

    private fun showInstaProfile(userName: String) {
        try {
            val intent = Intent(Intent.ACTION_VIEW, Uri.parse("http://instagram.com/_u/$userName"))
            intent.setPackage("com.instagram.android")
            startActivity(intent)
        } catch (e: ActivityNotFoundException) {
            startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("http://instagram.com/$userName")))
        }
    }
}
