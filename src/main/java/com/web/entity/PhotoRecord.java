package com.web.entity;

import java.util.Date;
import java.util.List;

public class PhotoRecord {
	private Long record;
	private Long userId;
	private Date dateTime;
	private String recordUrl;
	private Integer recognized;
	private Users user;//一对一
	private List<PhotoWord> wordList;
	public Long getRecord() {
		return record;
	}
	public void setRecord(Long record) {
		this.record = record;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Date getDateTime() {
		return dateTime;
	}
	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}
	public String getRecordUrl() {
		return recordUrl;
	}
	public void setRecordUrl(String recordUrl) {
		this.recordUrl = recordUrl;
	}
	public Integer getRecognized() {
		return recognized;
	}
	public void setRecognized(Integer recognized) {
		this.recognized = recognized;
	}
	public PhotoRecord(Long record, Long userId, Date dateTime, String recordUrl, Integer recognized) {
		super();
		this.record = record;
		this.userId = userId;
		this.dateTime = dateTime;
		this.recordUrl = recordUrl;
		this.recognized = recognized;
	}
	public PhotoRecord() {
		super();
	}
	@Override
	public String toString() {
		return "PhotoRecord [record=" + record + ", userId=" + userId + ", dateTime=" + dateTime + ", recordUrl="
				+ recordUrl + ", recognized=" + recognized + ", user=" + user + ", wordList=" + wordList + "]";
	}
	public List<PhotoWord> getWordList() {
		return wordList;
	}
	public void setWordList(List<PhotoWord> wordList) {
		this.wordList = wordList;
	}
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	
}
