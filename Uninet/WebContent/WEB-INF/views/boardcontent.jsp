<%@page import="kr.co.groot.dao.CommentDao"%>
<%@page import="kr.co.groot.dao.StaffDao"%>
<%@page import="kr.co.groot.dto.Staff"%>
<%@page import="kr.co.groot.dto.Comment"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.groot.dto.Post"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
  Post post = (Post) request.getAttribute("post");
  List<Comment> comments = (List<Comment>) request.getAttribute("comments");
  int id = (int) request.getAttribute("postId");
  
  for (Comment c : comments) {
    System.out.println("ID: " + c.getWriterId() + " Content: " + c.getContent());
    System.out.println("Writer: " + c.getWriter().getStaffId());
  }
  
  StaffDao staffDao = new StaffDao();
  Staff writer = staffDao.selectByUniqueId(post.getWriterId());
  System.out.println(writer.getStaffId());
  CommentDao commentDao = new CommentDao();
  int commentCount = commentDao.getCommentCount(id);
  pageContext.setAttribute("writer", writer);
  pageContext.setAttribute("commentCount", commentCount);
%>
<c:set var="post" value="${post}"/>
<c:set var="comments" value="${comments}"/>
<c:set var="id" value="${postId}"/> 
<c:set var="writer" value="${writer}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<link rel="stylesheet"
  href="<%=request.getContextPath()%>/css/top-bottom.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/post.css" />
<link rel="stylesheet"
  href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" />
<title>Insert title here</title>
</head>
<body>
  <jsp:include page="/common/top.jsp" flush="false" />
  <div class="container">
    <div class="boardtitle">
      <h1>자유게시판</h1>
    </div>
    <div class="article">
      <div class="article-main">
        <div class="writer">
          <img class="profile-photo"
            src="<%=request.getContextPath()%>/images/${writer.image}" alt="" />
          <div class="writer-info">
            <span class="writer-id">${writer.staffId}</span> 
            <span class="time">${post.timeFormat}</span>
          </div>
        </div>
        <div class="article-content">
          <h3 class="article-title">${post.title}</h3>
          <p class="content">${post.content}</p>
        </div>
      </div>
      <div class="article-sub">
        <span class="comment-option">쪽지</span>
        <div class="article-stat">
          <i class="far fa-eye">${post.count}</i>&nbsp;<i class="far fa-comment">${commentCount}</i>
        </div>
      </div>
    </div>
    <div class="comments">
      <c:forEach var="comment" items="${comments}">
        <c:choose>
          <c:when test="${comment.recomment == 'N'}">
            <div class="comment">
              <div class="comment-main">
                <div class="comment-writer">
                  <img 
                    src="<%=request.getContextPath()%>/images/${comment.writer.image}" 
                    alt="" 
                    class="comment-photo" /> 
                  <span class="comment-id">${comment.writer.staffId}</span>
                </div>
                <p class="comment-content">${comment.content}</p>
                <span class="time">${comment.timeFormat}</span>
              </div>
              <div class="comment-sub">
                <span class="comment-option">대댓글</span> 
                <span class="comment-option">쪽지</span>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="recomment">
              <div class="comment-main">
                <div class="comment-writer">
                  <img 
                    src="<%=request.getContextPath()%>/images/${comment.writer.image}" 
                    alt=""
                    class="comment-photo" /> 
                  <span class="comment-id">${comment.writer.staffId}</span>
                </div>
                <p class="comment-content">${comment.content}</p>
                <span class="time">${comment.timeFormat}</span>
              </div>
              <div class="comment-sub">
                <span class="comment-option">대댓글</span> 
                <span class="comment-option">쪽지</span>
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </c:forEach>
      <div class="comment-input">
        <form action="comment" method="post" class="comment-form">
          <input class="comment-text" type="text" name="comment"
            maxlength="50" placeholder="댓글을 입력하세요" /> 
          <input
            class="submit" type="image"
            src="<%=request.getContextPath()%>/images/submit.png">
            <input type="hidden" value="${id}" name="commentId">
        </form>
      </div>
    </div>
  </div>
  <jsp:include page="/common/bottom.jsp" flush="false" />
</body>
</html>
