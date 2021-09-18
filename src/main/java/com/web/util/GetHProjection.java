package com.web.util;

import org.opencv.core.Mat;

public class GetHProjection {
	public static int[] getHProjection(Mat mat) {

		// 测试用mat：534*746*1
		int w = mat.width();
		int h = mat.height();
		int c = mat.channels();

		int hProjection[][] = new int[h][w];
		for (int i = 0; i < h; i++) {// 0-533
			for (int j = 0; j < w; j++)// 0-745
				hProjection[i][j] = 0;
		}

		int[] h_ = new int[h];

		for (int k = 0; k < c; k++) {
			for (int y = 0; y < h; y++) {// 0-533
				for (int x = 0; x < w; x++) {// 0-745
					if (mat.get(y, x)[k] == 255) {
						h_[y] += 1;
					}
				}
			}
		}


		for (int y = 0; y < h; y++) {// 0-533
			for (int x = 0; y < h_[y]; y++) {// -745
				hProjection[y][x] = 255;
			}
		}
		return h_;

	}
}
