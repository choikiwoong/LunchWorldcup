package org.zerock.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	// 댓글을 추가, 삭제할때 게시글 테이블의 댓글 수를 갱신할때 사용
	@Setter(onMethod_=@Autowired)
	private BoardMapper boardMapper;

	@Transactional
	@Override
	public int register(ReplyVO vo) {
		log.info("register..." + vo);
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		return mapper.insert(vo);
	}
	
	@Override
	public ReplyVO get(Long rno) {
		log.info("get..." + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify..." + vo);
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("remove..." + rno);
		ReplyVO vo = mapper.read(rno);	// 댓글 정보를 가져오기
		boardMapper.updateReplyCnt(vo.getBno(), -1);	// 댓글의 수를 감수
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get Reply List of a Board" + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	// MySQL DB와 Oracle DB 동작이 다르기때문
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		//if(cri.getPageNum() == -1) { // MySQL 사용할 경우
		//	return new ReplyPageDTO(mapper.getCountByBno(bno), new ArrayList<ReplyVO>());
		//} else {
			return new ReplyPageDTO(mapper.getCountByBno(bno),
		 	mapper.getListWithPaging(cri, bno));
		//}

	}

}
