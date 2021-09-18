package com.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.web.entity.PhotoWord;

public interface photowordDao {
	boolean savePhotoWord(PhotoWord PhotoWord) ;
	//保存图片文字记录
	List<PhotoWord> selectByWordId(int wordId);
	//通过字id查询字表记录
	List<PhotoWord> selectByUserIdAndWordId(@Param("userId") Long userId,@Param("wordId")int wordId);
	//通过字id和用户id查询字表记录--查询个人信息的字识别记录
	List<PhotoWord> selectByRecord(Long record);
	//通过识别图片记录查询所有字记录
}
