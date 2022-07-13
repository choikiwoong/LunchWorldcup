package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {
	public void join(MemberVO member);
	public MemberVO profile(String userid);
	public int idCheck(String id);
	
}
