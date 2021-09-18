package com.web.entity;

import java.sql.Date;

public class WordSourceInfo {
	private Long userId;
	private String bookName;
	private String bookUrl;
	private Integer bookPage;
	private Integer recPage;
	private Date recBookDateTime;
	private String wordUrl;

	public WordSourceInfo(Long userId, String bookName, String bookUrl, Integer bookPage,
			Integer recPage, Date recBookDateTime, String wordUrl) {
		super();
		this.userId = userId;
		this.bookName = bookName;
		this.bookUrl = bookUrl;
		this.bookPage = bookPage;
		this.recPage = recPage;
		this.recBookDateTime = recBookDateTime;
		this.wordUrl = wordUrl;
	}
	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getBookUrl() {
		return bookUrl;
	}

	public void setBookUrl(String bookUrl) {
		this.bookUrl = bookUrl;
	}

	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public Integer getBookPage() {
		return bookPage;
	}
	public void setBookPage(Integer bookPage) {
		this.bookPage = bookPage;
	}
	public Integer getRecPage() {
		return recPage;
	}
	public void setRecPage(Integer recPage) {
		this.recPage = recPage;
	}
	public Date getRecBookDateTime() {
		return recBookDateTime;
	}
	public void setRecBookDateTime(Date recBookDateTime) {
		this.recBookDateTime = recBookDateTime;
	}
	public String getWordUrl() {
		return wordUrl;
	}
	public void setWordUrl(String wordUrl) {
		this.wordUrl = wordUrl;
	}
	@Override
	public String toString() {
		return "WordSourceInfo [userId=" + userId + ", bookName=" + bookName
				+ ", bookUrl=" + bookUrl + ", bookPage=" + bookPage + ", recPage=" + recPage + ", recBookDateTime="
				+ recBookDateTime + ", wordUrl=" + wordUrl + "]";
	}
}