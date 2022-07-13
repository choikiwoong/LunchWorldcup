package org.zerock.domain;

import lombok.Data;

// 첨부파일에 대한 정보를 저장하는 빈

@Data
public class AttachFileDTO {
	private String fileName;	// 원본 파일의 이름
	private String uploadPath;	// 업로드 경로(다운로드, 표시할 때 필요)
	private String uuid;		// UUID 값 (데이터베이스를 접근할 때 필요)
	private boolean image;		// 이미지 여부
}
