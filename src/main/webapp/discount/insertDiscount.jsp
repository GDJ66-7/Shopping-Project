<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>

<%
	// 유효성 검사 상품 번호를 이용하여 할인가격을 추가시키기 때문에 상품번호가 필수적
	if(request.getParameter("productNo") == null) {
		response.sendRedirect(request.getContextPath()+"/main/empMain.jsp");
		return;
	}

	String productName = request.getParameter("productName");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	// 디버깅
	System.out.println(productNo + "insertDiscount productNo");
	System.out.println(productName + "insertDiscount productName");
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할인 상품 추가</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
				
	// jQuery 유효성검사
	$(document).ready(function(){
		// 전송 유효성 검사 값이 하나라도 미입력시 전송x
		$('#insertDiscountBtn').click(function(){
			
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
			
			$('#insertDiscountForm').submit();
				
			
		});
		
	});
	
</script>
</head>
<body>
	<h1>할인 상품 추가하기</h1>
	<form id="insertDiscountForm" action="<%=request.getContextPath()%>/discount/insertDiscountAction.jsp">
		<input type="hidden" name="productNo" value="<%=productNo%>">;
		<table>
			<tr>
				<th>productName</th>
				<td>
					<input type="text" value="<%=productName %>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>discount_start</th>
				<td>
					<input id="discountStartId" type="datetime-local" name="discountStart">
					<span id="discountStartIdMsg" class="msg"></span>
				</td>
			</tr>	
			<tr>
				<th>discount_end</th>
				<td>
					<input id="discountEndId" type="datetime-local" name="discountEnd">
					<span id="discountEndIdMsg" class="msg"></span>
				</td>
			</tr>	
			<tr>
				<th>discount_rate</th>
				<td>
					<input id="discountRateId" type="text" name="discountRate" placeholder="1~99 사이로 입력해주세요(%로자동계산)">
					<span id="discountRateIdMsg" class="msg"></span>
				</td>
			</tr>		
		</table>
		<button id="insertDiscountBtn" type="button">할인추가</button>
	</form>
</body>
</html>