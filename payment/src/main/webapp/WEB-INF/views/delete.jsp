<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.row {
   margin: 0px auto;
   width:350px;
}
h1 {
   text-align: center;
}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
</head>
<script>
	function listgo(){
		location.href='./list.do';	
	}
	function delok(){
		if(frm.pwd.value==""){
			alert('패스워드를 입력하세요');
			return false;
		}
		else{
			frm.submit();
		}
	}
</script>
<body>
<form name="frm" id="frm" method="post" action="deleteok.do" onsubmit="return delok();">
   <input type=hidden name=boardnumber value="${boardnumber}">
   <div class="container">
    <div class="row">
      <h1>삭제하기</h1>
      <table class="table">
       <tr>
         <td>
          비밀번호:<input type=password name=pwd size=15 class="input-sm">
         </td>
       </tr>
       <tr>
         <td class="text-center">
           <input type=submit value="삭제">
           <input type=button value="취소" onclick="listgo()">
         </td>
       </tr>
      </table>
    </div>
   </div>
</form>  
</body>
</html>