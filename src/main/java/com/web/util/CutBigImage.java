package com.web.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import org.opencv.core.Core;

import org.opencv.core.Mat;
import org.opencv.core.Range;
import org.opencv.core.Size;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.opencv.utils.Converters;

import com.web.tool.resolveChinesePathToCutBigImage;
import java.io.UnsupportedEncodingException;

import com.sun.javafx.util.Utils;
import com.web.tool.fileToBits;
public class CutBigImage {
//	 public static String gbEncoding(final String gbString) {
//	        char[] utfBytes = gbString.toCharArray();
//	        String unicodeBytes = "";
//	        for (int i = 0; i < utfBytes.length; i++) {
//	            String hexB = Integer.toHexString(utfBytes[i]);
//	            if (hexB.length() <= 2) {
//	                hexB = "00" + hexB;
//	            }
//	            unicodeBytes = unicodeBytes + "\\u" + hexB;
//	        }
//	        return unicodeBytes;
//	    }
//	 
	public static ArrayList<Object> cutBigImage(String path) throws IOException {
		System.out.println("切分大图片拿到的path:"+path);
		int HIOG = 50;
		int VIOG = 3;
		ArrayList<Object> Position = new ArrayList<Object>();
		// 载入dll（必须先加载）
		System.out.println(Core.NATIVE_LIBRARY_NAME);
	    System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
	    //String pathcode = new String(path.getBytes("unicode-escape"), "utf-8");
	   Mat src = Imgcodecs.imread(path,Imgcodecs.IMREAD_GRAYSCALE);//746*534 宽*高 列*行
//	    byte[] a= fileToBits.getBytesByFile(path);
//	   
//	    Mat temp(2, 2, CV_8UC1,a);
	   // Mat src =Converters(a);
	    ImageViewer imageViewer = new ImageViewer(src, "第一幅图片"); 
	    if(src.dataAddr()==0){
	         System.out.println("打开文件出错");
	    }
	    Size size = src.size();
	    System.out.println(size);
        Mat img = new Mat();
        Imgproc.threshold(src, img, 127, 255, Imgproc.THRESH_BINARY_INV);//灰度图像二值化
        int height = img.height();
        int width = img.width();
      	System.out.println("height:"+height);
        System.out.println("width:"+width);
        int[] w_ = GetVProjection.getVProjection(img);
        int start = 0;
        Map scan = Scan.scan(w_, HIOG);     
        ArrayList<Integer> V_start = new ArrayList<Integer>();
		ArrayList<Integer> V_end = new ArrayList<Integer>();
        V_start = (ArrayList<Integer>) scan.get("V_start");
        V_end = (ArrayList<Integer>) scan.get("V_end");
        
        if(V_start.size()>V_end.size())
        	V_end.add(width-5);
        
        for(int i=0;i<V_end.size();i++) {
        	if(V_end.get(i)-V_start.get(i)<30)
        		continue;
        	Range rowRange = new Range(0,height);
        	Range colRange = new Range(V_start.get(i),V_end.get(i));
        	Mat cropImg = new Mat(img,rowRange,colRange);
        	ImageViewer imageViewer2 = new ImageViewer(cropImg, "中间图片"); 
        	int[] h_ = GetHProjection.getHProjection(cropImg);
        	Map scan2 = Scan1.scan(h_, VIOG);

        	ArrayList<Integer> H_start = new ArrayList<Integer>();
    		ArrayList<Integer> H_end = new ArrayList<Integer>();
        	H_start = (ArrayList<Integer>) scan2.get("V_start");
        	H_end = (ArrayList<Integer>) scan2.get("V_end");

        	if(H_start.size()>H_end.size())
            	H_end.add(height);

        	for(int pos=0;pos<H_start.size();pos++) {
        		Range rowRange1 = new Range(H_start.get(pos),H_end.get(pos));
            	Range colRange1 = new Range(0,cropImg.width());
            	Mat DcropImg = new Mat(cropImg,rowRange1,colRange1);
            	//显示图片
//            	ImageViewer imageViewer3 = new ImageViewer(DcropImg, "第er幅图片"); 
//        		imageViewer3.imshow();
            	int[] sec_V = GetVProjection.getVProjection(DcropImg);
            	
            	Map scan3 = Scan.scan(sec_V,0);
            	ArrayList<Integer> c1 = new ArrayList<Integer>();
        		ArrayList<Integer> c2 = new ArrayList<Integer>();
            	c1 = (ArrayList<Integer>) scan3.get("V_start");
            	c2 = (ArrayList<Integer>) scan3.get("V_end");
            	if(c1.size()>c2.size()) {
            		c2.add(DcropImg.width());
            	}

            	int x = 1;
            	while(x<c1.size()) {
            		if(c1.get(x)-c2.get(x-1)<12) {
            			c2.remove(x-1);
            			c1.remove(x);
            			x-=1;
            		}
            		x+=1;
            	}
            	
            	if(c1.size()==1) {
					ArrayList<Integer> list1 = new ArrayList<Integer>();
					list1.add(V_start.get(i));
					list1.add(H_start.get(pos));
					list1.add(V_end.get(i));
					list1.add(H_end.get(pos));
					Position.add(list1);
				}else {
					for(int l=0;l<c1.size();l++) {
						ArrayList<Integer> list1 = new ArrayList<Integer>();
						list1.add(V_start.get(i)+c1.get(l));
						list1.add(H_start.get(pos));
						list1.add(V_start.get(i)+c2.get(l));
						list1.add(H_end.get(pos));
						Position.add(list1);
					}
				}
            
        	}
        }
        Map map=new HashMap();
        ArrayList<Object> listpoint = new ArrayList<Object>();
        for(int m=Position.size()-1;m>=0;m--) {
        	ArrayList<Integer> list1 = new ArrayList<Integer>();
        	int wpadding=(int) (((Integer) ((ArrayList)Position.get(m)).get(2)-(Integer)((ArrayList)Position.get(m)).get(0))*0.1);
        	int hadding=(int) (((Integer) ((ArrayList)Position.get(m)).get(3)-(Integer)((ArrayList)Position.get(m)).get(1))*0.1);
        	list1.add((Integer) ((ArrayList)Position.get(m)).get(0)-wpadding);
			list1.add((Integer) ((ArrayList)Position.get(m)).get(1)-hadding);
			list1.add((Integer) ((ArrayList)Position.get(m)).get(2)+wpadding);
			list1.add((Integer) ((ArrayList)Position.get(m)).get(3)+hadding);
			listpoint.add(list1);
        	
        }
        return listpoint;
	}

}
