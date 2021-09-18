package com.web.service;

import java.util.Date;
import java.util.List;

import com.web.entity.PhotoRecord;

public interface photorecordService {
	//保存图片识别记录
	boolean savePhotoRecord(PhotoRecord PhotoRecord) ;
	//更新图片是否识别属性
	boolean updateRecognized(PhotoRecord PhotoRecord);
	//根据图片url获取图片记录
	PhotoRecord getPhotoRecordID(String jpgname) ;
	//根据图片url获取图片是否识别
	Integer selectRecognizedByUrl(String jpgname);
	//获取所有用户图片记录
	List<PhotoRecord> photoList();
	//根据用户id获取个人所有图片record_url
	List<String> personalPhotoList(Long userId);
	//根据图片记录查询图片识别信息
	PhotoRecord photoRecord(Long record);
	//根据用户id获取所有图片记录
	List<PhotoRecord> photoRecords(Long userId);
	List<PhotoRecord> getPhotoRecordByUserId(Long userId);
}
