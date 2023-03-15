package com.example.online_panchayat_flutter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class Activity : FlutterActivity(), PluginRegistry.PluginRegistrantCallback {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        // Register any plugins that your Flutter app will be using
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    override fun registerWith(registry: PluginRegistry) {
        // Register any plugins that your Flutter app will be using
       GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
