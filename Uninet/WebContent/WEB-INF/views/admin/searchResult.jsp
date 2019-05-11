<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="list" value="${requestScope.staffList}" />
<c:forEach var="staff" items="${list }">
  <tr>
    <td>${staff.staffName}</td>
    <td>${staff.staffId}</td>
    <td>${staff.email}</td>
    <td>${staff.phoneNumber}</td>
    <td>${staff.birthday}</td>
    <td>${staff.deptName}</td>
    <td><a href="modify?id=${staff.id}">수정</a></td>
  </tr>
</c:forEach>