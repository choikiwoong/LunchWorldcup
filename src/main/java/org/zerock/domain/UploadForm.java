package org.zerock.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
//uploadForm의 input 값을 저장하는 객체
public class UploadForm {
	String desc;	// input 태그 name="desc"
	MultipartFile[] uploadFile;		// input 태그 name="uploadFile"

}
