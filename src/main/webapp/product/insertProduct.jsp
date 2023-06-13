<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 상품추가시 카테고리를 분류해야하는데 카테고리는 외래키로 지정되어 있어 기존 값에서 선택해야한다
	// 그러므로 카테고리 name리스트를 출력해 선택할 수 있도록 했다.
	CategoryDao cDao = new CategoryDao();
	ArrayList<HashMap<String, Object>> cList = cDao.categoryNameList();
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
	/* js유효성검사 진행중 중도 하차상태 ㄴ
	$(document).ready(function() {
		
		let allCheck = false;
		// categoryNameId유효성체크
		$('#categoryNameId').change(function(){
			// 카테고리이름길이가 0 이면 작성된것이 없으므로 메세지전송
			if($('#categoryNameId').val().length == 0) {
				$('#categoryNameIdMsg').text('카테고리가 설정되지 않았습니다.');
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#categoryNameId').val());
				// 메세지 값은 '' 으로 초기화
				$('#categoryNameIdMsg').text('');
				$('#nameId').focus();
			}
		})
	
		// nameId유효성체크
		$('#nameId').blur(function(){
			// 상품이름길이가 0 이면 작성된것이 없으므로 메세지전송
			if($('#nameId').val().length == 0) {
				$('#nameIdMsg').text('상품이름을 작성해야합니다.');
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#nameId').val());
				// 메세지 값은 '' 으로 초기화
				$('#nameIdMsg').text('');
				$('#priceId').focus();
			}
		})
		
		
		// priceId유효성체크
		$('#priceId').blur(function(){
			// 상품가격길이가 0 이면 작성된것이 없으므로 메세지전송
			if($('#priceId').val().length == 0) {
				$('#priceIdMsg').text('상품가격을 작성해야합니다.');
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#priceId').val());
				// 메세지 값은 '' 으로 초기화
				$('#priceIdMsg').text('');
				$('#statusId').focus();
			}
		})
		
		// statusId유효성체크
		$('#statusId').change(function(){
			// 상품상태길이가 0 이면 작성된것이 없으므로 메세지전송
			if($('#statusId').val().length == 0) {
				$('#statusIdMsg').text('상품상태가 설정되지 않았습니다.');
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#statusId').val());
				// 메세지 값은 '' 으로 초기화
				$('#statusIdMsg').text('');
				$('#stockId').focus();
			}
		})
		
		// stockId유효성체크
		$('#stockId').blur(function(){
			// 상품재고길이가 0 이면 작성된것이 없으므로 메세지전송
			if($('#stockId').val().length == 0) {
				$('#stockIdMsg').text('재고량을 작성해야합니다.');
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#stockId').val());
				// 메세지 값은 '' 으로 초기화
				$('#stockIdMsg').text('');
				$('#infoId').focus();
			}
		})
		
		// infoId유효성체크
		$('#infoId').blur(function(){
			// 상품정보길이가 1000 보다 크면 메세지전송
			if($('#infoId').val().length == 0) {
				$('#infoIdMsg').text('상품정보를 작성해야합니다');
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#infoId').val());
				// 메세지 값은 '' 으로 초기화
				$('#infoIdMsg').text('');
			}
		})
		
		// fileId유효성체크
		$('#fileId').blur(function(){
			// 상품파일이름길이가 1000 보다 크면 메세지전송
			if($('#fileId').val().length == 0) {
				$('#fileIdMsg').text('사진을 넣어야합니다');
			} else {
				// 제대로 작성된경우 콘솔로그에 입력값 출력
				console.log($('#fileId').val());
				// 메세지 값은 '' 으로 초기화
				$('#fileIdMsg').text('');
			}
		})
		
	});	
		$('#insertProductForm').submit();
		
	*/
</script>
</head>
<body>
	<h1>상품추가</h1>
	<form id="insertProductForm" action="<%=request.getContextPath()%>/product/insertProductAction.jsp" method = "post" enctype="multipart/form-data">
		<table>
			<!-- 상품 추가 폼 -->
			<tr>
				<!-- 카테고리 선택 -->
				<th>카테고리 분류</th>
				<td>
					<select id="categoryNameId" name = "categoryName">
						<%
							for(HashMap<String, Object> cMap : cList) {
								
						%>
							<option value="<%=cMap.get("categoryName")%>">
									<%=cMap.get("categoryName")%>
							</option>
						<% 
							}
						%>
					</select>
					<span id="categoryNameIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<th>상품 이름</th>
				<td>
					<input type="text" id="nameId" name="productName" >
					<span id="nameIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<th>상품 가격</th>
				<td>
					<input type="text" id="priceId" name="productPrice" placeholder="숫자만 입력해주세요">
					<span id="priceIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<!--  ENUM으로 값이 설정되어 있어 세가지중 하나를 선택하여 보냄 -->
				<th>상품 상태</th>
				<td>
					<select id="statusId" name="productStatus">
						<option value="판매중">판매중</option>
						<option value="품절">품절</option>
						<option value="단종">단종</option>
					</select>
					<span id="statusIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<th>상품 재고량</th>
				<td>
					<input type="text" id="stockId" name="productStock" placeholder="숫자로 입력해주세요">
					<span id="stockIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<th>상품 설명</th>
				<td>
					<textarea rows="3" cols="50" id="infoId" name="productInfo"></textarea>
					<span id="infoIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<th>상품 사진</th>
				<td>
					<!-- 사진 파일 전송 -->
					<input type="file" id="fileId" name="productFile">
					<span id="fileIdMsg" class="msg"></span>
				</td>
			</tr>
		</table>
		<button type="submit" id="productBtn">상품추가</button>
		<button type="reset">초기화</button>
	</form>
</body>
</html>