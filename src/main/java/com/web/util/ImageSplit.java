package com.web.util;

import javax.imageio.ImageIO;

import com.web.interceptor.SAXWrite;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by liwj
 * date:2018/2/23
 * comment:
 */
import com.web.tool.url;
public class ImageSplit {
    public String dirft=url.dir+"/2019/";
    /**
     * 切割图片
     *
     * @throws Exception
     */
    public  ArrayList<posepoint>  splitImage2(JSONArray json) throws Exception {
        /*#"E:\\FTZ\\2019\\11\\sliver2019111810253536.jpg";*/
		JSONObject jsonlast = json.getJSONObject(json.size()-1); 
		String originalImg = (String)jsonlast.getString("src");
		Float xli=Float.parseFloat((String)jsonlast.getString("xli"));
		Float yli=Float.parseFloat((String)jsonlast.getString("yli"));
		JSONObject jsonOne;
		originalImg=url.dire+originalImg;
        File file = new File(originalImg);
        FileInputStream fis = new FileInputStream(file);
        BufferedImage image = ImageIO.read(fis);
        int count = 0;
        ArrayList<posepoint> totalmap = new ArrayList<posepoint>();
        BufferedImage[] imgs = new BufferedImage[json.size()-1];
        for(int i=0;i<json.size()-1;i++){
        	jsonOne = json.getJSONObject(i);  
        	posepoint point=new posepoint();
        	point.setX((int)(Float.parseFloat((String)jsonOne.get("x"))/xli));
        	point.setY((int)(Float.parseFloat((String)jsonOne.get("y"))/yli));
        	point.setWidth((int)(Float.parseFloat((String)jsonOne.get("width"))/xli)+1);
        	point.setHeight((int)(Float.parseFloat((String)jsonOne.get("height"))/yli)+1);
        	totalmap.add(point);
	 }
        Collections.sort(totalmap, new SortX());
        
        /*SAXWrite.savexml(totalmap,originalImg.split("\\.")[0]+".xml");*/
        for (int h=0;h<totalmap.size();h++){
        	imgs[count] = new BufferedImage(totalmap.get(h).getWidth(),totalmap.get(h).getHeight(), image.getType());
        	Graphics2D gr = imgs[count++].createGraphics();
            gr.drawImage(image, 0, 0, totalmap.get(h).getWidth(),totalmap.get(h).getHeight(),totalmap.get(h).getX(),totalmap.get(h).getY(),
            		totalmap.get(h).getWidth()+totalmap.get(h).getX(),totalmap.get(h).getY()+totalmap.get(h).getHeight(), null);
            gr.dispose(); 
        }
        /* */
        for (int i = 0; i < imgs.length; i++) {
            ImageIO.write(imgs[i], "jpg", new File(dirft + i + ".jpg"));
            totalmap.get(i).setDir(dirft + i + ".jpg");
        }
        
        return totalmap;
    }
 
   /* *//**
     * 合并图片
     *
     * @throws Exception
     *//*
    private static void mergeImage() throws Exception {
        int rows = 2;
        int cols = 2;
        int chunks = rows * cols;

        int chunkWidth, chunkHeight;
        int type;

        File[] imgFiles = new File[chunks];
        for (int i = 0; i < chunks; i++) {
            imgFiles[i] = new File("E:\\FTZ\\2019\\" + i + ".jpg");
        }

        BufferedImage[] buffImages = new BufferedImage[chunks];
        for (int i = 0; i < chunks; i++) {
            buffImages[i] = ImageIO.read(imgFiles[i]);
        }
        type = buffImages[0].getType();
        chunkWidth = buffImages[0].getWidth();
        chunkHeight = buffImages[0].getHeight();

        BufferedImage finalImg = new BufferedImage(chunkWidth * cols, chunkHeight * rows, type);

        int num = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                finalImg.createGraphics().drawImage(buffImages[num], chunkWidth * j, chunkHeight * i, null);
                num++;
            }
        }

        ImageIO.write(finalImg, "jpeg", new File("C:\\Users\\liwj\\Desktop\\tidb\\image\\finalImg.jpg"));
    }
*/
  
}