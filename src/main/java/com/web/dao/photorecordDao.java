package com.web.dao;
import java.util.List;

import com.web.entity.PhotoRecord;

public interface photorecordDao {
	boolean savePhotoRecord(PhotoRecord PhotoRecord) ;
	//保存图片识别记录
	
	boolean updateRecognized(PhotoRecord PhotoRecord);
	//更新图片是否识别属性
	PhotoRecord getPhotoRecordID(String jpgname) ;
	//根据图片url获取图片记录
	Integer selectRecognized(String jpgname);
	//根据图片url获取图片是否识别
	List<PhotoRecord> getAllPhotoRecord();
	//获取所有图片记录
	List<String> getPersonalPhotoUrls(Long userId);
	//根据用户id获取个人所有图片record_url
	List<PhotoRecord> getPhotoRecordByUserId(Long userId);
	//根据用户id获取所有图片记录
	PhotoRecord getPhotoRecordByRecord(Long record);
	//根据图片记录查询图片识别信息
	
}
