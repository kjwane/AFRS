<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>AFRS</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
	$(document).ready(function(){
  		if(${not empty msgType}) {
			$("#messageType").attr("class", "modal-content panel-warning");
  			$("#myMessage").modal("show");
  		} // if
  	}); // ready(function())
  </script>
  
</head>
<body>
<div class="container">
  <jsp:include page="../common/header.jsp"/>
  <!-- <h2>로그인 페이지입니다.</h2> -->
  <div class="panel panel-default">
    <div class="panel-heading">로그인 화면</div>
    <div class="panel-body">
    	<form action="${contextPath}/memLogin.do" method="post">
	    	<table class="table table-bordered" style="text-align : center;
	    		border : 1px solid #dddddd;">
	    		<tr>
    				<td style="width:110px; vertical-align:middle;">아이디</td>
    				<td>
	    				<input id="memID" name="memID" class="form-control" type="text"
	    				maxlength="20" placeholder ="아이디를 입력하세요."/>
    				</td>
    			</tr>
    			
    			<tr>
    				<td style="width:110px; vertical-align:middle;">비밀번호</td>
    				<td colspan="2">
	    				<input id="memPassword" name="memPassword" class="form-control"
	    				type="password" maxlength="20" placeholder ="비밀번호를 입력하세요."/>
    				</td>
    			</tr>
    			
    			<tr>
    				<td colspan="2" style="text-align : left;">
    					<input type="submit" class="btn btn-primary btn-sm pull-right"
    					value="로그인"/>
    				</td>
    			</tr>
    			
	    	</table>
    	</form>
    </div>
    
    <!-- 실패 메시지를 출력하는 부분(modal로) -->
     <div id="myMessage" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content -->
 	    <div id="messageType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">${msgType}</h4>
	      </div>
	      <div class="modal-body">
	        <p>${msg}</p>
	      </div>
	      <!-- 실패 메시지를 출력하는 부분(modal로) -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
    
  </div>
</div>


	<style>
	
	.container {
	  max-width: 50%; /* 또는 원하는 퍼센트 값으로 설정 */
	  margin: auto; /* 패널을 중앙에 배치 */
	  /* 필요한 경우 추가 스타일링 */
	}
	
	</style>






</body>
</html>
