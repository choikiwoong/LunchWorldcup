package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data	// lombok getter/setter/생성자/toString 을 자동으로생성
public class BoardVO {
	private long bno;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private Date updateDate;
	private String email;
	private int hit;
	
	private int replyCnt;
	
	private List<BoardAttachVO> attachList;
	private int likehit;
	private int hatehit;
	
}
