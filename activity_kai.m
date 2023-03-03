% マウスの活動データを解析
% cage.mを実行した後にこっちを実行

% ユーザが入力するところは、
% ・UIで解析したいファイルを選択
% ・コマンドウィンドウで、Getを押してから何秒後にマウスを入れたかを入力
% です

%% 0.活動測定の際 %%

% i)Getを押してから最初の5秒くらいは何も置かない
% 　　　→電圧のデフォルト値を調整するため

% ii)マウスを入れる。この時の時間はメモしておく
% 　　  →実行時に入力してもらうため

%% 1.csvファイルの読み込み & 電圧値調整 %%

% ファイル読み込み
[file,path] = uigetfile('*.csv');
if isequal(file,0)
    disp('selected Cancel');
else
    disp(['selected: ', fullfile(path,file)]);
end

m = readmatrix(file);

% Getを押してから何秒後にマウスを入れたかを入力
prompt = "マウスを入れたのは何秒後? : ";
t0= input(prompt);
t_main = t0*10;

% 上から、ch0(黄)、ch1(青)、ch2(赤)、ch3(緑)
m0 = m(:,1); 
m1 = m(:,2);  
m2 = m(:,3);
m3 = m(:,4);


% 時間ごとに、各chの電圧をプロット
% サンプリング周波数f = 10[Hz] なので
% 横軸は時間(10^(-1)sec)、縦軸は各chの電圧
% 調整前の電圧を描画したいときは以下のコードのコメント部分を使う

% figure
% T = size(m,1);
% t = linspace(0,T,T);
% 
% hold on
% sz = 5;
% scatter(t,m0,sz,'MarkerEdgeColor','none','MarkerFaceColor','#EDB120');
% scatter(t,m1,sz,'MarkerEdgeColor','none','MarkerFaceColor','#0072BD');
% scatter(t,m2,sz,'MarkerEdgeColor','none','MarkerFaceColor','#D95319');
% scatter(t,m3,sz,'MarkerEdgeColor','none','MarkerFaceColor','#77AC30');
% title('各Chの計測電圧（調整前）')
% legend
% ylim([-0.5, 0.5])
% hold off

% % 調整中の各Chの電圧
% figure
% T = t_main;
% t = linspace(0,T,T);
% 
% m_adjing0 = m0(1:T,1);
% m_adjing1 = m1(1:T,1);
% m_adjing2 = m2(1:T,1);
% m_adjing3 = m3(1:T,1);
% 
% hold on
% sz = 5;
% scatter(t,m_adjing0,sz,'MarkerEdgeColor','none','MarkerFaceColor','#EDB120');
% scatter(t,m_adjing1,sz,'MarkerEdgeColor','none','MarkerFaceColor','#0072BD');
% scatter(t,m_adjing2,sz,'MarkerEdgeColor','none','MarkerFaceColor','#D95319');
% scatter(t,m_adjing3,sz,'MarkerEdgeColor','none','MarkerFaceColor','#77AC30');
% title('各Chの計測電圧（マウス置くまで & 調整前）')
% legend
% ylim([-0.5, 0.5])
% hold off


% 電圧のデフォルト値を調整
% 計測スタートから3秒後の値を0とする

m_adj0 = m0 - m(30,1); 
m_adj1 = m1 - m(30,2);  
m_adj2 = m2 - m(30,3);
m_adj3 = m3 - m(30,4);

% 調整中の各Chの電圧（調整後）
figure
T = t_main;
t = linspace(0,T,T);

m_adjed0 = m_adj0(1:T,1);
m_adjed1 = m_adj1(1:T,1);
m_adjed2 = m_adj2(1:T,1);
m_adjed3 = m_adj3(1:T,1);

hold on
sz = 5;
scatter(t,m_adjed0,sz,'MarkerEdgeColor','none','MarkerFaceColor','#EDB120');
scatter(t,m_adjed1,sz,'MarkerEdgeColor','none','MarkerFaceColor','#0072BD');
scatter(t,m_adjed2,sz,'MarkerEdgeColor','none','MarkerFaceColor','#D95319');
scatter(t,m_adjed3,sz,'MarkerEdgeColor','none','MarkerFaceColor','#77AC30');
title('各Chの計測電圧（調整後、マウス置くまでの時間）')
legend
ylim([-0.5, 0.5])
hold off


% もう一回プロット
figure
T = size(m,1);
t = linspace(0,T,T);

hold on
sz = 5;
scatter(t,m_adj0,sz,'MarkerEdgeColor','none','MarkerFaceColor','#EDB120');
scatter(t,m_adj1,sz,'MarkerEdgeColor','none','MarkerFaceColor','#0072BD');
scatter(t,m_adj2,sz,'MarkerEdgeColor','none','MarkerFaceColor','#D95319');
scatter(t,m_adj3,sz,'MarkerEdgeColor','none','MarkerFaceColor','#77AC30');
title('各Chの計測電圧（調整後）')
legend
ylim([-0.5, 0.5])
hold off

%% 2.座標へ変換&ケージのエッジ描画 %%

% 4点の電圧の差から、ゲージの中心を原点として
% 相対的な(x,y)座標を計算
x = ((m_adj3 - m_adj2) + (m_adj1 - m_adj0)) / 2;
y = ((m_adj3 - m_adj1) + (m_adj2 - m_adj0)) / 2;

% 位置情報全体
figure
sz = 20;
hold on
scatter(x, y, sz);
rectangle('Position',[rec_x1 rec_y1 width height], 'EdgeColor', '#A2142F', 'LineWidth', 3)
title('マウスの位置とケージ')
xlim([-0.1, 0.1])
ylim([-0.1, 0.1])
hold off

% マウスを入れる前のデータを削除
% マウス計測分のデータをx_mainと呼ぶ
m_main0 = m_adj0(t_main:end,:);
m_main1 = m_adj1(t_main:end,:);
m_main2 = m_adj2(t_main:end,:);
m_main3 = m_adj3(t_main:end,:);

x_main = ((m_main3 - m_main2) + (m_main1 - m_main0)) / 2;
y_main = ((m_main3 - m_main1) + (m_main2 - m_main0)) / 2;

%% 3.エラーポイントの検出&削除 %%

% エラーを除去したものをx_main_noerrorと呼ぶ
% ケージの外の位置にあるものは消去？改良の余地ありそう
% 面倒だけど、x_main_noerrorの事前割り当てとかの問題で一度x_main,y_mainを初期化してからエラーを検出し、
% エラーでないものをx_main_noerrorに代入していく

% エラーカウント(error_countと呼ぶ)
e = size(x_main,1);
error_count = 0;
for l = 1:e
    if x_main(l,1) < rec_x1-0.02 || x_main(l,1) > rec_x2+0.02 || y_main(l,1) < rec_y1-0.02 || y_main(l,1) > rec_y2+0.02
        error_count = error_count+1;
            continue
    end
end

% 事前割り当て
e_noerror = size(x_main,1) - error_count;
x_main_noerror = zeros(e_noerror,1); 
y_main_noerror = zeros(e_noerror,1);

% エラーポイントを除いたものを代入
n=1;
for l = 1:e
    if x_main(l,1) > rec_x1-0.02 && x_main(l,1) < rec_x2+0.02 && y_main(l,1) > rec_y1-0.02 && y_main(l,1) < rec_y2+0.02
        x_main_noerror(n,1) = x_main(l,1);
        y_main_noerror(n,1) = y_main(l,1);
        n = n+1;
    end
end

%% 4.マウスの位置の描画 %%

% % マウスの位置情報の描画（エラーポイント除去後）
% figure
% sz = 20;
% hold on
% scatter(x_main_noerror, y_main_noerror, sz);
% rectangle('Position',[rec_x1 rec_y1 width height], 'EdgeColor', '#A2142F', 'LineWidth', 3)
% title('マウスの位置（エラーポイント除去）とケージ')
% xlim([-0.1, 0.1])
% ylim([-0.1, 0.1])
% hold off


% １秒毎のデータに変換

% １秒毎のx_main
% x_main_psと呼ぶ
% 計算パフォーマンス向上のための事前割り当て
e = size(x_main,1);
x_main_ps_size = fix(e / 10);
y_main_ps_size = fix(e / 10);
x_main_ps = zeros(x_main_ps_size,1);
y_main_ps = zeros(y_main_ps_size,1);

% データの代入
j = 1;
for i = 1:10:e
   x_main_ps(j,1) = x_main(i,1);
   y_main_ps(j,1) = y_main(i,1);
   j = j + 1;
end

% １秒毎のx_main_noerror
% 計算パフォーマンス向上のための事前割り当て
e = size(x_main_noerror,1);
x_main_noerror_ps_size = fix(e / 10);
y_main_noerror_ps_size = fix(e / 10);
x_main_noerror_ps = zeros(x_main_ps_size,1);
y_main_noerror_ps = zeros(y_main_ps_size,1);

% データの代入
j = 1;
for i = 1:10:e
   x_main_noerror_ps(j,1) = x_main_noerror(i,1);
   y_main_noerror_ps(j,1) = y_main_noerror(i,1);
   j = j + 1;
end

% １秒毎のマウスの位置を描画
figure
sz = 20;
hold on
scatter(x_main_ps, y_main_ps, sz);
rectangle('Position',[rec_x1 rec_y1 width height], 'EdgeColor', '#A2142F', 'LineWidth', 3)
title('マウスの位置とケージ（１秒毎）')
xlim([-0.1, 0.1])
ylim([-0.1, 0.1])
hold off

%% 5.総移動距離の計算[dsum] %%

% エラーポイントは除去せずに総移動距離を計算する
% １秒間にあまりにいっぱい移動（ケージ長辺の２倍の距離）しすぎてたらエラーとする
% その分元気の指標としてもいいかも？（error_count2）

dsum = 0;
e = x_main_ps_size - 1;
error_count2 = 0;

for i = 1:e
    temp = sqrt((x_main_ps(i+1,1) - x_main_ps(i,1))^2 + (y_main_ps(i+1,1) - y_main_ps(i,1))^2) * d;
    if temp > width *2
        temp = 0;
        error_count2 = error_count2 + 1;
    end
    dsum = dsum + temp;
end


%% 6.1hourあたりの移動距離[hsum] %%

% １秒間にあまりにいっぱい移動（ケージ長辺の1.5倍の距離）しすぎてたらエラーとする

h = fix(size(m,1) / 36000);
hsum = zeros(h,1); 
 
for k = 1:h
    p = 3600 *(k-1) + 2;
   for j = p:3600 *k 
       temp = sqrt((x_main_ps(j+1,1) - x_main_ps(j,1))^2 + (y_main_ps(j+1,1) - y_main_ps(j,1))^2) * d;
       if temp > width *1.5
        temp = 0;
       end
       hsum(k,1) = hsum(k,1) + temp;
   end
end

% 時間毎の棒グラフを表示
figure
hold on
hx = 1:h;
bar(hx,hsum(:,1))
ylim([0, 120])
title('１時間あたりの移動距離')
ylabel('Distance [m]')
xlabel('Time [hour]')
hold off

%% 7.1hourあたりの位置のばらつき %%

% １秒間にあまりにいっぱい移動（ケージ長辺の1.5倍の距離）しすぎてたらエラーとする
% x,yそれぞれの標準偏差を求め、足して２で割ったものを指標とする
% 参考になるかはまだ不明

sx = zeros(h,1);
sy = zeros(h,1);

for k = 1:h
    p = 3600 *(k-1) + 2;
   for j = p:3600 *k 
       temp = sqrt((x_main_ps(j+1,1) - x_main_ps(j,1))^2 + (y_main_ps(j+1,1) - y_main_ps(j,1))^2) * d;
       if temp > width *1.5
        x_main_ps(j+1,1) = x_main_ps(j,1);
        y_main_ps(j+1,1) = y_main_ps(j,1);
       end
       sx(k,1) = std(x_main_ps(p:3600 *k));
       sy(k,1) = std(y_main_ps(p:3600 *k));
   end
end

s = (sx + sy) /2;

% 時間毎の棒グラフを表示
figure
hold on
hx = 1:h;
bar(hx,s(:,1))
title('１時間あたりの位置のばらつき')
ylabel('Standard deviation')
xlabel('Time[hour]')
hold off
