package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	private Long[] bnoArr = {2560L,2559L,2558L,2557L,2556L};
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1,10).forEach(i->{
			ReplyVO vo = new ReplyVO();
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글테스트" + i);
			vo.setReplyer("replyer" + i);
			mapper.insert(vo);
		});
	}
		
	//@Test
	public void testRead() {
		// 댓글 번호 : 위에서 추가한 1~10 중 하나를 사용
		Long targetRno = 5L;
		ReplyVO vo = mapper.read(targetRno);
		log.info(vo);
	}
	
	//@Test
	public void testDelete() {
		Long targetRno = 5L;
		mapper.delete(targetRno);	
	}
	
	//@Test
	public void testUpdate() {
		Long targetRno = 10L;
		ReplyVO vo = mapper.read(targetRno);
		vo.setReply("Update Reply");
		int count = mapper.update(vo);
		log.info("변경된 댓글의 수 : " + count);
	}
	
	//@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[1]);
		replies.forEach(reply-> log.info(reply));
	}
	
	//@Test
	public void testList2() {
		Criteria cri = new Criteria(1, 10);		// 충분한 수의 댓글을 추가하고 시험한다.
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 72L);	// bno = 30
		replies.forEach(reply -> log.info(reply));
	}

	
}
