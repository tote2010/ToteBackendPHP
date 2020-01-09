<?php

class UploadHelper {

    public static function uploadJPGImage($file) {
        $path = dirname($_SERVER['SCRIPT_FILENAME']) . '/img/report/';
        // Undefined | Multiple Files | $_FILES Corruption Attack
        // If this request falls under any of them, treat it invalid.

        if (
                !isset($_FILES[$file]['error']) ||
                is_array($_FILES[$file]['error'])
        ) {
            return('Invalid parameters.');
        }
        // Check $_FILES['upfile']['error'] value.
        switch ($_FILES[$file]['error']) {
            case UPLOAD_ERR_OK:
                break;
            case UPLOAD_ERR_NO_FILE:
                return('No file sent.');
            case UPLOAD_ERR_INI_SIZE:
            case UPLOAD_ERR_FORM_SIZE:
                return('Exceeded filesize limit.');
            default:
                return('Unknown errors.');
        }

        // You should also check filesize here.
        if ($_FILES[$file]['size'] > 1000000) {
            return('Exceeded filesize limit.');
        }

        // DO NOT TRUST $_FILES['upfile']['mime'] VALUE !!
        // Check MIME Type by yourself.
        
        $finfo = new finfo(FILEINFO_MIME_TYPE);
        if (false === $ext = array_search(
                $finfo->file($_FILES[$file]['tmp_name']), 
                array(
                    'jpg' => 'image/jpeg',
                    //'png' => 'image/png',
                    //'gif' => 'image/gif',
                ), true
                )) {
            return('Invalid file format.');
        }
        
        // You should name it uniquely.
        // DO NOT USE $_FILES['upfile']['name'] WITHOUT ANY VALIDATION !!
        // On this example, obtain safe unique name from its binary data.
        if (!move_uploaded_file(
                        $_FILES[$file]['tmp_name'], $path . $_FILES[$file]['name'])) {
            return('Failed to move uploaded file.');
        }

        return "true";
    }

     public static function removeJPGImage($file) {
         $path = dirname($_SERVER['SCRIPT_FILENAME']) . '/img/report/';
         if($file){
             if(unlink($path . $file)){
                 return true;
             }
         } else { 
             return null;
         }
         
     }
}
