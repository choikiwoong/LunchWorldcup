package org.zerock.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class SampleDTOList {
	private List<SampleDTO> list;
	
	// 생성자
	public SampleDTOList() {
		list = new ArrayList<SampleDTO>();	// 빈 ArrayList 생성
	}
}
