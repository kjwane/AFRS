package kr.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.board.entity.Member;
import kr.board.mapper.MemberMapper;

@Controller
public class MemberController {
	
	@Autowired
	MemberMapper memberMapper;
	
	@RequestMapping("/memJoin.do")
	public String memJoin() {
		return "member/join";
	} // memJoin
	
	@RequestMapping("/memRegisterCheck.do")
	public @ResponseBody int memRegisterCheck(@RequestParam("memID") String memID) {
		Member m = memberMapper.registerCheck(memID);
		if(m != null || memID.equals("")) {
			return 0; // 이미 존재하는 회원, 입력 불가한 아이디
		} // if
		return 1; // 사용가능한 아이디
	} // memRegisterCheck

	// 회원가입처리
	@RequestMapping("/memRegister.do")
	public String memRegister(Member m, String memPassword1, String memPassword2,
			RedirectAttributes rttr, HttpSession session) { // memRegister
		
		if(m.getMemID()==null || m.getMemID().equals("") ||
		   memPassword1==null || memPassword1.equals("") ||
		   memPassword2==null || memPassword2.equals("") ||
		   
		   m.getMemName()==null || m.getMemName().equals("") ||
		   m.getMemAge()==0 ||
		   m.getMemGender()==null || m.getMemGender().equals("") ||
		   m.getMemEmail()==null || m.getMemEmail().equals("")) {
		   // 누락 메시지를 가지고 가기 => 객체바인딩(Model, HttpServletRequest, HttpSession)
		   rttr.addFlashAttribute("msgType", "실패 메시지");
		   rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			
		   return "redirect:/memJoin.do"; // ${msgType}, ${msg} 
		   
		} // if
		if(!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			
			return "redirect:/memJoin.do"; // ${msgType}, ${msg}
		} // if
		
		// 회원을 테이블에 저장하기
		int result = memberMapper.register(m);
		if(result==1) { // 회원가입 성공 메시지
			rttr.addFlashAttribute("msgType", "성공 메시지");
			rttr.addFlashAttribute("msg", "회원가입에 성공했습니다.");
			
			// 회원가입이 성공하면 => 로그인 처리하기
			session.setAttribute("mvo", m); // ${!empty mvo} empty상태라면 회원가입 안 한 거임
			return "redirect:/";
			
		}else {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "이미 존재하는 회원입니다.");
			
			return "redirect:/memJoin.do";
		} // if, else
		
	} // memRegister
	
	// 로그아웃 처리
	@RequestMapping("/memLogout.do")
	public String memLogout(HttpSession session) {
		// invalidate => 세션 끊기
		session.invalidate();
		return "redirect:/";
		
	} // public String memLogout
	
	// 로그인 화면으로 이동
	@RequestMapping("/memLoginForm.do")
	public String memLoginForm() {
		return "member/memLoginForm"; // memLoginForm.jsp
		
	} // public String memLoginForm()
	
	
	@RequestMapping("memLogin.do")
	public String memLogin(Member m, RedirectAttributes rttr,
							HttpSession session) {
		if(m.getMemID()==null || m.getMemID().equals("") ||
			m.getMemPassword()==null || m.getMemPassword().equals("")) {
			
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력해주세요.");
			
			return "redirect://memLoginForm.do";
			
		} // if
			
		Member mvo=memberMapper.memLogin(m);
		
		if(mvo!=null) { // 로그인에 성공했을 경우
			rttr.addFlashAttribute("msgType", "성공 메시지");
			rttr.addFlashAttribute("msg", "로그인에 성공했습니다.");
			session.setAttribute("mvo", mvo); // ${!empty mvo}
			return "redirect:/"; // 메인으로 돌아가기
			
		}else { // 로그인에 실패
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "다시 로그인 해주세요.");
			
			return "redirect://memLoginForm.do"; // 메인으로 돌아가기
		} // if, else
		
	} // String memLogin

	@RequestMapping("/memUpdateForm.do")
	public String memUpdateForm() {
		return "member/memUpdateForm";
		
	} // public String memUpdateForm()
	
	@RequestMapping("/memUpdate.do")
	public String memUpdate(Member m, RedirectAttributes rttr, 
							String memPassword1, String memPassword2,
							HttpSession session) { // memUpdate
		// memUpdate// memUpdate// memUpdate// memUpdate// memUpdate
		if(m.getMemID()==null || m.getMemID().equals("") ||
		   memPassword1==null || memPassword1.equals("") ||
		   memPassword2==null || memPassword2.equals("") ||
		   
		   m.getMemName()==null || m.getMemName().equals("") ||
		   m.getMemAge()==0 ||
		   m.getMemGender()==null || m.getMemGender().equals("") ||
		   m.getMemEmail()==null || m.getMemEmail().equals("")) {
		   // 누락 메시지를 가지고 가기 => 객체바인딩(Model, HttpServletRequest, HttpSession)
		   rttr.addFlashAttribute("msgType", "실패 메시지");
		   rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			
		   return "redirect:/memUpdateForm.do"; // ${msgType}, ${msg} 
		} // if
		
		if(!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
			
			return "redirect:/memUpdateForm.do"; // ${msgType}, ${msg}
		} // if
		
		// 회원을 수정 및 저장하기
		int result = memberMapper.memUpdate(m);
		if(result==1) { // 수정 성공 메시지
			rttr.addFlashAttribute("msgType", "성공 메시지");
			rttr.addFlashAttribute("msg", "회원정보를 수정했습니다.");
			
			// 회원수정이 성공하면 => 로그인 상태 유지
			session.setAttribute("mvo", m); // ${!empty mvo} empty상태라면 회원가입 안 한 거임
			return "redirect:/";
			
		}else {
			rttr.addFlashAttribute("msgType", "실패 메시지");
			rttr.addFlashAttribute("msg", "회원정보 수정에 실패했습니다.");
			
			return "redirect:/memUpdateForm.do";
		} // if, else
	} // public String memUpdate()
	
	
	
	
	

	
	

} // MemberController