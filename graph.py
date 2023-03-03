# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt

def main():
    # CSVのロード
    data = np.loadtxt("data.csv", delimiter=',')

    # 2次元配列を分割（x座標, y座標の1次元配列)
    x = data[:,0]
    y = data[:,1]

    # 横軸tのあんまり参考にならないグラフ
    # plt.plot(x, "r-", label="x")
    # plt.plot(y, "b-", label="y")
    # plt.xlabel("Time[sec]", fontsize=16)     # x軸ラベル
    # plt.ylabel("Position[px]", fontsize=16)    # y軸ラベル
    # plt.grid()         # グリッド表示
    # plt.legend(loc=1, fontsize=16) 
    # plt.savefig("tracking.png")      # 凡例表示
    # plt.show()

    # 散布図
    plt.scatter(x,y)
    plt.savefig("scatter.png")
    plt.show()


main()