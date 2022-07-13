package org.zerock.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.MemberVO;
import org.zerock.service.BoardService;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	private MemberService service;
	private BoardService service2;
	
	
	@GetMapping("/join")
	public void join() {
		
	}
	
	@PostMapping("/join")
	public String join(MemberVO member, RedirectAttributes rttr) {
		log.info("================================");
		log.info("register: " + member);
		service.join(member);
		rttr.addFlashAttribute("result", member.getUserid());
		return "redirect:/customLogin";
	}
	
	
	@GetMapping("/profile")
	@PreAuthorize("isAuthenticated()")
	public void profile(@RequestParam("userid") String userid, MemberVO member, Model model) {
		log.info("/profile");
		model.addAttribute("member", service.profile(userid));
		
		
	}
	
	@GetMapping("/idCheck")
	public void idCheck(String userid, Model model) {
		int result = service.idCheck(userid);
		model.addAttribute("userid", userid);
		model.addAttribute("result", result);
		
	}
	
}
