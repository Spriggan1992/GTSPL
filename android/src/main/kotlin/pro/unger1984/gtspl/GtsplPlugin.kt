package pro.unger1984.gtspl

import android.content.Context
import android.os.StrictMode
import android.os.StrictMode.ThreadPolicy
import com.gainscha.gtspl_sdk.GTSPLWIFIActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.FileInputStream


/** GtsplPlugin */
class GtsplPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  var mGtsplWIFICmdTest: GTSPLWIFIActivity = GTSPLWIFIActivity()

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val policy = ThreadPolicy.Builder().permitAll().build()
    StrictMode.setThreadPolicy(policy)

    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "gtspl")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {

    when(call.method){
      "connect" -> {
        val arguments = call.arguments as HashMap<*,*>
        if (arguments.containsKey("ip") && arguments.containsKey("port")) {
          val ip = arguments["ip"] as String
          val port = arguments["port"] as String
          val isConnect: Boolean = mGtsplWIFICmdTest.GTSPL_openPort(ip, port.toInt())
          result.success(isConnect);
        } else {
          result.error("invalid_argument", "argument 'ip' and 'port' not found", null)
        }
      }

      "disconnect" -> {
        val isDisconnect: Boolean = mGtsplWIFICmdTest.GTSPL_closePort();
        result.success(isDisconnect);
      }

      "status" -> {
        val status: String = mGtsplWIFICmdTest.GTSPL_printersStatus(100);
        result.success(status);
      }

      "send_command" -> {
        val arguments = call.arguments as HashMap<*,*>
        if (arguments.containsKey("command")) {
           mGtsplWIFICmdTest.GTSPL_printLabel(1, 2, context)
          val template = arguments["command"] as String
          val res = mGtsplWIFICmdTest.sendToPrinter("template");
          result.success(res);
        }else {
          result.error("invalid_argument", "argument 'command' not found", null)
        }
      }

      "send_command_and_file" -> {
        val arguments = call.arguments as HashMap<*,*>
        if (arguments.containsKey("command") && arguments.containsKey("filepath")) {
          val fis = FileInputStream(arguments["filepath"] as String);
          val data = ByteArray(fis.available())
          val res = mGtsplWIFICmdTest.fileSendToPrinter(fis,arguments["command"] as String, data);
          result.success(res);
        }else {
          result.error("invalid_argument", "argument 'command' and 'filepath' not found", null)
        }
      }

      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
