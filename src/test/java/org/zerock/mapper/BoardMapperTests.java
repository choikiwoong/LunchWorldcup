package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	/*
	@Test
	public void testGetList() {
		mapper.getList().forEach(board->log.info(board));
	}
	
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로작성하는글");
		board.setContent("새로작성하는내용");
		board.setWriter("newbie");
		mapper.insert(board);
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새로작성하는글");
		board.setContent("새로작성하는내용");
		board.setWriter("newbie");
		mapper.insertSelectKey(board);
		log.info(board);
	}
	
	
	@Test
	public void testRead() {
		BoardVO board = mapper.read(22L);	// 현재 DB에 있는 게시글 번호를 사용해야함
		log.info(board);
	}
	
	
	@Test
	public void testDelete() {
		int result = mapper.delete(27L);
		log.info("게시물 삭제 : " + result);
	}
	
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(26L);
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용 수정");
		board.setWriter("newbie");
		int count = mapper.update(board);
		log.info("Update Count : " + count);	// 변경된 열의 개수가 출력
	}
	
	@Test
	public void testPaing() {
		Criteria cri = new Criteria();
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}

	
	
	@Test
	public void testPaing2() {
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board.getBno()));
	}
	
	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("으아");
		cri.setType("TCW");
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}
	 */
	@Test
	public void testSearch2() {
		Criteria cri = new Criteria();
		cri.setKeyword("으아");
		cri.setType("TCW");
		List<BoardVO> list = mapper.getListWithPaging2(cri);
		list.forEach(board -> log.info(board));
	}
	
}
