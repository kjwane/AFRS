<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 반복문을 사용하기 위해 씀 -> taglib -->
<%@taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <!-- title은 그 웹페이지 안에서 말고 웹페이지 창끼리 움직이는 부분의 이름을 바꾸는 곳 -->
  <title>Spring MVC01</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
 
<div class="container">
  <h2>Spring_clothes</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    <div class="panel-body">
    	<table class = "table table-bordered table-hover">
    		<tr>
    			<td>번호</td>
    			<td>제목</td>
    			<td>작성자</td>
    			<td>작성일</td>
    			<td>조회수</td>
    		</tr>
			<c:forEach var = "vo" items = "${list}">
	    		<tr>
	    			<td><a href="boardContent.do?idx=${vo.idx}">${vo.idx}</td>
	    			<td><a href="boardContent.do?idx=${vo.idx}">${vo.title}</td>
	    			<!--
	    				상세보기 하려고 href 쓰는 거임
	    				? 써서 넘기는 방법이 있음 => get 방식
	    				idx = 번호를 받아서 상세보기를 만드는 거임
	    				선생님은 ${vo.idx}">${vo.title} 이렇게만 해서 제목을 누르면 들어가지게 했는데
	    				이렇게 하면 제목을 안 쓰면 넘어가지를 못해서 나는
	    				${vo.idx}">${vo.idx} 이렇게 해서 인덱스를 누르면 들어가질 수 있게 함
	    			-->
	    			<td>${vo.writer}</td>
	    			<td>${fn:split(vo.indate, " ")[0]}</td>
	    			<td>${vo.count}</td>
	    		</tr>
			</c:forEach>
    	</table>
		<!--     	
    		button 대신 a태그로 해도 버튼 모양임
    	 -->
    	<a href ="boardForm.do" class = "btn btn-primary btn-sm" >글쓰기</a>
   	</div> <!-- panel - body -->
    <div class="panel-footer">김주완_스프링</div>
  </div>
</div>

</body>
</html>

