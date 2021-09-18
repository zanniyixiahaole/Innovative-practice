package com.web.interceptor;

import java.io.File;
import com.web.tool.url;
import java.text.SimpleDateFormat;
import java.util.Date;


public class Filemove {

	public String  filesave(String old,String word,Long userId) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
		String res = sdf.format(new Date());
		//从source文件夹剪切1.txt，移动到target文件夹，并重命名为2.txt
		String wordUrl=word+"\\"+res+".jpg";
		String newfile=url.dir+"\\"+userId+"\\"+wordUrl;
		File newFile = new File(url.dir + File.separator + userId + File.separator+word +File.separator+res+".jpg");
		if (!newFile.getParentFile().exists()) {
			// 如果目标文件所在的目录不存在，则创建父目录
			newFile.getParentFile().mkdirs();
		}
		File startFile = new File(old);

		File endFile=new File(newfile);

		if (startFile.renameTo(endFile)) {

		   System.out.println("文件移动成功！目标路径：{"+endFile.getAbsolutePath()+"}");

		} else {

		   System.out.println("文件移动失败！起始路径：{"+startFile.getAbsolutePath()+"}");

		}
		return wordUrl;
		
	}

}
