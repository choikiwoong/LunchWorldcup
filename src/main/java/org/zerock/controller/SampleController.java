package org.zerock.controller;

import java.util.ArrayList;
import java.util.Arrays;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.SampleDTOList;
import org.zerock.domain.TodoDTO;
import org.zerock.domain.TodoDTO2;

import lombok.extern.log4j.Log4j;

// Controller : 브라우저로부터 올라오는 요청을 처리하는 핸들러라고 생각하면 된다.
// property 파일에서 url-handler mapping과 유사한 개념

@Controller	// Controller로 동작
@RequestMapping("/sample/*")	// 브라우저로부터 올라오는 url을 지칭
	// 브라우저로부터 올라오는 /sample밑의 모든 url을 SampleController가 처리
@Log4j
public class SampleController {
	// 문자열 형태->Date 형태로 변환
//	@InitBinder
//	public void initBinder(WebDataBinder binder) {
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false));
//	}
	// 동시에 @initBinder와 @DateTimeFormat을 사용할 수 없음

	@RequestMapping("")		// 기타 url : 정의하지 않은 url을 처리하는 메소드
	public void basic() {	// 반환형 void : 뷰페이지 이름이 /sample/세부url
		log.info("basic...");
	}
	
	// 스프링 4.3 버전 이전에 표기방법
	// url : /sample/basic
	// method : GET, POST 두가지 방식에 대하여 동작한다.
	@RequestMapping(value="/basic", method= {RequestMethod.GET, RequestMethod.POST})
	public void basicGet() {
		log.info("basic get...");
	}	// view page 이름 : /sample/basic.jsp
	
	// 스프링 4.3 버전 이후의 표기방법
	// url : /sample/basicOnlyGet
	// method : GET
	@GetMapping("/basicOnlyGet")
	public void basicGet2() {
		log.info("basic get only get");
	}	// view page 이름 : /sample/basicOnlyGet (url 이름과 동일) <- 반환형이 void 일때
	
	@GetMapping("/ex01")	// url : /sample/ex01, method: GET
	public void ex01(SampleDTO dto) {
		log.info("" + dto);
	}	// view page : url과 동일 /sample/ex01.jsp
	
	// 브라우저로부터 올라오는 파라미터 이름과 저장하는 변수의 이름을 달리할 때, @RequestParam 어노테이션을 사용
	@GetMapping("/ex02")
	public void ex02(@RequestParam("name") String name2, @RequestParam("age") int age) {
		log.info("name: " + name2);
		log.info("age: " + age);
	}
	
	@GetMapping("/ex02Simple")
	public void ex02Simple(String name, int age) {
		log.info("name: " + name);
		log.info("age: " + age);
	}
	
	// 배열, List : input form의 checkbox나 select/option 태그를 사용하는 경우
	@GetMapping("/ex02List")
	public void ex02List(@RequestParam("ids") ArrayList<String> ids) {
		log.info("ids: " + ids);
	}
	
	@GetMapping("/ex02Array")
	public void ex02Array(@RequestParam("ids") String[] ids) {
		log.info("ids: " + Arrays.toString(ids));
	}
	
	@GetMapping("/ex02Bean")
	public void ex02Bean(SampleDTOList list) {
		log.info("list dtos: " + list);
	}
	
	@GetMapping("/ex03")
	public void ex03(TodoDTO todo) {
		log.info("todo: " + todo);
	}
	
	@GetMapping("/ex03Date")
	public void ex03Date(TodoDTO2 todo) {
		log.info("todo: " + todo);
	}
	
	// url : /sample/ex04
	// Spring MVC의 특성
	// 브라우저로부터 올라오는 파라미터 SampleDTO, page
	// 브라우저로 내려주는 데이터 : SampleDTO (객체 형태)
	// 기본 데이터 타입인 int page는 내려주지 않는다.
	@GetMapping("/ex04")
	public void ex04(SampleDTO dto, int page) {
		log.info("dto: " + dto);
		log.info("page: " + page);
	}	// view page 이름 : /sample/ex04.jsp

	// @ModelAttribute 어노테이션을 사용하면 기본 데이터 타입도 view page로 전달된다.
	@GetMapping("/ex04Model")
	public String ex04Model(SampleDTO dto, @ModelAttribute("page") int page) {
		log.info("dto: " + dto);
		log.info("page: " + page);
		return "/sample/ex04";	// url과 다른 view page 이름을 작성할 때
	}	// view page 이름 : /sample/ex04.jsp
	
	@GetMapping("/ex05")
	public void ex05() {
		log.info("/ex05...");
	}
	
	@GetMapping("/ex05String")
	public String ex05String() {	// 반환형 String : view page 이름을 별도로 응답하겠다
		log.info("/ex05String...");
		// url과 다른 view page 이름을 설정할 때 사용
		// void : /sample/ex05String.jsp
		// 2가지 : redirect -> response.sendRedirect("주소")
		//		 forwarding : 일반적인 방법
		return "/sample/ex05Str";	//view page : /sample/ex05Str
	}
	
	@GetMapping("/ex05red")
	public String ex05red() {
		log.info("/ex05red...");
		return "redirect:/sample/ex05";
	}
	
	// 응답으로JSON 또는 XML 형태의 데이터를 준다
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		log.info("/ex06");
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("홍길동");
		return dto;
	}
	
	@GetMapping("/ex07")
	public ResponseEntity<String>ex07(){
		log.info("/ex07");
		String msg = "{\"name\": \"홍길동\"}"; // JSON 객체 스트링
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json;charset=UTF-8");
		// msg : data
		// header : 헤더정보
		// HttpStatus.OK : 200 OK
		return new ResponseEntity<String>(msg,header,HttpStatus.OK);
	}
	
	@GetMapping("/exUpload")
	public void exUpload() {
		log.info("/exUpload...");
	}
	
	@PostMapping("/exUploadPost")	// 파일 저장은 별도로 처리해줘야함
	public void exUploadPost(ArrayList<MultipartFile>files) {
		files.forEach(file->{
			log.info("---------------");
			log.info("name= " + file.getOriginalFilename());
			log.info("size: " + file.getSize());

		});
	}
}
