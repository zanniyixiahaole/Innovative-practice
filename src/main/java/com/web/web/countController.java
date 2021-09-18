package com.web.web;

import java.awt.Font;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jfree.chart.ChartColor;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.StandardChartTheme;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.Plot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.chart.title.LegendTitle;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.DefaultCategoryDataset;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.entity.count;
import com.web.service.countService;

@Controller
public class countController {

	@Autowired
	private countService countService;
	//查询每个字出现的频率
	@RequestMapping("/getTotal")
//	@ResponseBody
	public String getTotal(HttpServletRequest request) {
		List<count> totalList = countService.selectTotalOfWord();
		// 创建一个柱状图数据集
	    DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		List<count> list = new ArrayList<count>();
		//记录数小于十条
		if(totalList.size()<10) {
			// 数据装入
		    for(int i=0;i<totalList.size();i++){
		        count item =totalList.get(i);
		        //dataset.setValue(10,"a","管理人员"); 数量，类别别名，类别
		        dataSet.setValue(item.getTotal(),item.getWord(),item.getWord());
		    }
		}else {//超过十条，只拿十条
			for(int i=0;i<10;i++) {
				// 数据装入
				count item = totalList.get(i);
				dataSet.setValue(item.getTotal(), item.getWord(), item.getWord());
			}

		} 
		//创建一个JFreeChart图表
		JFreeChart chart = ChartFactory.createBarChart("统计图","汉字", "汉字数", dataSet, PlotOrientation.VERTICAL,false, true, false);
		chart.setBackgroundPaint(ChartColor.WHITE); // 设置总的背景颜色
		chart.setTitle(new TextTitle("识别汉字TOP排名",new Font("宋体",Font.BOLD+Font.ITALIC,20)));
		CategoryPlot plot=(CategoryPlot)chart.getPlot();//获得图标中间部分，即plot
		plot.setBackgroundPaint(ChartColor.LIGHT_GRAY);// 图形背景颜色
        CategoryAxis axis=plot.getDomainAxis();//获得横坐标
        axis.setLabelFont(new Font("宋体", Font.BOLD, 22)); // 设置X轴坐标上标题的文字
        axis.setTickLabelFont(new Font("宋体", Font.BOLD, 15)); // 设置X轴坐标上的文字
        ValueAxis valueAxis = plot.getRangeAxis();
        valueAxis.setLabelFont(new Font("宋体", Font.BOLD, 12)); // 设置Y轴坐标上标题的文字
        valueAxis.setTickLabelFont(new Font("sans-serif", Font.BOLD, 12));// 设置Y轴坐标上的文字
		try {
			String filename = ServletUtilities.saveChartAsPNG(chart, 500, 300, null, request.getSession());
			System.out.println("filename:"+filename);
			String graphURL = request.getContextPath() + "/chart?filename="+ filename;
			System.out.println("url:"+graphURL);
	        request.setAttribute("graphURL",graphURL);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "getTotal";
	}
}