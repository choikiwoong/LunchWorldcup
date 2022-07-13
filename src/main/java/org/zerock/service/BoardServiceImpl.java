package org.zerock.service;

import java.awt.print.Pageable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service			// 서비스로 동작함을 스프링에 알림 -> 주입 받기위함
@AllArgsConstructor	// 생성자 사용해 Mapper를 주입받기 위함
/*
 서비스 로직 수행
 데이터베이스 처리 : BoardMapper 연동
 */

public class BoardServiceImpl implements BoardService {
	//@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;

	//@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper attachMapper;

	@Transactional
	@Override
	public void register(BoardVO board) {
		// 각자 필요한 기능을 구현할 줄 알아야함 
		log.info("register..." + board);
		mapper.insertSelectKey(board);
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});

	}

	@Override
	// 게시글 상세보기
	public BoardVO get(Long bno) {
		log.info("get..." + bno);
		mapper.boardHit(bno);
		return mapper.read(bno);
	}

	// 문제점 : 첨부파일 삭제시, 첨부파일의 파일이 계속 존재하는 문제가 있음
	// 스프링 배치 작업을 이용해 주기적으로 삭제를 해줌
	// 문제점 : 삭제된 파일의 정보를 남아있는 파일과 구별하지 않아 알수가 없음
	@Transactional
	@Override
	// 게시글 수정
	public boolean modify(BoardVO board) {
		log.info("modify..." + board);
		//return mapper.update(board) == 1;	// 1:true , 0:false
		
		// 첨부파일 정보를 삭제
		attachMapper.deleteAll(board.getBno());
		// 첨부파일 정보를 추가
		boolean modifyResult = mapper.update(board) == 1;
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}

	@Transactional
	@Override
	// 게시글 삭제
	public boolean remove(Long bno) {
		log.info("remove..." + bno);
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;		// 1:true , 0:false
	}

	/*
	@Override
	// 전체 게시글 보기
	public List<BoardVO> getList() {
		log.info("getList...");
		return mapper.getList();
	}
	*/
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with Criteria: " + cri);
		//return mapper.getListWithPaging(cri);
		return mapper.getListWithPaging2(cri);

	}
	
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	// 특정게시글의 첨부파일 목록을 가져옴
	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno " + bno);
		return attachMapper.findByBno(bno);
	}

	@Override
	public void boardHit(Long bno) {
		mapper.boardHit(bno);
	}

	


}
