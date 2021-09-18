package com.web.entity;

public class PhotoWord {
	private Long photoWordRecord;
	private Integer wordId;
	private Long photoRecord;
	private String wordUrl;
	public Long getPhotoWordRecord() {
		return photoWordRecord;
	}
	public void setPhotoWordRecord(Long photoWordRecord) {
		this.photoWordRecord = photoWordRecord;
	}
	public Integer getWordId() {
		return wordId;
	}
	public void setWordId(Integer wordId) {
		this.wordId = wordId;
	}
	public Long getPhotoRecord() {
		return photoRecord;
	}
	public void setPhotoRecord(Long photoRecord) {
		this.photoRecord = photoRecord;
	}
	public String getWordUrl() {
		return wordUrl;
	}
	public void setWordUrl(String wordUrl) {
		this.wordUrl = wordUrl;
	}
	public PhotoWord(Long photoWordRecord, Integer wordId, Long photoRecord, String wordUrl) {
		super();
		this.photoWordRecord = photoWordRecord;
		this.wordId = wordId;
		this.photoRecord = photoRecord;
		this.wordUrl = wordUrl;
	}
	public PhotoWord() {
		super();
	}
	@Override
	public String toString() {
		return "PhotoWord [photoWordRecord=" + photoWordRecord + ", wordId=" + wordId + ", photoRecord=" + photoRecord
				+ ", wordUrl=" + wordUrl + "]";
	}
	
	
}
