package org.zerock.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class FileCheckTask {	
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper attachMapper;
	
	
	
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return str.replace("-", File.separator);
	}
	
	/*
	@Scheduled(cron="0 * * * * *")		// 매 분마다 동작함.
	public void checkFiles() throws Exception {
		log.warn("File Check Task run...");
		log.warn("=================================");
	}
	*/
	
	@Scheduled(cron="0 55 14 * * *")		// 매일 새벽 2시에 동작하도록 설정
	public void checkFiles() throws Exception {
		log.warn("File check task run.........");
		log.warn(new Date());		
		// 어제 날짜로 추가된 첨부파일 목록을 가져옴
				// 어제 날짜의 파일 정보를 가져옴
				// 데이터베이스에 없는 파일로 존재하는것을 삭제
		// file list in datebase
		
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();	// 데이터베이스 테이블
		
		// ready for check file in directory with database file list
		List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get("C:\\Java\\zzz\\upload",
			vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName())).collect(Collectors.toList());	// 파일에 대한 목록(존재하는) - 원본파일
		
		// image file has thumbnail file
		fileList.stream().filter(vo -> vo.isFileType() == true).map(vo -> 	Paths.get("C:\\Java\\zzz\\upload",
			vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))	// 섬네일
			.forEach(p -> fileListPaths.add(p));
		log.warn("=======================================");
		fileListPaths.forEach(p -> log.warn(p));		// 데이터베이스에 저장된 파일의 정보를 로깅
		
		// file in yesterday directory
		File targetDir = Paths.get("C:\\Java\\zzz\\upload", getFolderYesterDay()).toFile();
		// 파일이 데이터베이스 목록에 포함되지 않으면 배열에 추가 -> 삭제할 파일을 추가
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		if(removeFiles == null)	// null pointer exception 처리
			return;
		
		// 삭제할 파일이 존재하면
		log.warn("---------------------------------------");
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}




}
