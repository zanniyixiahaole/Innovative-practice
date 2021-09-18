package com.web.util;



import org.opencv.core.Mat;

public class GetVProjection {
	public static int[] getVProjection(Mat mat) {
		//测试用mat：534*746*1
		int w = mat.width();//534
		int h = mat.height();//746
		int c = mat.channels();
		
		int vProjection[][] = new int [h][w];
		
		for(int i=0;i<h;i++) {//0-533
			for(int j=0;j<w;j++)//0-745
				vProjection[i][j] = 0;
		}
	
		int[] w_ = new int[w];
		
		for(int k=0;k<c;k++) {
			for(int x=0;x<w;x++) {//0-533
				for(int y=0;y<h;y++) {//0-745
					if(mat.get(y, x)[k]==255) {
						w_[x]+=1;
					}
				}
			}
		}
			
		for(int x=0;x<w;x++) {//0-533
			for(int y=h-w_[x];y<h;y++) {//-745
				vProjection[y][x]=255;
			}
		}
		return w_;
	}
}
