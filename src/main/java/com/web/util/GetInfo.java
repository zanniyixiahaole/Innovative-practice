package com.web.util;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;

import org.nd4j.linalg.io.ClassPathResource;

public class GetInfo {
	static String[] item = {};

	@SuppressWarnings("resource")
	public static String[] Handle() {
		try {
			String csv= new ClassPathResource("map.csv").getFile().getPath();
            BufferedReader reader = new BufferedReader(new FileReader(csv));
			String line;
			while ((line = reader.readLine()) != null) {
				String info[] = line.split(",");
				int iteml = item.length;
				int infol = info.length;
				item = Arrays.copyOf(item, iteml + infol);// 填充
				System.arraycopy(info, 0, item, iteml, infol);// 组合数组
			}
		} catch (FileNotFoundException ex) {
			System.out.println("没找到文件！");
		} catch (IOException ex) {
			System.out.println("读写文件出错！");
		}
		System.out.println(Arrays.toString(item));
		return item;
	}
}
