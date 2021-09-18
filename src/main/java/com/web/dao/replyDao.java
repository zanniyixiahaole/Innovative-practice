package com.web.dao;

import java.util.List;


import com.web.entity.Reply;

public interface replyDao {
	/**
	 * 根据userId查询该用户的所有回复
	 * @param userId
	 * @return
	 */
	List<Reply> getReplys(Long userId);
	void deleteReply(Long replyId);
	List<Reply> getReplysbyRid(Long resourceId);
	void addReply(Reply reply);
	List<Reply> getFeedbacks(Long userId);
}
