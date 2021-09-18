package com.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.dao.photowordDao;
import com.web.entity.PhotoWord;
import com.web.service.photowordService;
@Service
public class photowordServiceImpl implements photowordService{
	@Autowired
	private photowordDao photowordDao;
	@Override
	public boolean savePhotoWord(PhotoWord PhotoWord) {
		// TODO Auto-generated method stub
		return photowordDao.savePhotoWord(PhotoWord);
	}
	@Override
	public List<PhotoWord> getPhotoWordByUserIdAndWordId(Long userId, int wordId) {
		// TODO Auto-generated method stub
		return photowordDao.selectByUserIdAndWordId(userId,wordId);
	}
	@Override
	public List<PhotoWord> getPhotoWordByWordId(int wordId) {
		// TODO Auto-generated method stub
		return photowordDao.selectByWordId(wordId);
	}
	@Override
	public List<PhotoWord> getPhotoWordByRecord(Long record) {
		// TODO Auto-generated method stub
		return photowordDao.selectByRecord(record);
	}

}
