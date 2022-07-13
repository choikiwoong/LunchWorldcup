package org.zerock.mapper;

import org.zerock.domain.BoardVO;
import org.zerock.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userid);

	/* public BoardVO read2(String writer); */
	public void insert(MemberVO member); 
	public void select(MemberVO member); 
	public String idCheck(String userid);
}
