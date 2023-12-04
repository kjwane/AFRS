package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;


	// RestController를 쓰면 모든 메서드들은 @ResponseBody를 생략할 수 있다.
	// 기본적으로 ajax 통신할 때 쓰는 컨트롤러임
	// 그래서 원래 밑에 메서드들도 전부 @RestponseBody가 있었는데 지웠음
	
	@RequestMapping("/board")
	@RestController
	public class BoardRestController {
		// @Autowired boardMapper부터 Board boardCount까지 Controller에서
		// 잘라내기해서 가져왔음
		@Autowired
		BoardMapper boardMapper;
		
		@RequestMapping("/all")
		// Maven에 jackson 설치하고 난 후에
		// ResponseBody가 붙어있으면 jackson-databind가 자동으로 작동함
		// 역할은 객체를 JSON 데이터포멧으로 자동 변환 시켜줌
		public List<Board> boardList() {
			List<Board> list = boardMapper.getLists();
			return list; // JSON 데이터 형식으로 변환해서 리턴(=응답)하겠다는 의미
			// 여기서 main.jsp가 한 요청을 list로 return한다고 하심 => 지금 main을 통해 json파일로 변환하고 있기 때문에
			// 여기랑 통신하는 거 같음
			// 그리고 여기서 makeView로 응답을 함
		} // List<Board> boardList()
	
//		@RequestMapping("/boardInsert.do")
		@PostMapping("/new")
		public void boardInsert(Board vo) {
			boardMapper.boardInsert(vo); // 등록성공
		} // boardInsert
		
		@DeleteMapping("/{idx}")
		public void boardDelete(@PathVariable("idx") int idx) {
			boardMapper.boardDelete(idx);
		} // boardInsert
		
		@PutMapping("/update")
		public void boardUpdate(@RequestBody Board vo) {
			boardMapper.boardUpdate(vo);
		} // boardUpdate
		
		@GetMapping("/{idx}")
		public Board boardContent(@PathVariable("idx") int idx) {
			Board vo = boardMapper.boardContent(idx);
			return vo; // vo가 JSON object로 바껴서 success로 감 
		} // boardContent
		
		@PutMapping("/count/{idx}")
		public Board boardCount(@PathVariable("idx") int idx) {
			boardMapper.boardCount(idx);
			Board vo = boardMapper.boardContent(idx);
			return vo; 
		} // boardCount
		
		
	} // BoardRestController
