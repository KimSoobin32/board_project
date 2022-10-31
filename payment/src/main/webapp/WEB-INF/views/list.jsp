<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
<style type="text/css">
.row {
	margin: 0px auto;
	width: 900px;
}

h1 {
	text-align: center;
}
</style>
</head>
<script>
	function list_all(){	//button
		location.href='./list.do';
	}	
	function search_ck(){	//submit
		if(f.searchtype.value==""){
			alert("검색타입을 선택해 주시길 바랍니다.");
			return false;
		}
		else if(f.keyword.value==""){
			alert("검색어를 입력해 주시길 바랍니다.");
			return false;
		}
		else{
			f.submit();
		}
	}
</script>
<body>
	<div class="container">
		<div class="row">
			<h1>게시판</h1>
			<table class="table">
				<tr>
					<td><a href="./insert.do" class="btn btn-sm btn-primary">새글</a>
					</td>
				</tr>
			</table>
			<div>
			<form id="f" name="f" method="post" action="./search.do" onsubmit="return search_ck()">
				<div id="searchMember" style="height: 100px; margin: 0px auto; text-align: center;">
						<select name="searchtype">
							<option value="" selected>검색타입</option>
							<option value="name" <c:if test="${searchtype eq 'name'}">selected</c:if>>글쓴이</option>
							<option value="subject" <c:if test="${searchtype eq 'subject'}">selected</c:if>>제목</option>
							<option value="content" <c:if test="${searchtype eq 'content'}">selected</c:if>>내용</option>	
						</select> <input type="text" name="keyword" value="${keyword}"> 
                        <input type="submit" value="검색">
                        <input type="button" value="전체목록" onclick="list_all()">
				</div>
			</form>
			</div>
			<table class="table table-striped">
				<tr class="danger">
					<th class="text-center" width=10%>번호</th>
					<th class="text-center" width=45%>제목</th>
					<th class="text-center" width=15%>글쓴이</th>
					<th class="text-center" width=20%>작성일</th>
					<th class="text-center" width=10%>조회수</th>
				</tr>
				<c:forEach var="notice" items="${lists}" varStatus="status">
					<tr><!-- index(0부터시작) count(1부터시작) -->
						<td class="text-center" width=10%>${fn:length(lists)-status.index}</td>
						<td class="text-left" width=45%>
						<a href="./view.do?boardnumber=${notice.boardnumber}">${notice.subject}</a></td>
						<td class="text-center" width=15%>${notice.name}</td>
						<td class="text-center" width=20%>
						<fmt:formatDate value="${notice.regdate}" pattern="yyyy-MM-dd"/>
						</td>
						<td class="text-center" width=10%>${notice.hit}</td>
					</tr>
				</c:forEach>	
			</table>
			<table class="table">
				<td class="text-center">
                    <a href="./list.do?pageno=${pageno>1?pageno-1:pageno}" class="btn btn-sm btn-primary">이전</a>${pageno } page /
					${totalpage} pages <a href="./list.do?pageno=${pageno<totalpage?pageno+1:pageno}" class="btn btn-sm btn-primary">다음</a>
				</td>
			</table>
		</div>
	</div>
</body>
</html>