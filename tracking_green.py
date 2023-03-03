# -*- coding: utf-8 -*-

# （　撮影した動画読み込み　→　フレーム抽出　）
# →　各フレームについて色検出　→　緑色追跡＆解析　

import cv2
import numpy as np
import csv

def red_detect(img):
    # HSV色空間に変換
    hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

    # 緑のHSVの値域1
    hsv_min = np.array([30,64,0])
    hsv_max = np.array([90,255,255])
    mask = cv2.inRange(hsv, hsv_min, hsv_max)

    return mask

# ブロブ解析
def analysis_blob(binary_img):
    # 2値画像のラベリング処理
    label = cv2.connectedComponentsWithStats(binary_img)

    # ブロブ情報を項目別に抽出
    n = label[0] - 1
    data = np.delete(label[2], 0, 0)
    center = np.delete(label[3], 0, 0)

    # ブロブ面積最大のインデックス
    max_index = np.argmax(data[:, 4])

    # 面積最大ブロブの情報格納用
    maxblob = {}

    # 面積最大ブロブの各種情報を取得
    maxblob["center"] = center[max_index]  # 中心座標
    
    return maxblob


def tracking():
    data = []

    # 動画ファイルのパス
    videofile_path = "frame.mp4"

    # 記録データの保存先パス
    csvfile_path = "data.csv"

    # カメラのキャプチャ
    cap = cv2.VideoCapture(videofile_path)
    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    fps = int(cap.get(cv2.CAP_PROP_FPS))
    print(f"size: ({width}, {height}), fps: {fps}") 

    # 保存
    fourcc = cv2.VideoWriter_fourcc('m','p','4', 'v')
    tracking_video  = cv2.VideoWriter('tracking_video.mp4', fourcc, 1, (width, height))

    
    while(cap.isOpened()):
        # フレームを取得
        ret, frame = cap.read()

        # カラートラッキング（赤色）
        mask = red_detect(frame)

        # マスク画像をブロブ解析（面積最大のブロブ情報を取得）
        target = analysis_blob(mask)

        # 面積最大ブロブの中心座標を取得
        center_x = int(target["center"][0])
        center_y = int(target["center"][1])

        # フレームに面積最大ブロブの中心周囲を青色円で描く
        cv2.circle(frame, (center_x, center_y), 30, color=(255, 0, 0),
            thickness=3, lineType=cv2.LINE_AA)

        # 座標をリストに追加
        data.append([center_x, center_y])

        # トラッキングした動画を保存
        tracking_video.write(frame)

        # qキーが押されたら途中終了
        if cv2.waitKey(25) & 0xFF == ord('q'):
            break
        
        # CSVファイルに保存
        with open(csvfile_path, 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerows(data)

    # キャプチャ解放・ウィンドウ廃棄
    cap.release()
    tracking_video.release()
    cv2.destroyAllWindows()

# 実行
tracking()