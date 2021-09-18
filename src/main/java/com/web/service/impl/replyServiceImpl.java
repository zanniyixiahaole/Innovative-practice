package com.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.web.dao.replyDao;
import com.web.entity.Reply;
import com.web.service.replyService;
@Service
public class replyServiceImpl implements replyService{
	@Autowired
	private replyDao rdao;
	@Override
	public List<Reply> getReplys(Long userId,int page,int size) {
		PageHelper.startPage(page, size);
		List<Reply> list = rdao.getReplys(userId);
		return list;
	}
	@Override
	//@Transactional(propagation=Propagation.REQUIRED,readOnly=false)
	public void deleteReply(Long replyId) {
		// TODO Auto-generated method stub
		rdao.deleteReply(replyId);
	}
	@Override
	public void addReply(Reply reply) {
		// TODO Auto-generated method stub
		rdao.addReply(reply);
	}
	@Override
	public List<Reply> getFeedbacks(Long userId, int page, int size) {
		// TODO Auto-generated method stub
		PageHelper.startPage(page, size);
		List<Reply> list = rdao.getFeedbacks(userId);
		return list;
	}
	@Override
	public void deleteFeedback(Long replyId) {
		// TODO Auto-generated method stub
		rdao.deleteReply(replyId);
	}
}
