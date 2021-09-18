package com.web.dao;

import org.apache.ibatis.annotations.Param;

import com.web.entity.word;

public interface wordDao {
	word selectword_id(@Param("word") String word) ;
	//通过字查询字的id  直接映射
	word selectByWordId(String word);
	//通过字查询字的id  resultmap存在问题？？
}
