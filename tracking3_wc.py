import cv2

# 「もしこれから実行するファイルがコマンドラインから実行されるファイルであれば以下の処理を実行する」って意味のおまじない
if __name__ == '__main__':

    # tracking手法　KCFってやつがオススメらしい

    # Boosting
    # tracker = cv2.TrackerBoosting_create()

    # MIL
    # tracker = cv2.TrackerMIL_create()

    # KCF
    tracker = cv2.TrackerKCF_create()

    # MedianFlow
    # tracker = cv2.TrackerMedianFlow_create()

    # webカメラ読込
    cap = cv2.VideoCapture(0)

    # 保存用動画ファイルの設定
    fps = int(cap.get(cv2.CAP_PROP_FPS))                                         # FPS
    w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))                                   # 横幅
    h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))                                  # 縦幅
    fourcc = cv2.VideoWriter_fourcc('m', 'p', '4', 'v')                          # 動画保存時のfourcc設定（mp4）
    video = cv2.VideoWriter('tracking3_video.mp4', fourcc, fps, (w, h), False)   # 動画の仕様(filename、fourcc, FPS, size, color）

    # 位置情報, 四角形の中心を格納
    center_x = []
    center_y = []

    while True:
        # フレーム取得
        ret, frame = cap.read()
        if not ret:
            continue
        # ROIの初期化
        bbox = (0,0,10,10)
        bbox = cv2.selectROI(frame, False)
        ok = tracker.init(frame, bbox)
        cv2.destroyAllWindows()
        break

    while True:
        # VideoCaptureから1フレーム読み込む
        # 格納できてればret=true
        ret, frame = cap.read()
        if not ret:
            k = cv2.waitKey(1)
            if k == 27 :
                break
            continue

        # Start timer
        timer = cv2.getTickCount()

        # トラッカーをアップデート
        track, bbox = tracker.update(frame)

        # FPS計算
        fps = cv2.getTickFrequency() / (cv2.getTickCount() - timer);

        # 検出した場所に四角とその中心を描画
        if track:
            # Tracking success
            p1 = (int(bbox[0]), int(bbox[1]))
            p2 = (int(bbox[0] + bbox[2]), int(bbox[1] + bbox[3]))
            cv2.rectangle(frame, p1, p2, (0,255,0), 2, 1)  # 四角形(frame, 左上, 右下, color, thickness, linetype)

            cx = int(bbox[0] + ((bbox[2])/2))
            cy = int(bbox[1] + ((bbox[3])/2))
            cv2.circle(frame, (cx, cy), 10, (0,0,255), 5)
        else :
            # トラッキングが外れたら警告を表示
            cv2.putText(frame, "Failure", (10,50), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,255,0), 1, cv2.LINE_AA);

        # FPSを表示する
        cv2.putText(frame, "FPS : " + str(int(fps)), (10,20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,255,0), 1, cv2.LINE_AA);

        # 加工済のframeを表示&保存
        cv2.imshow("Tracking", frame)
        video.write(frame)  # 保存されるけど何故か再生できない

        # 四角の中心座標をデータとして保存
        center_x.append(cx)
        center_y.append(cy)

        # キー入力を1ms待って、k が27（ESC）だったらBreak
        k = cv2.waitKey(1)
        if k == 27 :
            break

# キャプチャをリリース、ウィンドウをすべて閉じる
cap.release()
cv2.destroyAllWindows()