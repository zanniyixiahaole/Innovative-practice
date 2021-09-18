package com.web.service;


import com.web.entity.word;

public interface wordService {
	word selectword_id(String word) ;
	//通过字查询字的id  直接映射
	word getWord(String word);
	//通过字查询字的id  resultmap存在问题？？
}
