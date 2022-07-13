package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	// 댓글 추가 : 메소드이름, 매개변수, 봔환형
	public int insert(ReplyVO vo);	// 반환형 : 추가된 댓글의수
	public ReplyVO read(Long rno);	// 특정댓글 : 매개변수로 댓글 번호
	public int delete(Long rno);	// 트정댓글 :  
	public int update(ReplyVO reply);
		
	// 특정게시글의 댓글 목록을 가져온다
	// MyBatis에서 매개변수가 여러개 일 때, #param 어노테이션을 사용
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
	
	// 해당 게시글의 댓글의 수를 가져옴
	public int getCountByBno(Long bno);
}
