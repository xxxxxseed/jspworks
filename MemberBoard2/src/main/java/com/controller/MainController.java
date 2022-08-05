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

import com.repository.Member;
import com.repository.MemberDAO;


@WebServlet("*.do")		//url mapping - 확장자 .do인 모든 파일
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 2L;
	
	MemberDAO memberDAO;

	
	public void init(ServletConfig config) throws ServletException {
		memberDAO = new MemberDAO();
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
			
			//member 객체 생성
			Member member = new Member();
			member.setMemberId(memberId);
			member.setPasswd(passwd);
			member.setName(name);
			member.setGender(gender);
			
			//db에 저장
			memberDAO.addMember(member);
			
			//화면 이동
			nextPage = "/main.jsp";
		
		
		}else if(command.equals("/memberList.do")) {
			//dao 목록 요청
			ArrayList<Member> memberList = memberDAO.getListAll();
			
			//model - 반환 자료
			request.setAttribute("memberList", memberList);
			//view
			nextPage = "/memberList.jsp";
		}else if(command.equals("/loginMember.do")) {
			nextPage = "/loginMember.jsp";
		}else if(command.equals("/loginProcess.do")) {
			String memberId = request.getParameter("memberId");
			String passwd = request.getParameter("passwd");

			//db 처리
			boolean result = memberDAO.checkLogin(memberId, passwd);
			
			if(result){
				session.setAttribute("sessionId", memberId);	//세션 발급
				nextPage = "/main.jsp";
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
		}
		
		//포워딩 - 페이지 이동
		RequestDispatcher dispatcher 
			= request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	}

}
