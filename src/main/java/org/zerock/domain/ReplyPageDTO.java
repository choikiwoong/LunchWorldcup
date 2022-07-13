package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {		// 댓글에 대한 페이지 처리를 위한 객체
	private int replyCnt;		// 댓글수
	private List<ReplyVO> list;	// 댓글목록
	// 페이징 처리를 위한 부분을 javascript로 이동( pageDTO 같은 경우 controller로 넘겼음)
}
