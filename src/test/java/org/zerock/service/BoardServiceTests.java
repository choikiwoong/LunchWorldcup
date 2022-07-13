package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	@Setter(onMethod_=@Autowired)
	private BoardService service;
	
	/*
	@Test
	public void testExists() {
		log.info(service);
		assertNotNull(service);	// assertNotNull : 객체의 null 여부 확인
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		service.register(board);
		log.info("생성된 게시물의 번호 : " + board.getBno());
	}	
	
	
	@Test
	public void testGetList() {
		service.getList().forEach(board-> log.info(board));
	}
	
	
	@Test
	public void testGet() {
		log.info(service.get(1L));
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
	*/
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setTitle("수정하는 글");
		board.setContent("수정하는 내용");
		board.setWriter("newbie 수정");
		board.setBno(1L);
		boolean result = service.modify(board);
		log.info("MODIFY RESULT: " + result);
		
		/*
		 * 위와 동일한 결과 BoardVO board = service.get(1L); if(board == null) { return; }
		 * board.setTitle("제목 수정합니다."); log.info("MODIFY RESULT: " +
		 * service.modify(board));
		 */
	}
	
	@Test
	public void testDelete() {
		boolean result = service.remove(2L);
		log.info("REMOVE RESULT:" + result);
		/*
		 * 위와 동일한 결과 log.info("REMOVE RESULT: " + service.remove(2L));
		 */
	}
	
	
	
	@Test
	public void testGetListWithPaging() {
		Criteria cri = new Criteria(2, 10);
		service.getList(cri).forEach(board -> log.info(board));
	}
}
