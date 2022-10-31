<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.row {
   margin: 0px auto;
   width:700px;
}
h1 {
   text-align: center;
}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
</head>
<script>
	function modify(){
		if(frm.subject.value==""){
			alert("제목을 입력해 주시길 바랍니다.");
		}
		else if(frm.content.value==""){
			alert("내용을 입력해 주시길 바랍니다.");
		}
		else{
			if(confirm("내용을 수정 하시겠습니까?")){
				frm.submit();
			}
		}
	}
	
	function delete_board(){
		var no = frm.boardnumber.value;
		if(confirm("해당 게시물을 삭제 하시겠습니까?")){
			location.href='./delete.do?boardnumber='+no;	
		}
	}
</script>
<body>
  <div class="container">
    <div class="row">
     <h1>수정하기</h1>
     <form name="frm" id="frm" method=post action="updateok.do" >
     <input type=hidden name=boardnumber value="${vo.boardnumber}">
     <table class="table">
       <tr>
        <th class="text-right danger" width=15%>이름</th>
        <td width=85%>
          <input type=text name=name size=15 value="${vo.name}" readonly="readonly">
        </td>
       </tr>
       
       <tr>
        <th class="text-right danger" width=15%>제목</th>
        <td width=85%>
          <input type=text name=subject size=50 value="${vo.subject}">
        </td>
       </tr>
       
       <tr>
        <th class="text-right danger" width=15%>내용</th>
        <td width=85%>
          <textarea rows="8" cols="55" name=content>${vo.content}</textarea>
        </td>
       </tr>       
       <tr>
        <td colspan="2" class="text-center">
          <input type=button value="수정" onclick="modify();">
          <input type=button value="삭제" onclick="delete_board();">
          <input type=button value="취소" onclick="javascript:history.back()">
        </td>
       </tr>
     </table>
     </form>
    </div>
  </div>
</body>
</html>