<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="lectureList" value="${requestScope.lectureList}"></c:set>
<c:set var="profList" value="${requestScope.profList}"></c:set>
<c:set var="ltList" value="${requestScope.ltList}"></c:set>
<c:set var="majorList" value="${requestScope.majorList}"></c:set>
<c:set var="lecture2" value="${requestScope.lecture2}"></c:set>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 수정</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/top-bottom.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/update.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">

</head>
<body>

<jsp:include page="/common/top.jsp" flush="false" />
   <div class="container">
    <form action="updateOk" method = "GET">
    <input type="hidden" value = "${requestScope.id}" name="id">
   
    <!-- 과목 입력 -->
    <label for = "lectureName">과목</label>
    <input type = "text" id = "lectureName" name = "lectureName" value = "${lecture2.lectureName}">
    <!-- 과목 입력 -->
    <br>
    
    
     <!-- 학점 선택  -->
     <span class = "lable">학점</span>
     <select name = "">
<c:forEach var = "i" begin="1" end="3">
  <c:choose>
    <c:when test="${i==lecture2.credit}">
        <option value="${i}" selected>${i}</option>
    </c:when>
    <c:otherwise>
        <option value="${i}">${i}</option>
     </c:otherwise>
  </c:choose>
</c:forEach>
</select>
<br>
    <!-- 학점 선택  -->
    
     <!-- 시간 선택  -->
   <span class = "lable">시간</span>
    <select name="weekday">
      <option value="월">월</option>
      <option value="화">화</option>
      <option value="수">수</option>
      <option value="목">목</option>
      <option value="금">금</option>
    </select>
      <select name = "lecturetime">
        <option value="">교시 선택</option>
        <option value = "123">123</option>
        <option value = "456">456</option>
        <option value = "789">789</option>
      </select><br>
    <!-- 시간 선택  -->
    
     <!-- 종별 선택  -->
   <span class = "lable">종별</span>
 <select name = "lecturetype">
   <c:forEach var = "lecttype" items = "${ltList}">
        <c:choose>
          <c:when test="${lecture2.lectureType == lecttype.lectureType}">
            <option value = "${lecture2.lectureTypeId}" selected>${lecttype.lectureType}</option>
          </c:when>
          <c:otherwise>
            <option value = "${lecttype.id}">${lecttype.lectureType}</option>
          </c:otherwise>
        </c:choose>
   </c:forEach>
   </select>
  <br>    
 
     <!-- 교수 선택  -->
     <span class = "lable">교수</span>
      <select name = "professor">
         <c:forEach var = "professor" items = "${profList}">
           <c:choose>
             <c:when test="${professor.profName == lecture2.profName}">
              <option value = "${professor.id}" selected>${lecture2.profName}</option>
             </c:when>
             <c:otherwise>
             <option value = "${professor.id}">${professor.profName}</option>
             </c:otherwise>
           </c:choose>     
         </c:forEach>
      </select>
     <br>
 
    <!-- 교수 선택  -->
    
    <input type = "submit" value = "수정하기" class = ""><br>
    <a class = "" href = "list">취소하고 돌아가기</a> 
    
  
 
   
    </form>
    </div>
   <jsp:include page="/common/bottom.jsp" flush="false" />

</body>
</html>