package org.zerock.service;



import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

// 설계할 때 인터페이스 규격을 설정해야함
public interface BoardService {
	// 계층별 사용하는 용어의 차이가 발생 -> mapping에서 잘 정리
	// register : 서비스 레이어에서 사용하는 용어  
	// persistence 계층에서는 insert 를 사용
	public void register(BoardVO board);
	public BoardVO get(Long bno);			// read
	public boolean modify(BoardVO board);	// update
	public boolean remove(Long bno);		// delete
//	public List<BoardVO> getList();
	public List<BoardVO> getList(Criteria cri);
	public int getTotal(Criteria cri);	
	public List<BoardAttachVO> getAttachList(Long bno);
	public void boardHit(Long bno);


}
