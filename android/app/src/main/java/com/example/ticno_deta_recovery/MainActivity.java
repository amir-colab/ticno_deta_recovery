import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import android.os.Environment;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.ticno_deta_recovery/files";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("getDeletedFiles")) {
                        List<HashMap<String, String>> files = getDeletedFiles();
                        result.success(files);
                    }
                }
            );
    }

    private List<HashMap<String, String>> getDeletedFiles() {
        File directory = Environment.getExternalStorageDirectory();
        List<HashMap<String, String>> deletedFiles = new ArrayList<>();
        scanDirectory(directory, deletedFiles);
        return deletedFiles;
    }

    private void scanDirectory(File dir, List<HashMap<String, String>> deletedFiles) {
        for (File file : dir.listFiles()) {
            if (file.isFile() && file.getName().contains(".deleted")) {
                HashMap<String, String> fileData = new HashMap<>();
                fileData.put("name", file.getName());
                fileData.put("path", file.getAbsolutePath());
                deletedFiles.add(fileData);
            } else if (file.isDirectory()) {
                scanDirectory(file, deletedFiles);
            }
        }
    }
}
