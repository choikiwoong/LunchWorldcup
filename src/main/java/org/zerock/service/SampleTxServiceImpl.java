package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.mapper.Sample1Mapper;
import org.zerock.mapper.Sample2Mapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j

public class SampleTxServiceImpl implements SampleTxService {

	@Setter(onMethod_ = {@Autowired})
	private Sample1Mapper mapper1;

	@Setter(onMethod_ = {@Autowired})
	private Sample2Mapper mapper2;

	@Transactional	// 트랜잭션 관리 기능을 적용
	@Override		
	// 두 개의 SQL 문이 모두 성공하면 commit이 수행되고
	// 하나라도 에러가 발생하면 원래 상태로 돌아감(롤백됨)
	public void addData(String value) {
		log.info("mapper1.....");
		mapper1.insertCol1(value);		// tbl_sample1 테이블 변경
		log.info("mapper2.....");
		mapper2.insertCol2(value);		// tbl_sample2 테이블 변경
		log.info("end.....");
	}

}
