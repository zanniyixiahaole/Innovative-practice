package com.web.tool;

import java.io.File;
import java.io.FileOutputStream;  

import java.io.OutputStream;


import sun.misc.BASE64Decoder; 
public class base64ToImg {


    public static boolean base64ToImg(String imgStr, String imgFilePath) {// 对字节数组字符串进行Base64解码并生成图片
    	if (imgStr == null)
    		 return false;
    		 BASE64Decoder decoder = new BASE64Decoder();
    		 try {
    		  // 解密
    		  byte[] b = decoder.decodeBuffer(imgStr);
    		  // 处理数据
    		  for (int i = 0; i < b.length; ++i) {
    		   if (b[i] < 0) {
    		    b[i] += 256;
    		   }
    		  }
    		  //文件夹不存在则自动创建
    		  File tempFile = new File(imgFilePath);
    		  if (!tempFile.getParentFile().exists()) {
    		   tempFile.getParentFile().mkdirs();
    		  }
    		  OutputStream out = new FileOutputStream(tempFile);
    		  out.write(b);
    		  out.flush();
    		  out.close();
    		  return true;
    		 } catch (Exception e) {
    		  return false;
    		 }
    }

} 