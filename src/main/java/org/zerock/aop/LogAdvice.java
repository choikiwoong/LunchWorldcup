package org.zerock.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

//공틍(로깅, 예외, 트랜잭션 처리) 기능을 수행하는 Advice 클래스
@Aspect		// AOP에서 사용하는 Aspect를 구현(공통기능을 구현)
@Log4j
@Component

public class LogAdvice {
	// @Before: BeforeAdvice - 타겟의 메소드가 실행되기전에 실행
	// execution : 메소드를 기준으로 pointcut(advice가 적용되는시점)을 설정
	// * : 접근 제한자
	// org.zerock.service.SampleService* : SampleService로 시작하는 모든 클래스
	// .* : 모든메소드
	// (..) : 매개변수
	@Before("execution(* org.zerock.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("===============================");
	}
	
	@Before("execution(* org.zerock.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
	
	@AfterThrowing(pointcut = "execution(* org.zerock.service.SampleService*.*(..))", throwing="exception")
	public void logException(Exception exception) {
	    log.info("Exception....!!!!");
	    log.info("exception: "+ exception);
	}
	
	@Around("execution(* org.zerock.service.SampleService*.*(..))")
	public Object logTime( ProceedingJoinPoint pjp) {
	    long start = System.currentTimeMillis();	    
	    log.info("Target: " + pjp.getTarget());
	    log.info("Param: " + Arrays.toString(pjp.getArgs()));
	    //invoke method 
	    Object result = null;
	    try {
	      result = pjp.proceed();	// 타겟을 실행시킴
	    } catch (Throwable e) {
	      e.printStackTrace();
	    }
	    long end = System.currentTimeMillis();
	    log.info("TIME: "  + (end - start));
	    return result;
	}


}
