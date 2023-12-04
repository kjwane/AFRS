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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

// POJO라고 인식시키기 위해서 어노테이션을 써야함
// POJO란? => 프론트 컨트롤러가 해야할 일을 대신 해주는 클래스ㅋd.controller를 스캔한다
// 그래서 안에 있는 파일들을 실행시킨다.

@Controller
public class BoardController {
	
	@RequestMapping("/")
	public String main() {
		return "main";
	} // main()
	
} // BoardController