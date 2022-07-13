package org.zerock.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;
import org.zerock.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
// security에서 인증이 성공되면 사용자 정보와 권한 정보를 다뤄야함
public class CustomUserDetailsService implements UserDetailsService {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;

	// UserDetails : 사용자의 정보와 권한정보를 포함하는 인터페이스를 반환
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		log.warn("Load User By UserName : " + userName);
		// 회원정보를 가져옴
		MemberVO vo = memberMapper.read(userName);
		log.warn("queried by member mapper: " + vo);
		return vo == null ? null : new CustomUser(vo);
	}

}
