<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!-- Collapsed Sidepanel --><!-- Collapsed Sidepanel -->

<div class="navbar-header">
	<div id="mySidepanel" class="sidepanel">
	  <div class="space"> <!-- closebtn 공간 할당 -->
	  	<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>	  
	  </div> <!-- closebtn 공간 할당 -->
		      <div>
		        <a href="${contextPath}/" class="hover-effect">HOME</a>
				<br>
		        <a href="http://192.168.0.161:8501/" class="hover-effect">AFRS</a>
		        <br>
		        <a href="boardMain.do" class="hover-effect">Q&A</a>
		      </div> <!-- <ul class="nav navbar-nav"> -->
	</div> <!-- <div id="mySidepanel" class="sidepanel"> -->

	<!-- 로그인 되지 않은 상태 -->
	<c:if test="${empty mvo}">
	  <div class="container-right">	    
	    <a href="${contextPath}/memJoin.do" class="link-style">
	      <span class="glyphicon glyphicon-user">
	        회원가입
	      </span>
	    </a>
	    
	    <a href="${contextPath}/memLoginForm.do" class="link-style">
	      <span class="glyphicon glyphicon-log-in">
	        로그인
	      </span>
	    </a>
	    
	   </div> <!-- <div class="container-right"> -->
	</c:if>
	
     <!-- 로그인 된 상태 -->
     <c:if test="${!empty mvo}">
     	<div class="container-right">
<%--      	
			<c:if test="${!empty mvo}">
				<a class="link-style">
					${mvo.memName}님
				</a>
			</c:if>
 --%>			
	           	<a href="${contextPath}/memUpdateForm.do" class="link-style">
					<span class="glyphicon glyphicon-cog">
	            		회원정보수정
	            	</span>
	           	</a>
	
	           	<a href="${contextPath}/memLogout.do" class="link-style">
	            	<span class="glyphicon glyphicon-log-out">
	            		로그아웃
	            	</span>
	           	</a>
       </div> <!-- <div class="container-right"> -->
     </c:if>
	
</div> <!-- <div class="navbar-header"> -->




<button class="openbtn" onclick="openNav()"> > </button>  
<p></p>
<p></p>

<script type="text/javascript">
	function openNav() {
  		document.getElementById("mySidepanel").style.width = "250px";
	}
	
	function closeNav() {
		document.getElementById("mySidepanel").style.width = "0";
	}
	
</script>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<style>
	
	body {
	  font-family: "Lato", sans-serif;
	}
	
	/* 사이드패널 스타일 */
	.sidepanel  {
	  width: 0; /* 초기 너비를 0으로 설정하여 패널이 보이지 않도록 함 */
	  position: fixed; /* 패널을 화면에 고정시킴 */
	  z-index: 1; /* 다른 요소보다 앞에 위치 */
	  height: 100%; /* 패널의 높이를 전체 창 높이와 동일하게 설정 */
	  top: 0; /* 상단에서의 위치를 0으로 설정 */
	  left: 0; /* 왼쪽에서의 위치를 0으로 설정 */
	  background-color: #F0F2F6; /* 패널의 배경색을 회색으로 설정 */
	  overflow-x: hidden; /* 내부 x축 스크롤바를 숨김 */
	  transition: 0.5s; /* 너비 변경 시 애니메이션 효과를 위한 전환 시간 설정 */
	  padding-top: 60px; /* 상단 내부 여백 설정 */
	}
	
	/* 사이드패널 내부 링크 스타일 */
	.sidepanel a {
	  padding: 8px 8px 8px 32px; /* 링크의 패딩 설정 */
	  text-decoration: none; /* 링크의 밑줄 제거 */
	  font-size: 25px; /* 링크의 글자 크기 설정 */
	  color: #818181; /* 링크의 글자 색 설정 */
	  display: block; /* 링크를 블록 요소로 설정하여 줄바꿈됨 */
	  transition: 0.3s; /* 색상 변경 시 애니메이션 효과를 위한 전환 시간 설정 */
	}
	


	
	/* 사이드패널 닫기 버튼 스타일 */
	.sidepanel .closebtn {
	  position: absolute; /* 부모 요소를 기준으로 절대 위치 설정 */
	  top: 0; /* 상단에서의 위치를 0으로 설정 */
 	  right: 0px; /* 오른쪽에서의 위치를 25px로 설정 */
	  font-size: 36px; /* 닫기 버튼의 글자 크기 설정 */
	  
	}
	
	.sidepanel .closebtn:hover {
	
	  background-color: #E3E7EE;
	}
	
	.space a {
		width: 35%;
		
	}
	
	/* 사이드패널 열기 버튼 스타일 */
	.openbtn {
	  font-size: 20px; /* 버튼 글자 크기 설정 */
	  cursor: pointer; /* 마우스 오버 시 포인터 모양 변경 */
	  background-color: #fff; /* 버튼 배경색 설정 */
	  color: black; /* 버튼 글자 색 설정 */
	  padding: 15px 15px; /* 버튼 패딩 설정 */
	  border: none; /* 버튼 테두리 제거 */
	}
	
	/* 공통 호버 스타일 클래스를 정의 */
	.hover-effect:hover {
	  width: 100%;
	  background-color: #E3E7EE; /* 호버 시 텍스트 색상 변경 */
	  /* background-color: #E3E7EE; */
	}

	
	/* 사이드패널 열기 버튼 호버 스타일 */
	.openbtn:hover {
	  background-color:#E3E7EE;
	}
	
	
	
	
	/* 로그인 관련 CSS */
	
	/* 오른쪽 상단에 위치할 로그인 관련 링크 컨테이너 스타일 */
	.container-right {
	  position: absolute; /* 스크롤 시에도 우측 상단에 고정 */
	  right: 0px; /* 오른쪽에서의 위치 설정 */
	}
	
	/* 로그인 및 회원가입 링크 스타일 */
	.link-style {
	  display: inline-block; /* 인라인 블록 요소로 설정하여 옆으로 나란히 배치 */
	  padding: 5px; /* 링크 내부 패딩 설정 */
	  margin: 13px; /* 링크 외부 여백 설정 */
	  text-decoration: none; /* 링크 밑줄 제거 */
	  color: black; /* 링크 글자 색 설정 */
	  background-color: transparent; /* 링크 배경색 투명 설정 */
	} 
	
	/* 로그인 및 회원가입 링크 호버 스타일 */
	.link-style:hover {
	  background-color: #E3E7EE; /* 링크 호버 시 배경색 변경 */
	}

	.navbar-header{
		position: relative;
		width: 100%;
	}
	
	</style>
	
</head>
</html> 

<!-- Collapsed Sidepanel --><!-- Collapsed Sidepanel -->
      