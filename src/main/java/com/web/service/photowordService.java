package com.web.service;

import java.util.List;

import com.web.entity.PhotoWord;

public interface photowordService {
	boolean savePhotoWord(PhotoWord PhotoWord) ;
	//保存图片文字记录
	List<PhotoWord> getPhotoWordByUserIdAndWordId(Long userId,int wordId);
	//通过字id和用户id查询字表记录--查询个人信息的字识别记录
	
	List<PhotoWord> getPhotoWordByWordId(int wordId);
	//通过字id查询字表记录
	List<PhotoWord> getPhotoWordByRecord(Long record);
	//通过识别图片记录查询所有字记录
}
