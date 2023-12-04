package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.board.entity.Board;

// 보드 맵퍼가 DAO임 =>스프링으로 넘어 오면서 인터페이스 보드 맵퍼가 된 거임
@Mapper // - Mybatis API
public interface BoardMapper {
	// Spring에서는 interface로 하면
	// 열고 닫는 구현부가 없어도
	// 인터페이스의 구현체인 sql-session-
	
	public List<Board> getLists();
	// 전체리스트를 가져오는 메서드
	// list와 연결해서 실행할 sql query문의 맵퍼 파일을 같은 디렉토리(kr.board.mapper)에 만들면 됨
	// 만드는 법은 New -> mapper -> mapper -> 파일명.xml
	// 파일명은 BoardMapper 인터페이스 파일명과 똑같은 파일로 만들어야 함
	// public List<Board> getLists(); 이 놈은 추상메서드라서 동작을 안 함
	// 그럼 어떻게 실행을 하느냐? 실행을 시키면 구현체가 동작이 되는데
	// 자동으로 만들어짐 그게 실행이 되는 거임
	
	public void boardInsert(Board vo);
	// void를 쓴 이유는 DB에서 다시 가져올 값이 없기 때문
	// 등록을 하고 나면? 다시 가져올 값이 없어서임
	// boardContent에서를 예시로 들면 이놈은 DB에서 번호의 인덱스를 가져와야 상세보기를
	// 활성화 시킬 수 있기 때문
	// 이 놈을 Controller가 호출하는 거임
	// 그리고 SQL Query와 연결이 됨 
	// Query쪽으로 넘어가는 파라미터를 어디다가 만들면된다? => Mapper
	
	public Board boardContent(int idx);
	public void boardDelete(int idx);
	public void boardUpdate(Board vo);
	
	// 어노테이션으로 맵퍼에 이렇게 적는 다면 xml에는(중복id는) 적으면 안 된다.
	@Update("update myboard set count = count + 1 where idx = #{idx}")
	public void boardCount(int idx);
	
} // interface BoardMapper

