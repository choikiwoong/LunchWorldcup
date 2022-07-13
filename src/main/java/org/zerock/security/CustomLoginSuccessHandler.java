package org.zerock.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;


@Log4j
// 로그인 성공후에 처리를 하는 Handler를 추가 할 수 있다
// AuthenticationSuccessHandler 인터페이스를 구현
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// 로그인한 사용자의 권한을 사용하여 필요한 페이지로 이동하는것이 default동작이지만
		// 핸들러를 사용하여, 로그인한 사용자의 권한을 사용해 필요한 페이지로 이동
		// 전달되는 매개변수 authentication 에 접근 권한정보가 주어짐
		log.warn("Login Success");
		List<String> rolesNames = new ArrayList<String>();
		authentication.getAuthorities().forEach(authority -> {
			rolesNames.add(authority.getAuthority());
		});
		
		log.warn("ROLE NAMES: " + rolesNames);
		if(rolesNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/security/admin");
			return;
		} else if(rolesNames.contains("ROLE_MEMBER")) {
			response.sendRedirect("/security/member");
			return;
		}
		response.sendRedirect("/");
	}
}
