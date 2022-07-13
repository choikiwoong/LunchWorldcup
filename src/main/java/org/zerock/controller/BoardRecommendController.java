package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.BoardRecommendVO;
import org.zerock.service.BoardRecommendService;

import lombok.AllArgsConstructor;


@Controller
@AllArgsConstructor	

public class BoardRecommendController {		
	
	private BoardRecommendService recommendService;
	
	@RequestMapping(value = "/board/updateLike" , method = RequestMethod.POST)
	@ResponseBody
	public int updateLike(BoardRecommendVO vo)throws Exception{
		
		int likeCheck = recommendService.likeCheck(vo);
		
		if(likeCheck == 0) {
			//좋아요 처음누름
			recommendService.insertLike(vo); 
			recommendService.updateLike(vo.getBno());
			recommendService.updateLikeCheck(vo);
			
		}else if(likeCheck == 1) {
			recommendService.updateLikeCheckCancel(vo); 
			recommendService.updateLikeCancel(vo.getBno()); 
			recommendService.deleteLike(vo); 
			
		}
		return likeCheck;
	}
	
	@RequestMapping(value = "/board/updateHate" , method = RequestMethod.POST)
	@ResponseBody
	public int updateHate(BoardRecommendVO vo)throws Exception{
		
		int hateCheck = recommendService.hateCheck(vo);
		
		if(hateCheck == 0) {
			
			recommendService.insertHate(vo);
			recommendService.updateHate(vo.getBno());
			recommendService.updateHateCheck(vo);
			
		}else if(hateCheck == 1) {
			recommendService.updateHateCheckCancel(vo);
			recommendService.updateHateCancel(vo.getBno());
			recommendService.deleteHate(vo);
		}
		return hateCheck;
	}
}