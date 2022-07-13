package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor		// 생성자로 Service 객체를 주입받기위해
public class BoardController {
	private BoardService service;	// 스프링으로부터 주입을 받는다
	
	
	// 게시글 목록 보기
	/*
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		// view page : /board/list.jsp(url과 동일)
		model.addAttribute("list", service.getList());
	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
	}
	*/
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		int total = service.getTotal(cri);
		log.info("total: " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	
	// 게시글 추가
	// view page : /board/register.jsp
	@GetMapping("/register")	
	@PreAuthorize("isAuthenticated()")
	public void register() { }
	
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("================================");
		log.info("register: " + board);
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("================================");
		log.info("register: " + board);
		// 게시글 목록보기 페이지로 이동
		service.register(board);
		// 한번만 전달됨
//		return "/board/result";			// 반환을 redirect로 주지않을경우 작성완료된 페이지에서 새로고침시 작성하지 않더라도 기존 등록했던 게시글이 또 작성됨
		rttr.addFlashAttribute("result", board.getBno());	// 추가된 게시글 번호를 출력
		return "redirect:/board/list";
	}
	
	// 게시글 조회, 수정
	// board/get , board/modify - bno를 입력받아 게시글 정보를 보여주는 동일한 동작을 하기 때문 메소드를 같이 이용함
	@GetMapping({"/get", "/modify"}) 
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		/* 아래 결과와 동일
		log.info("/get" + bno);
		BoardVO board = service.get(bno);
		model.addAttribute("board", board);
		*/
		log.info("/get or /modify");
		//service.boardHit(bno);
		model.addAttribute("board", service.get(bno));
		
		
	}
	
	// 게시글 수정
	@PostMapping("/modify")
	@PreAuthorize("principal.username == #board.writer")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify: " + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		/* 아래 동일한 내용이 여러곳에서 쓰여 간단하게 메소드 처리
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		*/
		return "redirect:/board/list" + cri.getListLink();
	}
	
	// 게시글 삭제
	@PostMapping("/remove")
	@PreAuthorize("principal.username == #writer")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) {
		log.info("remove..." + bno);
		// 첨부파일에 대한 정보를 가져옴
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		if(service.remove(bno)) {	// 게시글 삭제가 성공한 경우
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		/* 아래 동일한 내용이 여러곳에서 쓰여 간단하게 메소드 처리
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		*/
		return "redirect:/board/list"  + cri.getListLink();
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		// 첨부파일이 존재하지 않으면 종료
		if(attachList == null || attachList.size() == 0) {
		      return;
		}
		    
		log.info("delete attach files...................");
		log.info(attachList);
		    
		attachList.forEach(attach -> {
			try {
				// 원본 파일 삭제
				Path file  = Paths.get("C:\\Java\\zzz\\upload\\"+attach.getUploadPath()+"\\" + attach.getUuid()+"_"+ attach.getFileName());
			    Files.deleteIfExists(file);
			    // 섬네일 삭제
			    if(Files.probeContentType(file).startsWith("image")) {
			    	Path thumbNail = Paths.get("C:\\Java\\zzz\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+ attach.getFileName());
			        Files.delete(thumbNail);
			     }
			}catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			}//end catch
		});//end forEach
	}


	@GetMapping(value = "/getAttachList",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList " + bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}


}
