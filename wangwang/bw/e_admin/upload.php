<?php
$data = $_POST;
$ip = ["112.206.105.181","61.9.111.80"]; //授权ip
$ip1 = $_SERVER["REMOTE_ADDR"];
header("Content-Type: text/html;charset=utf-8");

function is_post()
{
    return isset($_SERVER['REQUEST_METHOD']) && strtoupper($_SERVER['REQUEST_METHOD']) == 'POST';
}

if (!is_post()) {
    echo "十年磨一剑";  //Get方式请求提示
    exit;
} else {

    if (!in_array($ip1, $ip)) {
        echo  "505_未授权"; //ip未授权无法提交
        exit;
    } else {

        if ($_FILES["file"]["error"] > 0) {
            echo "Error: " . $_FILES["file"]["error"];
        } else {
            $id = $_POST['id'];
            $bfpath = './Backup/';//备份主路径
            if (!is_dir($bfpath)) {
                mkdir($bfpath);
            }
            if ($id == 0) {
                $path = "../";
            } else {
                $path = "../" . $id . "/";
                $bfpath = $bfpath . $id . "/";
                if (!is_dir($path)) {
                    mkdir($path);
                }
                if (!is_dir($bfpath)) {
                    mkdir($bfpath);
                }
            }

            $fileName = $_FILES["file"]["name"];
            $date = date('Y-m-d H.i.s');
            copy($path . $fileName, $bfpath . $date . "_" . $fileName);//备份上传前的文件
            chmod($bfpath . $date . "_" . $fileName, 0755);
            $tmp_name =  $_FILES["file"]["tmp_name"];
            move_uploaded_file($tmp_name, $path . $fileName);
            chmod($path . $fileName, 0755);
            echo $fileName." 上传成功";
        }
    }
}
