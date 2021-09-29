<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PAY</title>
<link rel="stylesheet" type="text/css" href="jsps/css/order/pay.css">
<script type="text/javascript" src="jquery/jquery-3.5.1.min.js"></script>

<script type="text/javascript">
	$(function() {
		$("img").click(function() {
			$("#" + $(this).attr("name")).attr("checked", true);
		});
	});
</script>
</head>
<body>
	<div class="divContent">
		<span class="spanPrice">支付金额：</span><span class="price_t">&yen;${order.total}</span>
		<span class="spanOid">编号：${order.oId}</span>
	</div>
	<form action="order/payment" method="post" id="form1">
		<input type="hidden" name="oId" value="${order.oId}" />
		<div class="divBank">
			<div class="divText">选择网上银行</div>
			<div style="margin-left: 20px;">
				<div style="margin-bottom: 20px;">
					<input id="ICBC-NET-B2C" type="radio" name="yh" value="ICBC-NET-B2C" checked="checked" />
					<img name="ICBC-NET-B2C" align="middle" src="bank_img/icbc.bmp" />
					<input id="CMBCHINA-NET-B2C" type="radio" name="yh" value="CMBCHINA-NET-B2C" />
					<img name="CMBCHINA-NET-B2C" align="middle" src="bank_img/cmb.bmp" />
					<input id="ABC-NET-B2C" type="radio" name="yh" value="ABC-NET-B2C" />
					<img name="ABC-NET-B2C" align="middle" src="bank_img/abc.bmp" />
					<input id="CCB-NET-B2C" type="radio" name="yh" value="CCB-NET-B2C" />
					<img name="CCB-NET-B2C" align="middle" src="bank_img/ccb.bmp" />
				</div>
				<div style="margin-bottom: 20px;">
					<input id="BCCB-NET-B2C" type="radio" name="yh" value="BCCB-NET-B2C" />
					<img name="BCCB-NET-B2C" align="middle" src="bank_img/bj.bmp" />
					<input id="BOCO-NET-B2C" type="radio" name="yh" value="BOCO-NET-B2C" />
					<img name="BOCO-NET-B2C" align="middle" src="bank_img/bcc.bmp" />
					<input id="CIB-NET-B2C" type="radio" name="yh" value="CIB-NET-B2C" />
					<img name="CIB-NET-B2C" align="middle" src="bank_img/cib.bmp" />
					<input id="NJCB-NET-B2C" type="radio" name="yh" value="NJCB-NET-B2C" />
					<img name="NJCB-NET-B2C" align="middle" src="bank_img/nanjing.bmp" />
				</div>
				<div style="margin-bottom: 20px;">
					<input id="CMBC-NET-B2C" type="radio" name="yh" value="CMBC-NET-B2C" />
					<img name="CMBC-NET-B2C" align="middle" src="bank_img/cmbc.bmp" />
					<input id="CEB-NET-B2C" type="radio" name="yh" value="CEB-NET-B2C" />
					<img name="CEB-NET-B2C" align="middle" src="bank_img/guangda.bmp" />
					<input id="BOC-NET-B2C" type="radio" name="yh" value="BOC-NET-B2C" />
					<img name="BOC-NET-B2C" align="middle" src="bank_img/bc.bmp" />
					<input id="PINGANBANK-NET" type="radio" name="yh" value="PINGANBANK-NET" />
					<img name="PINGANBANK-NET" align="middle" src="bank_img/pingan.bmp" />
				</div>
				<div style="margin-bottom: 20px;">
					<input id="CBHB-NET-B2C" type="radio" name="yh" value="CBHB-NET-B2C" />
					<img name="CBHB-NET-B2C" align="middle" src="bank_img/bh.bmp" />
					<input id="HKBEA-NET-B2C" type="radio" name="yh" value="HKBEA-NET-B2C" />
					<img name="HKBEA-NET-B2C" align="middle" src="bank_img/dy.bmp" />
					<input id="NBCB-NET-B2C" type="radio" name="yh" value="NBCB-NET-B2C" />
					<img name="NBCB-NET-B2C" align="middle" src="bank_img/ningbo.bmp" />
					<input id="ECITIC-NET-B2C" type="radio" name="yh" value="ECITIC-NET-B2C" />
					<img name="ECITIC-NET-B2C" align="middle" src="bank_img/zx.bmp" />
				</div>
				<div style="margin-bottom: 20px;">
					<input id="SDB-NET-B2C" type="radio" name="yh" value="SDB-NET-B2C" />
					<img name="SDB-NET-B2C" align="middle" src="bank_img/sfz.bmp" />
					<input id="GDB-NET-B2C" type="radio" name="yh" value="GDB-NET-B2C" />
					<img name="GDB-NET-B2C" align="middle" src="bank_img/gf.bmp" />
					<input id="SHB-NET-B2C" type="radio" name="yh" value="SHB-NET-B2C" />
					<img name="SHB-NET-B2C" align="middle" src="bank_img/sh.bmp" />
					<input id="SPDB-NET-B2C" type="radio" name="yh" value="SPDB-NET-B2C" />
					<img name="SPDB-NET-B2C" align="middle" src="bank_img/shpd.bmp" />
				</div>
				<div style="margin-bottom: 20px;">
					<input id="POST-NET-B2C" type="radio" name="yh" value="POST-NET-B2C" />
					<img name="POST-NET-B2C" align="middle" src="bank_img/post.bmp" />
					<input id="BJRCB-NET-B2C" type="radio" name="yh" value="BJRCB-NET-B2C" />
					<img name="BJRCB-NET-B2C" align="middle" src="bank_img/beijingnongshang.bmp" />
					<input id="HXB-NET-B2C" type="radio" name="yh" value="HXB-NET-B2C" />
					<img name="HXB-NET-B2C" align="middle" src="bank_img/hx.bmp" />
					<input id="CZ-NET-B2C" type="radio" name="yh" value="CZ-NET-B2C" />
					<img name="CZ-NET-B2C" align="middle" src="bank_img/zheshang.bmp" />
				</div>
			</div>
			<div style="margin: 40px;">
				<a href="javascript:void $('#form1').submit();" class="linkNext">支付</a>
			</div>
		</div>
	</form>
</body>
</html>