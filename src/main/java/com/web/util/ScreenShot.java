package com.web.util;

import java.awt.AWTException;
import java.awt.Dimension;
import java.awt.HeadlessException;
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import com.web.tool.url;
public class ScreenShot {

    /**
     * @param args
     */
    public static void run(String prefixName) {
    	try {
			Thread.sleep(500);
		} catch (InterruptedException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        try {
//            Dimension dimension = Toolkit.getDefaultToolkit().getScreenSize();
//            BufferedImage screenshot = (new Robot()).createScreenCapture(new Rectangle(0,
//                    0,(int)dimension.getWidth(),(int)dimension.getHeight()));
            BufferedImage screenshot = (new Robot()).createScreenCapture(new Rectangle(960,
                    250,600,580));
            File file = new File(url.dire+"//" + prefixName + "_Simplified.jpg");
            System.out.println(file.getName());
            ImageIO.write(screenshot, "jpg", file);
        } catch (HeadlessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (AWTException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}