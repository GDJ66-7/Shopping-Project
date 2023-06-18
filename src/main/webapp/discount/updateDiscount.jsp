<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// discountNo를 통하여 할인정보 수정
	if(request.getParameter("discountNo") == null){
		response.sendRedirect(request.getContextPath()+"/discount/discountList.jsp");
		return;
	}

	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String productName = request.getParameter("productName");
	String discountStart = request.getParameter("discountStart");
	
	System.out.println(discountNo + "insertDiscount discountNo");
	System.out.println(productNo + "insertDiscount productNo");
	System.out.println(productName + "insertDiscount productName");
	System.out.println(discountStart + "insertDiscount discountStart");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	//jQuery 유효성검사
	$(document).ready(function(){
		// 전송 유효성 검사 값이 하나라도 미입력시 전송x
		$('#updateDiscountBtn').click(function(){
			
		    var currentDateTime = new Date(); // 현재 날짜와 시간 가져오기
		    
		    // 할인시작일이 없으면 실행
			if($('#discountStartId').val().length == 0) {
				$('#discountStartIdMsg').text('할인 시작일을 설정해주세요');
				return;
				// 할인시작일이 현재보다 이전이면 실행
			} else if(new Date($('#discountStartId').val()) < currentDateTime) {
				// 디버깅
				console.log($('#discountStartId').val());
				$('#discountStartIdMsg').text('할인 시작일을 현재보다 이전으로 설정할 수 없습니다');
				return;
			} else {
				$('#discountStartIdMsg').text('');
			}
		    
			
			if($('#discountEndId').val().length == 0) {
				$('#discountEndIdMsg').text('할인 종료일을 설정해주세요');
				return;
				// 할인종료일이 할인시작일보다 빠르면 실행
			} else if(new Date($('#discountEndId').val()) < new Date($('#discountStartId').val())) {
				console.log($('#discountEndId').val());
				$('#discountEndIdMsg').text('할인 종료일을 할인 시작일 이전으로 설정할 수 없습니다');
				return;
			} else {
				$('#discountEndIdMsg').text('');
			}
			
			
			if($('#discountRateId').val().length == 0) {
				// 디버깅
				console.log($('#discountRateId').val());
				$('#discountRateIdMsg').text('할인율을 입력해주세요');
				return;
			} else {
				$('#discountRateIdMsg').text('');
			}
			
			// 할인율을 0.0단위로 입력하기 어려울 수 있으니 10단위로 입력하면 자동으로 0.0단위로 변환
			var discountRate = parseFloat($('#discountRateId').val());
			// 할인율은 1~100까지
			if(discountRate > 0 && discountRate <= 100) {
				 $('#discountRateId').val(discountRate / 100);
			} else {
				$('#discountRateIdMsg').text('할인율은 1~99까지만 입력해주세요');
				return;
			}
			
			$('#updateDiscountForm').submit();
		});
	});
</script>
</head>
<body>
	<form id="updateDiscountForm" action="<%=request.getContextPath()%>/discount/updateDiscountAction.jsp">
		<table>
			<tr>
				<th>할인번호</th>
				<td>
					<input type="text" name="discountNo" value="<%=discountNo%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>상품번호</th>
				<td>
					<input type="text" value="<%=productNo%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>상품이름</th>
				<td>
					<input type="text" value="<%=productName%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>할인시작일</th>
				<td>
					<input id="discountStartId" type="datetime-local" name="discountStart">기존 할인 시작일: <%=discountStart%>
					<span id="discountStartIdMsg" class="msg"></span>
				</td>
			</tr>	
			<tr>
				<th>할인종료일</th>
				<td>
					<input id="discountEndId" type="datetime-local" name="discountEnd">
					<span id="discountEndIdMsg" class="msg"></span>
				</td>
			</tr>	
			<tr>
				<th>할인율</th>
				<td>
					<input id="discountRateId" type="text" name="discountRate">
					<span id="discountRateIdMsg" class="msg"></span>
				</td>
			</tr>		
		</table>
		<button id="updateDiscountBtn" type="button">할인수정</button>
	</form>
</body>
</html>