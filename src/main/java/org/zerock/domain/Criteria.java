package org.zerock.domain;

import static org.springframework.test.web.client.match.MockRestRequestMatchers.queryParam;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 페이징 처리를 위한 데이터를 저장하는 클래스
@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	
	

	
	// default 생성자 : 파라미터 없을경우 1페이지와 10개로 설정
	public Criteria() { this(1, 10); }
	
	
	// 사용자가 보여줄 페이지 갯수를 지정
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	

	// type : T,C, W, TC, TW, CW, TCW (7가지 검색 유형)
	// 타입 문자열을 배열로 변환
	public String[] getTypeArr() { return type == null? new String[] { } : type.split(""); }

	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")		
		.queryParam("pageNum", this.pageNum)
		.queryParam("amount", this.amount)
		.queryParam("type", this.getType())
		.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}

	
}
