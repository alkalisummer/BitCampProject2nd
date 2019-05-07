package kr.co.groot.service;

import java.sql.SQLException;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.groot.action.Action;
import kr.co.groot.action.ActionForward;
import kr.co.groot.dao.StaffDao;
import kr.co.groot.dto.Staff;

public class LoginAction implements Action {
  @Override
  public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
    ActionForward forward = null;
    
    String id = request.getParameter("id");
    String password = request.getParameter("password");
    
    
    try {
      StaffDao dao = new StaffDao();
      Staff staff = dao.selectStaff(id);
      
      String correctPassword = staff.getPassword();
      
      if (correctPassword == null) {
        correctPassword = "";
      }
      
      if (correctPassword.equals(password)) {
        forward = new ActionForward();
        forward.setRedirect(false);
        forward.setPath("/main");
      } else {
        forward = new ActionForward();
        String msg = "아이디나 비밀번호를 바르게 입력해주세요.";
        String url = "index.html";
        request.setAttribute("msg", msg);
        request.setAttribute("url", url);
        forward.setRedirect(false);
        forward.setPath("/WEB-INF/views/redirect.jsp");
      }
    } catch (NamingException e) {
      System.out.println(e.getMessage());
    } catch (SQLException e) {
      System.out.println(e.getMessage());
    }
    
    return forward;
  }
}
