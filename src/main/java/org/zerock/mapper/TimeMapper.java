package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;

// 구현객체는 MyBatis가 내부적으로 자동으로 생성을 해준다.
// 프로그래머는 신경쓸 필요가 없음
public interface TimeMapper {
	// 메소드위에 어노테이션을 사용해서 SQL문을 작성하는 방법
	@Select("select sysdate from dual")
	public String getTime();	// 현재시간 정보를 가져온다.
	
	public String getTime2();	// Interface + XML mapper를 사용하는 방법
}
