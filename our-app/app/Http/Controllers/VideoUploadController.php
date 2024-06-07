<?php

namespace App\Http\Controllers;

use App\Events\readVideoChunks;
use App\Events\VideoChunkUploaded;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class VideoUploadController extends Controller
{
    //
    public function uploadChunk(Request $request)
    {
        if ($request->hasFile('chunk')) {
            $file = $request->file('chunk');
            $filename = $request->input('filename');
            $chunkNumber = $request->input('chunkNumber');

            // Define a unique temporary directory for this upload
            $tempDir = storage_path('images/' . $filename);

            // Create the temporary directory if it doesn't exist
            if (!is_dir($tempDir)) {
                mkdir($tempDir, 0777, true);
            }

            // Move the uploaded chunk to the temporary directory
            $file->move($tempDir, $chunkNumber);

            return response()->json(['status' => 'Chunk uploaded successfully!'], 200);
        }

        return response()->json(['status' => 'No chunk found!'], 400);
    }

    public function sendVideoChunks(Request $request)
{
    $videoName = $request->input('video_name');
    $videoPath = 'C:/Users/tayma_36c2fp3/Desktop/courses/jp/junior-project/our-app/storage/images'; // Adjust the path as needed
    $chunkSize = 1024 * 1024; // Adjust the chunk size as needed

    //$fileSize = File::size($videoPath);
    //$file = fopen($videoPath, 'rb');
    if (!File::exists($videoPath)) {
        return response()->json(['status' => 'Video not found'], 404);
    }
    //$chunks = array_diff(scandir($videoPath), ['.', '..']);
    $chunks = array_diff(scandir(storage_path('images/' . $videoName)), ['.', '..']);
    sort($chunks, SORT_NUMERIC);
    //return $chunks;
    // while (!feof($file)) {
    //     $chunk = fread($file, $chunkSize);
    //     event(new readVideoChunks($chunk, feof($file)));
    // }

    // fclose($file);
    foreach ($chunks as $chunk) {
        $chunkData = file_get_contents(storage_path('images/' . $videoName)."/{$chunk}");
        $encodedChunk = base64_encode($chunkData);
        //echo $encodedChunk.ob_get_length();
        event(new VideoChunkUploaded($encodedChunk,"joooo"));
    }

}
}
