package org.zerock.service;


import org.zerock.domain.BoardRecommendVO;

public interface BoardRecommendService {
	// 추천
	public void updateLike(Long bno) throws Exception;
	public void updateLikeCancel(Long bno) throws Exception;
	public void insertLike(BoardRecommendVO vo) throws Exception;
	public void deleteLike(BoardRecommendVO vo)throws Exception;
	public int likeCheck(BoardRecommendVO vo) throws Exception;
	public void updateLikeCheck(BoardRecommendVO vo)throws Exception;
	public void updateLikeCheckCancel(BoardRecommendVO vo)throws Exception;
	
	// 비추천
	public void updateHate(Long bno) throws Exception;
	public void updateHateCancel(Long bno) throws Exception;
	public void insertHate(BoardRecommendVO vo) throws Exception;
	public void deleteHate(BoardRecommendVO vo)throws Exception;
	public int hateCheck(BoardRecommendVO vo) throws Exception;
	public void updateHateCheck(BoardRecommendVO vo)throws Exception;
	public void updateHateCheckCancel(BoardRecommendVO vo)throws Exception;
}
