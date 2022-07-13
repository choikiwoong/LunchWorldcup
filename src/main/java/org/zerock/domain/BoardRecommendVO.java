package org.zerock.domain;

import lombok.Data;

@Data
public class BoardRecommendVO {
	// 공통
	private long bno;
	private String userid;
	
	// 추천
	private int likeno;
	private int likecheck;
	
	// 비추천
	private int hateno;	
	private int hatecheck;

}
