<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*"%>

<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("utf-8");

	// 받아온 값 유효성 검사
	if(request.getParameter("id")==null
		|| request.getParameter("totalCartCnt")==null
		|| request.getParameter("totalPay")==null
		|| request.getParameter("selectAddress")==null
		|| request.getParameter("inputPoint")==null
		|| request.getParameter("id").equals("")
		|| request.getParameter("totalCartCnt").equals("")
		|| request.getParameter("totalPay").equals("")
		|| request.getParameter("selectAddress").equals("")
		|| request.getParameter("inputPoint").equals("")){
		response.sendRedirect(request.getContextPath()+"/cart/cartOrder.jsp");
		return;
	}
	String id = request.getParameter("id");
	int totalCartCnt = Integer.parseInt(request.getParameter("totalCartCnt"));
	int totalPay = Integer.parseInt(request.getParameter("totalPay"));
	String selectAddress = request.getParameter("selectAddress");
	int inputPoint = Integer.parseInt(request.getParameter("inputPoint"));
				
	// Dao 객체 선언
	CartDao cartDao = new CartDao();
	
	// 12. 장바구니 정보를 오더테이블에 저장
	int row1 = cartDao.insertOrder(id, totalCartCnt, totalPay, selectAddress);
	System.out.println(row1 + " <-- cartOrderAction row1");
	
	// 13. 장바구니에서 아이디가 ?이고 체크가 Y인 여러개의 상품번호와 상품 수량 가져오기(14를 사용하기 위해서)
	ArrayList<Cart> list1 = new ArrayList<>();		
	list1 = cartDao.selectCart(id);
	System.out.println(list1 + " <-- cartOrderAction list1");
	
	// 14. orders_history에 저장하기
	ArrayList<Integer> list2 = new ArrayList<>();
	list2 = cartDao.insertOrdersHistory();
	System.out.println(list2 + " <-- cartOrderAction list2");
	
	// 15. 포인트 사용한 만큼 보유포인트에서 차감(-)
	int row2 = cartDao.customerPointMinus(inputPoint, id);
	System.out.println(row2 + " <-- cartOrderAction row2");
	
	// 16. 총 결제금액의 1%만큼 포인트 적립(+)
	int row3 = cartDao.customerPointPlus(totalPay, id);
	System.out.println(row3 + " <-- cartOrderAction row3");
	
	// 17. 포인트 이력에 사용한 포인트(-) 저장
	int row4 = cartDao.pointHistoryMinus(inputPoint);
	System.out.println(row4 + " <-- cartOrderAction row4");
	
	// 18. 포인트 이력에 결제 후 적립된 포인트(+) 저장
	int row5 = cartDao.pointHistoryPlus(totalPay, id);
	System.out.println(row5 + " <-- cartOrderAction row5");
	
	// 19. 결제 후 장바구니에서 체크 된 상품 전체 삭제
	int row6 = cartDao.deleteCheckedCart(id);
	System.out.println(row6 + " <-- cartOrderAction row6");
	
	// 20. 결제 완료 상태로 변경 수정
	int row7 = cartDao.updatePaymentStatus(id);
	System.out.println(row7 + " <-- cartOrderAction row7");
	
	if(row1>0 && row2>0 && row3>0 && row4>0 && row5>0 && row6>0 && row7>0) {
		System.out.println("결제 성공");
		out.println("<script>alert('결제가 완료되었습니다.'); location.href='"+request.getContextPath()+"/main/home.jsp';</script>");
		return;
	} else {
		System.out.println("결제 실패");
		response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
		return;
	}
	
	

%>