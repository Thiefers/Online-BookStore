$(function(){
	showTotal();
	// 给全选框绑定click事件
	$("#selectAll").click(function(){
		// 获取全选状态
		var	bool = $("#selectAll").prop("checked");
		// 让所有条目的复选框与全选的状态同步
		setItemCheckBox(bool);
		// 让结算按钮与全选同步
		setJieSuan(bool);
		// 重新计算总计
		showTotal();
	});
/*
$("#activityBody").on("click",$("input[name=xz]"),function (){
	$("#checkAll").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);
})
动态生成的元素，要以on方法的形式来触发事件
语法：$(需要绑定元素的有效的外层元素).on(绑定事件的方式,需要绑定的元素的jquery对象,回调函数)
*/
	// 给所有条目的复选框添加click事件 cartitemBody
	$("#cartitemBody").on("click",$("input[name=checkboxBtn]"),function (){
		$("#checkAll").prop("checked",$("input[name=checkboxBtn]").length==$("input[name=checkboxBtn]:checked").length);
		if($("input[name=checkboxBtn]").length==$("input[name=checkboxBtn]:checked").length){
			$("#selectAll").prop("checked",true);// 勾上全选框
			setJieSuan(true);// 结算按钮生效
		} else if($("input[name=checkboxBtn]:checked").length == 0) {
			$("#selectAll").prop("checked",false);// 取消全选框
			setJieSuan(false);// 结算按钮失效
		} else {
			$("#selectAll").prop("checked",false);// 取消全选框
			setJieSuan(true);// 结算按钮生效
		}
		showTotal();
	});

	// 给减号添加click事件
	$(".jian").click(function(){
		// 获取条目ID
		var id = $(this).attr("id").substring(0,32);
//		console.log(id);
		// 获取当前条目数量
		var quantity = $("#"+id+"Quantity").val();
		// 数量为1则询问删除，否则就是减
//		console.log(quantity);
		if(quantity == 1){
			if(confirm("请确认是否删除该商品？")){
				location = "/ssm-bookshop/cartItem/batchDelete?cartItemIds="+id;
			}
		} else {
			sendUpdateQuantity(id, Number(quantity)-1);
		}
	})

	// 给加号添加click事件
	$(".jia").click(function(){
		var id = $(this).attr("id").substring(0,32);
		var quantity = $("#"+id+"Quantity").val();
//		console.log(quantity);
		sendUpdateQuantity(id, Number(quantity)+1);
	})
})

// 计算总计
function showTotal(){
	var total = 0;
	// 1. 获取所有的被勾选的条目复选框！循环遍历之
//	$(":checkbox[name=checkboxBtn][checked=checked]").each(function(){
	$("input[name=checkboxBtn]:checked").each(function(){
		// 2. 获取复选框的值，即其他元素的前缀
		var id = $(this).val();
		// 3. 再通过前缀找到小计元素，获取其文本
		var text = $("#"+id+"Subtotal").text();
		// 4. 累加计算
		total += Number(text);
	});
	 console.log("total: " + total);
	// 5. 把总计显示在总计元素上
	$("#total").text(round(total,2));
}

// 统一设置所有条目的复选按钮
function setItemCheckBox(bool){
	$(":checkbox[name=checkboxBtn]").prop("checked",bool);
}

// 设置结算按钮样式
function setJieSuan(bool) {
	if(bool) {
		$("#jiesuan").removeClass("kill").addClass("jiesuan");
		$("#jiesuan").unbind("click");//撤消当前元素上所有click事件
	} else {
		$("#jiesuan").removeClass("jiesuan").addClass("kill");
		$("#jiesuan").click(function() {return false;});
	}
}

// 批量删除
function batchDelete(){
	var cartItemIdArray = new Array();
	$("input[name=checkboxBtn]:checked").each(function(){
		cartItemIdArray.push($(this).val());
	});
	if(confirm("请确认是否删除选中商品？")){
		location = "/ssm-bookshop/cartItem/batchDelete?cartItemIds="+cartItemIdArray;
	}
}

// 请求服务器，修改数量
function sendUpdateQuantity(id, quantity){
	$.ajax({
		url : "/ssm-bookshop/cartItem/updateQuantity",
		data : {
			cartitemId : id,
			quantity : quantity
		},
		type : "POST",
		dateType : "json",
		async : false,
		cache : false,
		success : function(result){
			console.log(result);
			// 修改数量
			$("#"+id+"Quantity").val(result.quantity);
			// 修改小计
			$("#"+id+"Subtotal").text(result.subtotal);
			// 更新总计
			showTotal();
		}
	});
}

// 设置结算
function jiesuan(){
	var cartItemIdArray = new Array();
	$("input[name=checkboxBtn]:checked").each(function(){
		cartItemIdArray.push($(this).val());
	});
	$("#cartItemIds").val(cartItemIdArray.toString());
	$("#hiddenTotal").val($("#total").text());
	$("#jieSuanForm").submit();
}