package org.zerock.service;

import org.springframework.stereotype.Service;

// AOP : 핵심기능이 동ㅈ가하면서 필요한 공통기능을 추가하지 않고도 사용할 수 있다.
@Service	// spring으로 부터 주입 받도록 설정
public class SampleServiceImpl implements SampleService {
	@Override
	public Integer doAdd(String str1, String str2) throws Exception {
		return Integer.parseInt(str1) + Integer.parseInt(str2);
	}
}
