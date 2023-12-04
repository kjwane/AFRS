package kr.board.entity;

import lombok.Data;

// Lombok API
// Lombok이란 직접 Setter와 Getter를 만들지 않아도 Lombok을 이용하면
// 자동으로 만들어줌
@Data // - Lombok API
// @Data 어노테이션이 있으면 우리 눈에 보이지는 않지만 getter와 setter를 자동으로 만들어준다.
public class Board {
	private int idx; // 번호
	private String title; // 제목
	private String content; // 내용 
	private String writer; // 작성자 
	private String indate; // 작성일
	private int count; // 조회수
	
// @Data 어노테이션을 안 쓰려면
// 우클릭 -> Source -> Getters and Setters
// 


}