<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单交易图表</title>
<script src="ECharts/echarts.min.js"></script>
<script src="jquery/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function (){
	    // 页面加载完毕后，绘制统计图表
	    getCharts();
	    getCharts2();
	});
	function getCharts(){
		$.ajax({
            url : "adminOrder/getCharts",
            type : "get",
            dataType : "json",
            success : function (data) {
				// 基于准备好的dom，初始化echarts实例
		        var myChart = echarts.init(document.getElementById('main'));
		        // 指定图表的配置项和数据（option：我们要画的图）
		        var option = {
		            title: {
		                text: '订单交易漏斗图',
		                subtext: '统计交易阶段数量的漏斗图'
		            },
		            series: [
		                {
		                    name:'订单交易漏斗图',
		                    type:'funnel',
		                    left: '10%',
		                    top: 60,
		                    bottom: 60,
		                    width: '80%',
		                    min: 0,
		                    max: data.total,
		                    minSize: '0%',
		                    maxSize: '100%',
		                    sort: 'descending',
		                    gap: 2,
		                    label: {
		                        show: true,
		                        position: 'inside'
		                    },
		                    labelLine: {
		                        length: 10,
		                        lineStyle: {
		                            width: 1,
		                            type: 'solid'
		                        }
		                    },
		                    itemStyle: {
		                        borderColor: '#fff',
		                        borderWidth: 1
		                    },
		                    emphasis: {
		                        label: {
		                            fontSize: 20
		                        }
		                    },
		                    data: data.dataList
		                }
		            ]
		        };
		        // 使用刚指定的配置项和数据显示图表。
		        myChart.setOption(option);
            }
		});
	}
	function getCharts2(){
		$.ajax({
            url : "adminOrder/getChartsOfTop5Sale",
            type : "get",
            dataType : "json",
            success : function (data) {
            	console.log(data);
            	var xArr = [];
            	var yArr = [];
            	$.each(data, function(i,n){
            		xArr.push(i);//图书名
            		yArr.push(n);//销量
            	});
            	console.log(xArr);
            	console.log(yArr);
		        var myChart = echarts.init(document.getElementById('main2'));
				var option = {
					title : {
						text : '热销图书'
					},
			        tooltip: {
			        	trigger: 'axis',
			        },
			        legend: {
			        	data: ['销量']
			        },
				    xAxis: {
				    	name: '图书',
				        type: 'category',
				        data: xArr,
				        axisLabel: { interval: 0, rotate: -15 }
				    },
				    yAxis: {
				    	name: '销量'
				    },
				    series: {
				    	name: '销量',
				        type: 'bar',
				        data : yArr
				    }
				};
		        myChart.setOption(option);
            }
		});
	}
</script>
</head>
<body>
	<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
	<div id="main" style="width: 50%;height:400px;"></div>
	<div id="main2" style="width: 100%;height:400px;"></div>
</body>
</html>