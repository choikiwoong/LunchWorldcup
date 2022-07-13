package org.zerock.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.log4j.Log4j;

@Log4j
// security 에서는 인증시 암호화를 수행함
// 테이블에 있는 데이터는 암호화가 적용되지 않은 상태이므로 암호화를 적용하지 않아야함
public class CustomNoOpPasswordEncoder implements PasswordEncoder {

	// 암호화를 적용한다면 암호화를 수행하는 부분을 추가
	@Override
	public String encode(CharSequence rawPassword) {
		log.info("before encode : " + rawPassword);
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		log.warn("matches: " + rawPassword + ":" + encodedPassword);
		return rawPassword.toString().equals(encodedPassword);
	}

}
