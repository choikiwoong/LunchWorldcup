package org.zerock.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

// controller에서 예외가 발생되면 실행되는 클래스를 정의, AOP의  공통처리부분(예외)
@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	// 모든 예외를 다 잡지 말고, security 관련 예외를 하도록 예외를 세분화 해야함
	@ExceptionHandler(Exception.class)	// Exception 예외가 발생되면 처리
	public String except(Exception ex, Model model) {
		log.error("Exception..." + ex.getMessage());
		model.addAttribute("exception",ex);
		log.error(model);
		return "error_page";
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)	// 응닫 code404
	public String handle404(NoHandlerFoundException ex) {
		// 
		return "custom404";
	}
}
