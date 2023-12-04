package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.board.entity.Board;
import kr.board.entity.Member;

@Mapper // - Mybatis API
public interface MemberMapper {
	public Member registerCheck(String memID);
	public int register(Member m); // 회원등록( 성공 1, 실패 0)
	public Member memLogin(Member mvo); // 로그인 체크
	public int memUpdate(Member mvo); // 수정하기
	public Member memLoginAdmin(Member mvo_admin); // 관리자_로그인 체크
	
} // interface BoardMapper
