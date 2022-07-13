package org.zerock.service;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardRecommendVO;
import org.zerock.mapper.BoardRecommendMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BoardRecommendServiceImpl implements BoardRecommendService {
	BoardRecommendMapper mapper;
	
	
	// 추천
	@Override
	public void updateLike(Long bno) throws Exception {
		mapper.updateLike(bno);
	}

	@Override
	public void updateLikeCancel(Long bno) throws Exception {
		mapper.updateLikeCancel(bno);
	}

	@Override
	public void insertLike(BoardRecommendVO vo) throws Exception {
		mapper.insertLike(vo);
	}

	@Override
	public void deleteLike(BoardRecommendVO vo) throws Exception {
		mapper.deleteLike(vo);
	}

	@Override
	public int likeCheck(BoardRecommendVO vo) throws Exception {
		return mapper.likeCheck(vo);
	}

	@Override
	public void updateLikeCheck(BoardRecommendVO vo) throws Exception {
		mapper.updateLikeCheck(vo);
	}

	@Override
	public void updateLikeCheckCancel(BoardRecommendVO vo) throws Exception {
		mapper.updateLikeCheckCancel(vo);
	}

	// 비추천
	@Override
	public void updateHate(Long bno) throws Exception {
		mapper.updateHate(bno);
	}

	@Override
	public void updateHateCancel(Long bno) throws Exception {
		mapper.updateHateCancel(bno);
	}

	@Override
	public void insertHate(BoardRecommendVO vo) throws Exception {
		mapper.insertHate(vo);
	}

	@Override
	public void deleteHate(BoardRecommendVO vo) throws Exception {
		mapper.deleteHate(vo);
	}

	@Override
	public int hateCheck(BoardRecommendVO vo) throws Exception {
		return mapper.hateCheck(vo);
	}

	@Override
	public void updateHateCheck(BoardRecommendVO vo) throws Exception {
		mapper.updateHateCheck(vo);
	}

	@Override
	public void updateHateCheckCancel(BoardRecommendVO vo) throws Exception {
		mapper.updateHateCheckCancel(vo);
	}
}
