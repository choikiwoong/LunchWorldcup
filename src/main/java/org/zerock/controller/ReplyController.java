package org.zerock.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/replies/")
@Log4j
@AllArgsConstructor
public class ReplyController {
	private ReplyService service;

	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json", // Ajax를 사용해 JSON 형태로 댓글정보가 올라온다.
			produces = { MediaType.TEXT_PLAIN_VALUE })
	// ResponseEntity : Status 코드 + 데이터를 응답
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		log.info("ReplyVO : " + vo);

		int insertCount = service.register(vo); // 댓글 추가 성공1, 실패시 0
		log.info("Reply INSERT COUNT : " + insertCount);

		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); // 상태코드 500 출력
	}

	/*
	// 댓글 목록을 가져오는 기능을 추가
	@GetMapping(value = "/pages/{bno}/{page}", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<ReplyVO>> getList(
			@PathVariable("page") int page, 
			@PathVariable("bno") Long bno) {
		log.info("getList............");
		Criteria cri = new Criteria(page, 10);
		log.info(cri);
		return new ResponseEntity<List<ReplyVO>>(service.getList(cri, bno), HttpStatus.OK);
	}
	*/
	// 댓글 목록을 가져오는 기능을 추가 ( 위 코드와 차이점은 댓글의 갯수도 가져오는 차이)
	@GetMapping(value="/pages/{bno}/{page}",
			produces= {MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
			public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page,
					@PathVariable("bno") Long bno) {
				Criteria cri = new Criteria(page, 10);
				log.info("get Reply List bno: " + bno);
				log.info(cri);
				return new ResponseEntity<ReplyPageDTO>(service.getListPage(cri, bno), HttpStatus.OK);
			}

	
	@GetMapping(value="/{rno}", produces = {MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
		log.info("get: " + rno);
		return new ResponseEntity<ReplyVO>(service.get(rno), HttpStatus.OK);
	}
	
	
	// 댓글을 작성한 사람과 로그인 한사람이 같응ㄹ 경우 수정가능하게 함
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value="/{rno}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo,
			@PathVariable("rno") Long rno) {
		vo.setRno(rno);
		log.info("rno: " + rno);
		log.info("modify: " + vo);
		return service.modify(vo) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) :
			new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value="/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {
		log.info("remove: " + rno);
		log.info("replyer: " + vo.getReplyer());

		return service.remove(rno) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) :
			new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}



}