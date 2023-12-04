<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC01_title</title>
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
		<!--     	
    		method는 넘기는 방식 action은 받는 것
    		action과 같이 새로운 요청이 발생했으니 Controller에 Mapping을 해주고
    		Mapper에다가 insert만들고 DB 만들고 리스트 페이지로 돌려주고 하면 됨
    		tr 태그에 있는 name에 3개의 파라미터 => title, content, writer가
    		boardInsert.do로 전달된다.
    	 -->
    	<form action="boardInsert.do" method="post">
	    	<table class = "table">
	    		<tr>
	    			<td>제목</td>
	    			<td><input type="text" name="title" class="form-ciontrol"/></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>내용</td>
	    			<td> <textarea rows="7" class="form-control" name="content"></textarea> </td>
	    		</tr>
	    		
	    		<tr>
	    			<td>작성자</td>
	    			<td> <input type="text" name="writer" class="form-ciontrol"/> </td>
	    		</tr>
	    		
	    		<tr>
	    			<td colspan="2" align="center">
	    				<button type="submit" class="btn btn-success btn-sm">등록</button>
	    				<button type="button" class="btn btn-warning btn-sm"
	    						onclick="location.href='boardList.do'">취소</button>
	    			</td>
	    		</tr>
	    		
	    	</table>
    	</form>
    </div> <!-- panel - body -->
    <div class="panel-footer">김주완_스프링</div>
  </div>
</div>

</body>
</html>