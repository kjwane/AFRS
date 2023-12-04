<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC02_title</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
	/* jquey를 쓰려면 $시작해서 function까지 써줘야함 */
  	$(document).ready(function(){
  		loadList();
  	}); /* $(document).ready(function() */
	function loadList(){
  		/* 서버와 통신 : 게시판 리스트 가져오기 */
  		$.ajax({
  			url : "board/all", /* url에 Controller로 요청을하고 return을 */
  			type : "get",
  			dataType : "json",
  			success : makeView, /* makeView => 콜백함수 이름은 상관없음,
  			이제 서버 실행시키고 boardList.do 치면 JSON형태가 나오는데 밑에 makeView(data)여기에 보내면
  			리스트로 만들어준다. */
  			error : function(){ alert("error"); }
  			
  		}); // $.ajax

  	} /* function loadList */
  	
  	/* 여기서 success에서 보낸 JSON형태를 받아서 list로 만드는 거임 */
  	function makeView(data) {
  		var listHtml = "<table class = 'table table-bordered'>";
  		listHtml += "<tr>";
  		listHtml += "<td>번호</td>";
  		listHtml += "<td>제목</td>";
  		listHtml += "<td>작성자</td>";
  		listHtml += "<td>작성일</td>";
  		listHtml += "<td>조회수</td>";
  		listHtml += "</tr>";
  		$.each(data, function(index, obj){	// obj = {"idx" : 5, "title" : "게시판" ~~ }
  	  		listHtml += "<tr>";
			/* listHtml += "<td><a href='javascript:goContent("+obj.idx+")'>"+obj.idx+"</a></td>"; */
  	  		listHtml += "<td>"+obj.idx+"</td>";
  	  		listHtml += "<td id = 't"+obj.idx+"'><a href='javascript:goContent("+obj.idx+")'>"+obj.title+"</a></td>";
  	  		listHtml += "<td>"+obj.writer+"</td>";
  	  		listHtml += "<td>"+obj.indate.split(' ')[0]+"</td>";
  	  		listHtml += "<td id='cnt"+obj.idx+"'>"+obj.count+"</td>";
  	  		listHtml += "</tr>";
/* ----------여기는 게시글 눌렀을 때 게시글 사이에 내용 뜨게 하는 부분---- */
			listHtml += "<tr id='c"+obj.idx+"' style='display : none'>";
  	  		listHtml += "<td>내용</td>";
  	  		listHtml += "<td colspan='4'>";
  	  		
  	  		listHtml += "<textarea id='ta"+obj.idx+"' readonly rows='7' class = 'form-control'></textarea>";
			listHtml += "<br/>";
			// &nbsp => 공백 한 칸을 띄우라는 의미
			// ub = updatebutton
			listHtml += "<span id='ub"+obj.idx+"'><button class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")'>수정화면</button></span>&nbsp";
			listHtml += "<button class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button>";
	  		listHtml += "</td>";
  	  		listHtml += "</tr>";
  	  		
  		}); /* $.each(data, function(index, obj) */
  			
		listHtml += "<tr>";
		listHtml += "<td colspan = '5'>";
  		listHtml += "<button class='btn btn-primary btn-sm' onclick='goForm()'>글쓰기</button>";
		listHtml += "</td>";
		listHtml += "</tr>";
  		listHtml += "</table>";
  		$("#view").html(listHtml);
  		
  		$("#view").css("display", "block"); 
  		$("#wfrom").css("display", "none");
  	} /* function makeView(data) */ 
  	
  	function goForm() {
  		$("#view").css("display", "none"); // 감추고 view랑 wfrom 앞에 # 꼭붙이기 안 붙이면 실행 안 됨
  		$("#wfrom").css("display", "block"); // 보이고
  	} // function goForm()
  	
  	function goList() {
  		$("#view").css("display", "block"); 
  		$("#wfrom").css("display", "none");
  	} // function goList()
  	
  	function goInsert() {
  		/* var title = $("#title").val();
  		var content = $("#content").val();
  		var writer = $("#writer").val(); */
  		
  		var fData = $("#frm").serialize();
  		//alert(fData;)
  		$.ajax({
  			url : "board/new",
  			type : "post",
  			data : fData,
  			success : loadList,
  			error : function()  { alert("error");}

  		}); // ajax
  		
  		// 폼 초기화 title, content, writer 이렇게 쓰면 다른 것들도 많을 시 계속 써야하니까
  		// 취소 버튼에 id를 fclear라고 주고 강제로 취소 버튼 실행하게 만들었음
  		/* $("#title").val("");
  		$("#content").val("");
  		$("#writer").val(""); */
  		$("#fclear").trigger("click");
  		
  	} // function goInsert()
  	
  	function goContent(idx) {
  		if($("#c"+idx).css("display")=="none"){
  			$.ajax({
  				url : "board/"+idx,
  				type : "get",
  				data : {"idx" : idx},
  				datatype : "json",
  				success : function(data){// data = { "content" : ~~~ }
  					$("#ta"+idx).val(data.content);
  				}, // success
  				error : function(){ alert("error"); }
  				
  			});
  			
  			$("#c"+idx).css("display", "table-row"); // 보이게
  			$("#ta"+idx).attr("readonly", true); // 보이게
  		
  		}else{
  			$("#c"+idx).css("display", "none"); // 보이게
  			$.ajax({
  				url : "board/count/"+idx,
  				type : "put",
  				data : {"idx":idx},
  				dataType : "json",
  				success : function(data){
  					$("#cnt"+idx).text(data.count);
  					
  				}, // success
  				error : function() { alert("error"); }
  				
  				
  			});
  		} // else
		
	} // function goContent(idx)
	
	function goDelete(idx){
		$.ajax({
  			url : "board/"+idx,
  			type : "delete",
  			data : {"idx" : idx},
  			success : loadList,
  			error : function(){ alert("error");}
		});
	} // function goDelete
	
	function goUpdateForm(idx){
		$("#ta"+idx).attr("readonly", false);
		var title = $("#t"+idx).text();
		// newInput이제목에 해당
		
		// nt => newtext
		var newInput = "<input type='text' id='nt"+idx+"' class='form-control' value ='"+title+"' />";
		$("#t"+idx).html(newInput);
		
		var newButton = "<button class = 'btn btn-info btn-sm' onclick='goUpdate("+idx+")'>수정</button>";
		$("#ub"+idx).html(newButton);
		
	} // function goUpdateForm
  	
	function goUpdate(idx) {
		var title = $("#nt"+idx).val();
		var content = $("#ta"+idx).val();
		$.ajax({
			url : "board/update",
			type : "put",
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify({"idx" : idx,"title" : title, "content" : content}),
			success : loadList,
			error : function(){ alert("error");}
			
		}); // ajax
		
		
	} // goUpdate
	
  </script>
  
  
</head>
<body>
 
<div class="container">
  <h2>Spring MVC02</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    <div class="panel-body" id="view">
    	panel-body
    </div> <!-- panel - body -->
    <div class="panel-body" id="wfrom" style ="display : none">
    	<form id="frm">
	    	<table class = "table">
	    		<tr>
	    			<td>제목</td>
	    			<td><input type="text" id="title" name="title" class="form-ciontrol"/></td>
	    		</tr>
	    		
	    		<tr>
	    			<td>내용</td>
	    			<td> <textarea rows="7" class="form-control" id="content" name="content"></textarea> </td>
	    		</tr>
	    		
	    		<tr>
	    			<td>작성자</td>
	    			<td> <input type="text" id="writer" name="writer" class="form-control"/> </td>
	    		</tr>
	    		
	    		<tr>
	    			<td colspan="2" align="center">
	    				<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
	    				<!-- <button type="button" class="btn btn-warning btn-sm"
	    						onclick="location.href='boardList.do'">취소</button> -->
	    				<button type="reset" class="btn btn-warning btn-sm" id="fclear">취소</button>
	    				<button type="button" class="btn btn-info btn-sm"
	    						onclick="goList()">리스트</button>
	    						
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