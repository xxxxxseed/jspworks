package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.repository.Board;
import com.repository.BoardDAO;
import com.repository.Member;
import com.repository.MemberDAO;


@WebServlet("*.do")		//url mapping - 확장자 .do인 모든 파일
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 2L;
	
	MemberDAO memberDAO;
	BoardDAO boardDAO;

	
	public void init(ServletConfig config) throws ServletException {
		memberDAO = new MemberDAO();
		boardDAO = new BoardDAO();
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String uri = request.getRequestURI();
		//StringBuffer url = (StringBuffer)request.getRequestURL();
		//System.out.println(uri);	
		//System.out.println(url);	//http://localhost:8080/memberForm.do
		
		String command = uri.substring(uri.lastIndexOf("/"));
		System.out.println(command);
		String nextPage = null;
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		if(command.equals("/memberForm.do")) {
			nextPage = "/memberForm.jsp";
		}else if(command.equals("/addMember.do")) {
			//가입 폼 입력값은 넘겨 받음
			String memberId = request.getParameter("memberId");
			String passwd = request.getParameter("passwd");
			String name = request.getParameter("name");
			String gender = request.getParameter("gender");
			
			//member 객체 set
			Member member = new Member();
			member.setMemberId(memberId);
			member.setPasswd(passwd);
			member.setName(name);
			member.setGender(gender);
			
			//회원 추가 dao
			memberDAO.addMember(member);
			request.setAttribute("msg", "register");	//model - msg 보냄
			
			//view
			nextPage = "/memberResult.jsp";
		
		
		}else if(command.equals("/memberList.do")) {
			//dao 목록 요청
			ArrayList<Member> memberList = memberDAO.getListAll();
			
			//model - 반환 자료
			request.setAttribute("memberList", memberList);
			//view
			nextPage = "/memberList.jsp";
		}else if(command.equals("/loginMember.do")) {	//로그인 화면 요청
			nextPage = "/loginMember.jsp";
		}else if(command.equals("/loginProcess.do")) {	//로그인 인증 처리
			String memberId = request.getParameter("memberId");
			String passwd = request.getParameter("passwd");

			//db 처리
			boolean result = memberDAO.checkLogin(memberId, passwd);
			String name = memberDAO.getNameByLogin(memberId);
			
			if(result){
				session.setAttribute("sessionId", memberId);	//세션 발급
				session.setAttribute("name", name);				//이름 세션 발급
				request.setAttribute("msg", "login");			//model - msg를 보냄
				nextPage = "/memberResult.jsp";
			}else{
				out.println("<script>");
				out.println("alert('아이디나 비밀번호를 확인해 주세요')");
				out.println("history.go(-1)");
				out.println("</script>");
			}
		}else if(command.equals("/logout.do")) {
			session.invalidate();
			nextPage = "/main.jsp";
		}else if(command.equals("/memberView.do")) {
			//나의 정보를 클릭하면 상세 보기
			String memberId = (String)session.getAttribute("sessionId");
			Member member = memberDAO.getMember(memberId);
			
			//model an view
			request.setAttribute("member", member);
			nextPage = "/memberView.jsp";
		}else if(command.equals("/deleteMember.do")) {
			//회원 삭제 처리
			String memberId = request.getParameter("memberId");
			
			memberDAO.deleteMember(memberId);
			
			nextPage = "/memberList.do";
		}else if(command.equals("/updateMember.do")) {
			//데이터 넘겨 받음
			String memberId = request.getParameter("memberId");
			String passwd = request.getParameter("passwd");
			String name = request.getParameter("name");
			String gender = request.getParameter("gender");
			
			//Member 객체 생성 및 set
			Member member = new Member();
			member.setMemberId(memberId);
			member.setPasswd(passwd);
			member.setName(name);
			member.setGender(gender);
			
			//수정 처리 - dao 및 페이지 이동
			memberDAO.updateMember(member);
			request.setAttribute("msg", "update");
			nextPage = "/memberResult.jsp";
		}else if(command.equals("/boardList.do")) {		//게시판 목록 페이지 요청
			
			//게시글 목록 db 처리
			ArrayList<Board> boardList = boardDAO.getListAll();
			
			//model - 데이터
			request.setAttribute("boardList", boardList);
			
			nextPage = "/board/boardList.jsp";
		}else if(command.equals("/writeForm.do")) {		//글쓰기 페이지 요청
			nextPage = "/board/writeForm.jsp";
		}else if(command.equals("/writeProcess.do")) {	//글쓰기 처리 요청
			//name 속성 값 가져오기
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			//작성자는 로그인한 멤버 - 세션을 이용
			String memberId = (String)session.getAttribute("sessionId");
			
			Board board = new Board();
			board.setTitle(title);
			board.setContent(content);
			board.setMemberId(memberId);	
			
			boardDAO.insertBoard(board);
			
			nextPage = "/boardList.do";
		}
		//포워딩 - 페이지 이동
		RequestDispatcher dispatcher 
			= request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	}

}
