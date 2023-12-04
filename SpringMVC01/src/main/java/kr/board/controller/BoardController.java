package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

// POJO라고 인식시키기 위해서 어노테이션을 써야함
// POJO란? => 프론트 컨트롤러가 해야할 일을 대신 해주는 클래스
// 서버를 실행시키면 servlet-context.xml 파일로 가서 kr.board.controller를 스캔한다
// 그래서 안에 있는 파일들을 실행시킨다.

@Controller
public class BoardController {
	// @Autowired는 의존성 주입을 말한다 => DI라고 함 => Dependency Injection
	@Autowired 
	private BoardMapper mapper;
	
	// entity는 게시판의 구조를 만듦 -> 번호, 제목, 내용, 작성자 등
	// table과 관계를 맺어야하기 때문에 간단하게 클래스 이름을 Board라고 씀
	// Spring에서는 프론트컨트롤러가 만들어져있어서 프론트 컨트롤러를 만들 필요가 없기 때문에
	// Controller를 가장 먼저 만드는 거임
	// 그래서 최초의 시작은 Controller이다.
	// 이 컨트롤러가 클라이언트의 요청을 받아서 처리함
	// /boardList.do 라는 요청이 있다면
	// 게시판리스트를 DB에서 가져와서 보여줘야 함
	// 따라서 이 요청을 받으려면? 어노테이션을 써야함
	// HandlerMapping
	@RequestMapping("/boardList.do")
	// /boardList.do => 핸들이라고 부름
	// boardList.do라는 요청이 오면? 메서드를 실행해라라는 의미
	// DB 연동이 되면 객체 바인딩을 해야함 => 객체 바인딩이란 DB에서 가져온 전체 리스트를
	// 어떤 메모리에다가 set attribute를 하고 forwarding이 될 때 값을 꺼내가는 것
	// 이것과 같은 역할을 하는 게 스프링 MVC에서는 핸들러맵핑이라고 함
	// 핸들러 어댑터를 통해 실질적으로 메서드를 실행한다.
	// 핸들러 맵핑은 어노테이션을 써놓은 
	public String boardList(Model model) {
	
		/*
		 * Board vo = new Board(); vo.setIdx(1); vo.setTitle("게시판실습");
		 * vo.setContent("게시판실습"); vo.setWriter("김주완"); vo.setIndate("2023-11-07");
		 * vo.setCount(0);
		 * 
		 * List<Board> list = new ArrayList<Board>(); list.add(vo); list.add(vo);
		 * list.add(vo);
		 */
		
		List<Board> list = mapper.getLists();
		model.addAttribute("list", list);
		
		return "boardList"; // /WEB-INF/views/boardList.jsp 
		// 리턴은 프론트 컨트롤러한테 다음 페이지는 이쪽JSP로 넘어가면 된다고 하는 뷰의 경로를 넘겨주는 것임
		// JSP쪽으로 포워딩 되는 거임
		// 스프링에서는 model 이라는 객체를 이용해서 setAttribute, getAttribute를 할 수 있음
		// 리퀘스트 객체로 받을 때 JSP에서는 $기호로 받을 수 있음
		// EL -> Expression Language -> $기호로 받는 것을의미함
		
	} // boardList()
	
	// a태그로 요청을 할 때 받으려면 GetMapping을 써야함
	@GetMapping("/boardForm.do")
	public String boardForm() {
		return "boardForm"; // boardForm.jsp
	} // boardForm()
	
	@PostMapping("boardInsert.do")
	public String boardInsert(Board vo) { // 파라미터의 수집은 Board vo가 함
		mapper.boardInsert(vo); // 등록
		return "redirect:/boardList.do"; // redirect
	} // boardForm()
	
	@GetMapping("boardContent.do")
	public String boardContent(@RequestParam("idx") int idx, Model model) {
		// 여러 개를 동시에 받을 때는 Board vo를 쓰지만
		// 단일 값을 받을 때는 RuquestParam으로 받음
		// int idx를 쓴 이유는 리퀘스트 파람으로 받아온 idx값을 idx라는 변수에 담기 위해서임
		// 파람으로 받아오는 값(idx)과 담으려는 변수(idx)명이 같다면
		//RequestParam("idx")는 생략 가능
		
		Board vo = mapper.boardContent(idx);
		// 조회수 증가
		mapper.boardCount(idx);
		
		model.addAttribute("vo", vo);
		// 이렇게 하고 나서 boardContet.jsp에서 vo에 있는 것을 꺼내가서 상세보기 페이지를 만들어주면 됨
		
		return "boardContent"; // boardContent.jsp	
	} // boardContent
	
	@GetMapping("/boardDelete.do/{idx}")
	public String boardDelete(@PathVariable("idx") int idx)  {
		// idx 해당하는 값을 DB에서삭제해야하니까 맵퍼에 가서 삭제함수를 만들어야함
		mapper.boardDelete(idx);
		return "redirect:/boardList.do";
	}// boardDelete
	
	@GetMapping("boardUpdateForm.do/{idx}")
	public String boardUpdateForm(@PathVariable("idx") int idx, Model model) {
		Board vo = mapper.boardContent(idx);
		model.addAttribute("vo", vo);
		
		return "boardUpdate"; // boardUpdate.jsp
		
	} // boardUpdateForm
	
	@PostMapping("/boardUpdate.do")
	public String boardUpdate(Board vo) { // idx, title, content 총 3개가 넘어옴 2개 이상이니까 vo
		mapper.boardUpdate(vo); // 수정에서 수정
		return "redirect:/boardList.do";
	} // boardUpdate
	
}