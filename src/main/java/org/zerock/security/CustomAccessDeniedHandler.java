package org.zerock.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.log4j.Log4j;


/*
접근이 허용되지 않은 페이지에 접근할 경우, 어떤처리를 하는 클래스를 정의할 수 있다.
AccessDenideHandler 인터페이스를 구현해야 한다.
	- 쿠키나 세션에 특정한 작업을 수행
	- HttpServletResponse에 특정한 헤더정보를 추가 : Client에서 추가 처리 할 수 있다
	- /accessError 페이지로 이동해서 접근 금지에 대한 안내를 한다.

 */
@Log4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.error("Access Denied Handler");
		log.error("Redirect...");
		response.sendRedirect("/accessError");
	}

}
