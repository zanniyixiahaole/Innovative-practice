package com.web.entity;

public class count {
	private Integer wordId;
	private Integer total;
	private String word;
	public Integer getWordId() {
		return wordId;
	}
	public void setWordId(Integer wordId) {
		this.wordId = wordId;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public count(Integer wordId, Integer total, String word) {
		super();
		this.wordId = wordId;
		this.total = total;
		this.word = word;
	}
	public count() {
		super();
	}
	@Override
	public String toString() {
		return "count [wordId=" + wordId + ", total=" + total + ", word=" + word + "]";
	}

}