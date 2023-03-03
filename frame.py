# -*- coding: utf-8 -*-
# 撮影した動画読み込み　→　フレーム抽出　
# （→　各フレームについて色検出　→　追跡＆解析　）

import cv2
import numpy as np
import os

def frame(videofile_path, step, fps):
    # 動画の読み込み
    cap = cv2.VideoCapture(videofile_path)  

    # 動画の全フレーム数を計算                
    Fs = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))  

    # 動画情報取得
    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    fps = int(cap.get(cv2.CAP_PROP_FPS))
    print(f"size: ({width}, {height}), fps: {fps}") 

    # 静止画のファイル名のヘッダー
    img_outdir = './img'     

    # 静止画を抽出する間隔                
    ext_index = np.arange(0, Fs, step)   

    
    os.makedirs(img_outdir, exist_ok=True)

    outimg_files = []
    img_count = 0

    # フレームサイズ分のループを回す
    for i in range(Fs - 1):   

        # 動画から1フレーム読み込み                  
        flag, frame = cap.read()

        # 現在のフレーム番号iが、抽出する指標番号と一致するかチェック             
        check = i == ext_index 
        
        # frameを取得できた(flag=True)時だけ処理
        if flag == True:

            # もしi番目のフレームが静止画を抽出するものであれば、ファイル名を付けて保存
            if True in check:
                img_count = img_count + 1

                # 画像出力
                outimg_file = '{}/{:05d}.png'.format(img_outdir, img_count)
                cv2.imwrite(outimg_file, frame)
                outimg_files.append(outimg_file)            
        else:
            pass
    
    # 動画作成
    fourcc = cv2.VideoWriter_fourcc('m','p','4', 'v')
    video  = cv2.VideoWriter('frame.mp4', fourcc, fps, (width, height))

    for img_file in outimg_files:
            img = cv2.imread(img_file)
            video.write(img)

    video.release()



# 実行
frame("mouse_2.mp4", 60, 1)

