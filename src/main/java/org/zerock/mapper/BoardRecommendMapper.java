package org.zerock.mapper;


import org.zerock.domain.BoardRecommendVO;

public interface BoardRecommendMapper {
	// 추천
	public int updateLike(Long bno);
	public int updateLikeCancel(Long bno);
	public int insertLike(BoardRecommendVO vo);
	public int deleteLike(BoardRecommendVO vo);
	public int updateLikeCheck(BoardRecommendVO vo);
	public int updateLikeCheckCancel(BoardRecommendVO vo);
	public int likeCheck(BoardRecommendVO vo);
	
	//비추천
	public int updateHate(Long bno);
	public int updateHateCancel(Long bno);
	public int insertHate(BoardRecommendVO vo);
	public int deleteHate(BoardRecommendVO vo);
	public int updateHateCheck(BoardRecommendVO vo);
	public int updateHateCheckCancel(BoardRecommendVO vo);
	public int hateCheck(BoardRecommendVO vo);
}