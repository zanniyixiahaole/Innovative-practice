package com.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.dao.photorecordDao;
import com.web.entity.PhotoRecord;
import java.util.Date;
import com.web.service.photorecordService;
@Service
public class photorecordServiceImpl implements photorecordService{
	@Autowired
	private photorecordDao photorecordDao;
	@Override
	public boolean savePhotoRecord(PhotoRecord PhotoRecord) {
		// TODO Auto-generated method stub
		boolean flag = photorecordDao.savePhotoRecord(PhotoRecord);
		if(flag) {
			return true;
		}else		
			return false;
	}
	@Override
	public PhotoRecord getPhotoRecordID(String jpgname) {
		// TODO Auto-generated method stub
		return photorecordDao.getPhotoRecordID(jpgname);
	}
	@Override
	public List<PhotoRecord> photoList() {
		// TODO Auto-generated method stub
		List<PhotoRecord> recordList = photorecordDao.getAllPhotoRecord();
		return recordList;
	}
	@Override
	public List<String> personalPhotoList(Long userId) {
		// TODO Auto-generated method stub
		return photorecordDao.getPersonalPhotoUrls(userId);
	}

	@Override
	public PhotoRecord photoRecord(Long record) {
		// TODO Auto-generated method stub
		return photorecordDao.getPhotoRecordByRecord(record);
	}
	@Override
	public List<PhotoRecord> photoRecords(Long userId) {
		// TODO Auto-generated method stub
		return photorecordDao.getPhotoRecordByUserId(userId);
	}
	@Override
	public boolean updateRecognized(PhotoRecord PhotoRecord) {
		// TODO Auto-generated method stub
		return photorecordDao.updateRecognized(PhotoRecord);
	}
	@Override
	public Integer selectRecognizedByUrl(String jpgname) {
		// TODO Auto-generated method stub
		return photorecordDao.selectRecognized(jpgname);
	}
	
	@Override
	
	public List<PhotoRecord> getPhotoRecordByUserId(Long userId)
	{
		return photorecordDao.getPhotoRecordByUserId(userId);
	}

}
