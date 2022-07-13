package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;
import org.zerock.domain.Ticket;

import lombok.extern.log4j.Log4j;

//기존에는  Controller 어노테이션을 사용

@RestController		// REST API를 사용하는 컨트롤러
@RequestMapping("/rest")
@Log4j
public class RestSampleController {
	// @GetMapping : get 방식으로 처리
	// value : url을 의미
	// produces : 브라우저로 응답하는 contentType를 지정
	@GetMapping(value="/getText", produces="text/plain; charset=UTF-8")
	public String getText() {
		// RestController 와 Controller와 차이점 
		// Controller - view page 이름
		// RestController - 문자열 반환
		log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE);
		return "안녕하세요";
	}
	
	@GetMapping(value="/getSample",produces={MediaType.APPLICATION_JSON_UTF8_VALUE,MediaType.APPLICATION_XML_VALUE})
	public SampleVO getSample() {
		return new SampleVO(112, "스타", "로드");
	}
	
	// 객체 : List 형태로 응답
	@GetMapping(value = "/getList")
	public List<SampleVO> getList(){
		return IntStream.range(1, 10).mapToObj(i->new SampleVO(i,i+"First", i+"Last")).collect(Collectors.toList());
	}
	
	// 객체 : Map 형태로 응답
	@GetMapping(value = "/getMap")
	public Map<String, SampleVO> getMap(){
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First",new SampleVO(111, "그루트","주니어"));
		return map;
	}
	
	// 데이터 + 상태코드 : ResponseEntitiy 를 사용
	@GetMapping(value = "/check", params = {"height", "weight"})
	public ResponseEntity<SampleVO> check(Double height, Double weight){
		SampleVO vo =  new SampleVO(000, ""+height, "" + weight);
		ResponseEntity<SampleVO> result = null;
		if(height  < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);	// 개발자툴에서 상태코드 502 에러발생
		}else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		return result;
	}
	
	// 제품정보를 가져오기 url / product / {제품종류 cat} / {제품식별자 pid}
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") Integer pid) {
		return new String[] {"category : " + cat, "productid : " + pid};
	}
			
	
	// Client 로부터 객체 형태의 데이터를 입력받는 방법
	// @RequestBody : 브라우저로 부터 올라오는 데이터
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert ... ticket" + ticket);
		return ticket;
	}
	
}
