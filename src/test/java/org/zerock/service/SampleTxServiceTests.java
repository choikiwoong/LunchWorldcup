package org.zerock.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})

public class SampleTxServiceTests {
	@Setter(onMethod_ = {@Autowired})
	private SampleTxService service;
	
	//@Test
	// 50바이트 보다 큰 데이터를 저장
	// tbl_sample1에는 성공적으로 저장되지만
	// tbl_sample2에는 에러가 발생
	public void testLong() {	
		String str = "Starry\r\n" + 
				"Starry night\r\n" +
				"Paint your palette blue and grey\r\n" +
				"Look at on a summer's day";
		log.info(str.getBytes().length);
		service.addData(str);
	}
	
	
	@Test
	public void testNormal() {
		String str = "May 2";
		log.info(str.getBytes().length);
		service.addData(str);
	}
}
