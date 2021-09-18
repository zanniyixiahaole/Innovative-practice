package com.web.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.dao.wordDao;
import com.web.entity.word;
import com.web.service.wordService;


@Service
public class wordServiceImpl implements wordService{
	@Autowired
	private wordDao wordDao;
	@Override
	public word selectword_id(String word) {
		//System.out.println(word);
		// TODO Auto-generated method stub
		return wordDao.selectword_id(word.toString());
	}
	@Override
	public word getWord(String word) {
		// TODO Auto-generated method stub
		return wordDao.selectByWordId(word);
	}

}
