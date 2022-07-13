package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

// 화면정의서, 요구기능서를 토대로 필요기능(메소드), 인터페이스(서비스,매퍼간의 정합 )정의
// 반환형, 메소드이름, 매개변수
public interface BoardMapper {
	//@Select("select * from s_board where bno>0")
	public List<BoardVO> getList();
	public void insert(BoardVO board);			// bno를 알 필요 없을때
	public void insertSelectKey(BoardVO board);	// bno를 사용해야 할 때
	
	// 게시글 상세 보기
	public BoardVO read(long bno);	
	// 게시글 삭제
	public int delete(Long bno);	// 반환형 :삭제된 열의 개수 - 삭제되면 1, 안되면 0이 출력
	// 게시글 수정
	public int update(BoardVO board);
	public void boardHit(long bno);
	
	// 페이징을 고려한 게시글 목록 보기
	public List<BoardVO> getListWithPaging(Criteria cri);	// 페이지 번호, 페이지당 게시글 수
	public List<BoardVO> getListWithPaging2(Criteria cri);	// 12c에 추가된 기능 사용

	
	public int getTotalCount(Criteria cri);	// 검색조건 떄문에 Criteria를 매개변수로 사용
	
	
	// MyBatis 에서는 매개변수로 하나만 전달되기 떄문에, 2개이상 전달하려면 @Param 어노테이션을 사용
	// Map을 사용하거나 클래스를 사용
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);

	
}