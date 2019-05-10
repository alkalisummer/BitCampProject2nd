<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/top-bottom.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modal.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
	  
	  /* 검색 비동기 */
	  $("#closeBtn").on("click", function() {
	    // if ($("#searchInput").val()) {
        /* alert($("#searchInput").val() + " 검색합니다"); */
				const inputVal = $("#searchInput").val();
        const radioVal = $("input[name='searchradio']:checked").val();
       
        $.ajax( 
            {
          		url: "inputtext",
          		dataType : "html",
          		data :  {
          		  searchradio : radioVal,
          		  searchInput : inputVal
          		},
          		success : function(data) {
          		  $("#searchResult").html(data);
          		  console.log(data);
          		},
          		error : function(xhr) {
          		  console.log(xhr.status);
          		}
        		}
            );
      // } 
	  });
	  
	  /* 검색 비동기 */
	  
	  
	  $("#closeBtn2").on("click", function() {
	    // if ($("#searchInput").val()) {
        /* alert($("#searchInput").val() + " 검색합니다"); */
				const sortVal = $("input[name='sort']:checked").val();
        console.log(sortVal);
       
        $.ajax( 
            {
          		url: "lectureSort",
          		dataType : "html",
          		data :  {
          		  sort : sortVal,
          		},
          		success : function(data) {
          		  $("#searchResult").html(data);
          		  console.log(data);
          		},
          		error : function(xhr) {
          		  console.log(xhr.status);
          		}
        		}
            );
      // } 
	  });
 
	});


</script>

</head>
<body>

<jsp:include page="/common/top.jsp" flush="false" />
<div class = "container">
  <table class = "lecturetable">
  <thead>
    <tr>
      <td>강의이름</td>
      <td>학점</td>
      <td>시간</td>
      <td>종별</td> 
      <td>학과</td>
      <td>교수</td>
    </tr>
   </thead>
   <tbody id = "searchResult">
    <c:forEach var = "lecture" items = "${requestScope.lecturelist}">
    <tr>
      <td>${lecture.lectureName}</td>
      <td>${lecture.credit}</td>
      <td>${lecture.time}</td>
      <td>${lecture.lectureType}</td>
      <td>${lecture.majorName}</td>
      <td>${lecture.profName }</td>
      <td><a href = "updatePage?id=${lecture.id}">수정</a></td>
      <td><a href = "delete?id=${lecture.id}">삭제</a></td>
      <td></td>
        
    </tr>
    </c:forEach>
    </tbody>
  </table>
  <a href = "write"><button class="">수업추가</button></a>
 </div>
 

 <p>
  <button class="button" data-modal="modalOne">
    강의 검색
  </button>
</p>
<p>
  <button class="button" data-modal="modalTwo">
   정렬
  </button>
</p>

<div id="modalOne" class="modal">
  <div class="modal-content">
    <div class="contact-form">
      <a class="close">&times;</a>
       <label>과목명</label>
          <input type = "radio" value = "lecture" name = "searchradio">
          <br>
          <label>교수명</label>
          <input type = "radio" value = "prof" name = "searchradio">
          <br>
          <label>전공명</label>
          <input type = "radio" value = "major" name = "searchradio">
          <br>
          <label for = "searchInput">Input</label>
          <input type = "text" name = "searchInput" id = "searchInput"  placeholder = "검색어">
          <br>
          <button type="button" id = "closeBtn">검색</button> 
    </div>
  </div>
</div>

<div id="modalTwo" class="modal">
  <div class="modal-content">
    <div class="contact-form">
      <span class="close">&times;</span>
    <label>기본</label>
          <input type = "radio" value = "basic" name = "sort">
          <br>
          <label>강의</label>
          <input type = "radio" value = "lecture" name = "sort">
          <br>
          <label>학점</label>
          <input type = "radio" value = "credit" name = "sort">
          <br>
          <label>교수</label>
          <input type = "radio" value = "prof" name = "sort">
          <br>
          <label>전공</label>
          <input type = "radio" value = "major" name = "sort">
          <br>
          <button type="button" id = "closeBtn2">정렬</button>
    </div>
  </div>
</div>
  
  <jsp:include page="/common/bottom.jsp" flush="false" />


</body>
<script type="text/javascript">
var modalBtns = [...document.querySelectorAll(".button")];
modalBtns.forEach(function(btn){
  btn.onclick = function() {
    var modal = btn.getAttribute('data-modal');
    document.getElementById(modal).style.display = "block";
  }
});

var closeBtns = [...document.querySelectorAll(".close")];
var closeBtns2 = [...document.querySelectorAll("#closeBtn")];
var closeBtns3 = [...document.querySelectorAll("#closeBtn2")];
closeBtns.forEach(function(btn){
  btn.onclick = function() {
    var modal = btn.closest('.modal');
    modal.style.display = "none";
  }
});

closeBtns2.forEach(function(btn){
  btn.onclick = function() {
    var modal = btn.closest('.modal');
    modal.style.display = "none";
  }
});

closeBtns3.forEach(function(btn){
  btn.onclick = function() {
    var modal = btn.closest('.modal');
    modal.style.display = "none";
  }
});





window.onclick = function(event) {
  if (event.target.className === "modal") {
    event.target.style.display = "none";
  }
}


</script>

</html>