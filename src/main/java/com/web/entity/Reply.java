package com.web.entity;

import java.util.Date;
import com.web.util.DateUtils;

public class Reply {
	private Long replyId;
	private Long userId;
	private Long resourceId;
	private Date replyDate;
	private String replyDatestr;
	public String getReplyDatestr() {
		if(replyDate!=null){
			replyDatestr = DateUtils.date2String(replyDate, "yyyy-MM-dd HH:mm:ss");
		}
		return replyDatestr;
	}
	public void setReplyDatestr(String replyDatestr) {
		this.replyDatestr = replyDatestr;
	}
	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}
	private String replyContent;
	public Long getReplyId() {
		return replyId;
	}
	public void setReplyId(Long replyId) {
		this.replyId = replyId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getResourceId() {
		return resourceId;
	}
	public void setResourceId(Long resourceId) {
		this.resourceId = resourceId;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	@Override
	public String toString() {
		return "Reply [replyId=" + replyId + ", userId=" + userId + ", resourceId=" + resourceId + ", replyDate="
				+ replyDate + ", replyDatestr=" + replyDatestr + ", replyContent=" + replyContent + "]";
	}

	

}
