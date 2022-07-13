package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data					// default 생성자만 생성
@AllArgsConstructor		// 모든 필드를 가지는 생성자 -> default 생성자가 사라짐
@NoArgsConstructor		// default 생성자를 다시 생성
public class SampleVO {
	private Integer mno;
	private String firstName;
	private String lastName;
}
