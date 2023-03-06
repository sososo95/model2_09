<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%--
<%@page import="com.model2.mvc.common.util.CommonUtil"%>
<%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.service.domain.*" %>
<%@ page import="com.model2.mvc.common.*" %>


<%
	String title = null;
	String type = null;
	String window = null;

	if(request.getParameter("menu") != null){
		if(request.getParameter("menu").equals("search")){
	title = "��ǰ �����ȸ";
	type = "search";
	window = "/getProduct.do";
	System.out.println("��ǰ ��� ��ȸ �켱 �̻���� ����Ǿ����ϴ�.");
		} else {
	title = "��ǰ ����";
	type = "manage";
	window = "/updateProductView.do";
	System.out.println("������Ʈ �������� �켱 �̻���� ����Ǿ����ϴ�.");
		}
	}
	
	
	List<Product> list= (List<Product>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");

	Search searchVO = (Search)request.getAttribute("search");
	
	String searchCondition = CommonUtil.null2str(searchVO.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(searchVO.getSearchKeyword());
%>
--%>
<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	function fncGetProductList(page, type){
		$("#page").val(page);
		$("#type").val(type);
		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu}").submit();
	}

	
	$(function() {
		
		
		 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
	
			 fncGetProductList('${resultPage.page}','${param.menu}');
		});

		 	 
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
				self.location ="${param.menu == 'manage'? "/product/updateProduct?prodNo=" : "/product/getProduct?prodNo="}" + $(this).find("input").val();
		});
		
				
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "blue");
		
					
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
	});	

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
						${ param.menu == 'manage' ? "��ǰ ����" : "��ǰ �����ȸ" }
		
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">

				<option value="0" ${param.searchCondition == '0' ? "selected" : ""} >��ǰ��ȣ</option>
				<option value="1" ${param.searchCondition == '1' ? "selected" : ""} >��ǰ��</option>
				<option value="2" ${param.searchCondition == '2' ? "selected" : ""} >��ǰ����</option>

			</select>
			<input type="text" name="searchKeyword"  value="${param.searchKeyword}" class="ct_input_g" style="width:200px; height:19px" />
		</td>
	
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!--  <a href="javascript:fncGetProductList('${resultPage.page}','${param.menu}');">�˻�</a>-->
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.page} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>		
	</tr>
	
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<c:forEach var= "i" items="${list}">
		<c:set var="num" value="${ num+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${num}</td>
			<td></td>
			<td align="left">
			
			<c:choose>
			 <%-- <% if(productvo.getProTranCode() == null || productvo.getProTranCode().trim().equals("0")){ --%>
				<c:when test = "${ fn:trim(i.tranCode) eq '' }" >
					<!-- <a href="${param.menu == 'manage'?"/product/updateProduct?":"/product/getProduct?"}&prodNo=${i.prodNo}">${i.prodName}</a> -->
						${i.prodName}  <input type="hidden" value="${i.prodNo}" id="prodNo"  />
				</c:when>
				 <c:otherwise>
				 	${i.prodName} <input type="hidden" value="${i.prodNo}" id="prodNo"  />
				 </c:otherwise>
			</c:choose>
				
						
			</td>
			<td></td>
			<td align="left">${i.price}</td>
			<td></td>
			<td align="left">${i.regDate}
			</td>
			<td></td>
			<td align="left">
		

					
					<c:if test = "${ sessionScope.user.userId eq 'admin'}" >
						<c:choose>
							<c:when test = "${ fn:trim(i.tranCode) eq '' }">
								�Ǹ���
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '1' and (param.menu == 'manage')}" >
								���ſϷ� <a href="/purchase/updateTranCodeByProd?prodNo=${i.prodNo}&tranCode=2">����ϱ�</a>
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '1' and (param.menu != 'manage')}" >
								���ſϷ�
							</c:when>
							<c:when test = "${ fn:trim(i.tranCode) eq '2' }" >
								�����
							</c:when>
							<c:otherwise>
							 	��ۿϷ�
							 </c:otherwise>
						</c:choose>
					</c:if>
					

					<c:if test = "${sessionScope.user.userId ne 'admin'}" >
						<c:choose>
							<c:when test = "${ fn:trim(i.tranCode) eq '' }">
								�Ǹ���
							</c:when>
							<c:otherwise>
							 	������
							 </c:otherwise>
						</c:choose>
					</c:if>
					
		
			</td>			
		</tr>
		
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		
		<input type="hidden" id="page" name="page" value=""/>
		<input type="hidden" id="type" name="type" value=""/>
		<jsp:include page="../common/pageNavigator.jsp"/>	
		
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->


</form>

</div>
</body>
</html>
