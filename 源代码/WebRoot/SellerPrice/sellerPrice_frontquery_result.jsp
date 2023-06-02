﻿<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.SellerPrice" %>
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.Seller" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<SellerPrice> sellerPriceList = (List<SellerPrice>)request.getAttribute("sellerPriceList");
    //获取所有的productObj信息
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的sellerObj信息
    List<Seller> sellerList = (List<Seller>)request.getAttribute("sellerList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Product productObj = (Product)request.getAttribute("productObj");
    Seller sellerObj = (Seller)request.getAttribute("sellerObj");
    String priceDate = (String)request.getAttribute("priceDate"); //报价日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>商家价格查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#sellerPriceListPanel" aria-controls="sellerPriceListPanel" role="tab" data-toggle="tab">商家价格列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>SellerPrice/sellerPrice_frontAdd.jsp" style="display:none;">添加商家价格</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="sellerPriceListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>商品信息</td><td>商品报价</td><td>报价商家</td><td>报价日期</td><td>购买链接</td><td style="display:none;">操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<sellerPriceList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		SellerPrice sellerPrice = sellerPriceList.get(i); //获取到商家价格对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=sellerPrice.getProductObj().getProductName() %></td>
 											<td style="color:red;">¥<%=sellerPrice.getPrice() %>元</td>
 											<td><%=sellerPrice.getSellerObj().getSellerName() %></td>
 											<td><%=sellerPrice.getPriceDate() %></td>
 											<td><a href="<%=sellerPrice.getBuyAddress() %>" target="_blank">我要购买</a></td>
 											<td  style="display:none;">
 												<a href="<%=basePath  %>SellerPrice/<%=sellerPrice.getPriceId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="sellerPriceEdit('<%=sellerPrice.getPriceId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="sellerPriceDelete('<%=sellerPrice.getPriceId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>商家价格查询</h1>
		</div>
		<form name="sellerPriceQueryForm" id="sellerPriceQueryForm" action="<%=basePath %>SellerPrice/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="productObj_productId">商品信息：</label>
                <select id="productObj_productId" name="productObj.productId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Product productTemp:productList) {
	 					String selected = "";
 					if(productObj!=null && productObj.getProductId()!=null && productObj.getProductId().intValue()==productTemp.getProductId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=productTemp.getProductId() %>" <%=selected %>><%=productTemp.getProductName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="sellerObj_sellerId">报价商家：</label>
                <select id="sellerObj_sellerId" name="sellerObj.sellerId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Seller sellerTemp:sellerList) {
	 					String selected = "";
 					if(sellerObj!=null && sellerObj.getSellerId()!=null && sellerObj.getSellerId().intValue()==sellerTemp.getSellerId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=sellerTemp.getSellerId() %>" <%=selected %>><%=sellerTemp.getSellerName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="priceDate">报价日期:</label>
				<input type="text" id="priceDate" name="priceDate" class="form-control"  placeholder="请选择报价日期" value="<%=priceDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="sellerPriceEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;商家价格信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="sellerPriceEditForm" id="sellerPriceEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="sellerPrice_priceId_edit" class="col-md-3 text-right">价格id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="sellerPrice_priceId_edit" name="sellerPrice.priceId" class="form-control" placeholder="请输入价格id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="sellerPrice_productObj_productId_edit" class="col-md-3 text-right">商品信息:</label>
		  	 <div class="col-md-9">
			    <select id="sellerPrice_productObj_productId_edit" name="sellerPrice.productObj.productId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="sellerPrice_price_edit" class="col-md-3 text-right">商品报价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="sellerPrice_price_edit" name="sellerPrice.price" class="form-control" placeholder="请输入商品报价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="sellerPrice_sellerObj_sellerId_edit" class="col-md-3 text-right">报价商家:</label>
		  	 <div class="col-md-9">
			    <select id="sellerPrice_sellerObj_sellerId_edit" name="sellerPrice.sellerObj.sellerId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="sellerPrice_priceDate_edit" class="col-md-3 text-right">报价日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date sellerPrice_priceDate_edit col-md-12" data-link-field="sellerPrice_priceDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="sellerPrice_priceDate_edit" name="sellerPrice.priceDate" size="16" type="text" value="" placeholder="请选择报价日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="sellerPrice_buyAddress_edit" class="col-md-3 text-right">购买链接:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="sellerPrice_buyAddress_edit" name="sellerPrice.buyAddress" class="form-control" placeholder="请输入购买链接">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="sellerPrice_priceMemo_edit" class="col-md-3 text-right">备注信息:</label>
		  	 <div class="col-md-9">
			    <textarea id="sellerPrice_priceMemo_edit" name="sellerPrice.priceMemo" rows="8" class="form-control" placeholder="请输入备注信息"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#sellerPriceEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSellerPriceModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.sellerPriceQueryForm.currentPage.value = currentPage;
    document.sellerPriceQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.sellerPriceQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.sellerPriceQueryForm.currentPage.value = pageValue;
    documentsellerPriceQueryForm.submit();
}

/*弹出修改商家价格界面并初始化数据*/
function sellerPriceEdit(priceId) {
	$.ajax({
		url :  basePath + "SellerPrice/" + priceId + "/update",
		type : "get",
		dataType: "json",
		success : function (sellerPrice, response, status) {
			if (sellerPrice) {
				$("#sellerPrice_priceId_edit").val(sellerPrice.priceId);
				$.ajax({
					url: basePath + "Product/listAll",
					type: "get",
					success: function(products,response,status) { 
						$("#sellerPrice_productObj_productId_edit").empty();
						var html="";
		        		$(products).each(function(i,product){
		        			html += "<option value='" + product.productId + "'>" + product.productName + "</option>";
		        		});
		        		$("#sellerPrice_productObj_productId_edit").html(html);
		        		$("#sellerPrice_productObj_productId_edit").val(sellerPrice.productObjPri);
					}
				});
				$("#sellerPrice_price_edit").val(sellerPrice.price);
				$.ajax({
					url: basePath + "Seller/listAll",
					type: "get",
					success: function(sellers,response,status) { 
						$("#sellerPrice_sellerObj_sellerId_edit").empty();
						var html="";
		        		$(sellers).each(function(i,seller){
		        			html += "<option value='" + seller.sellerId + "'>" + seller.sellerName + "</option>";
		        		});
		        		$("#sellerPrice_sellerObj_sellerId_edit").html(html);
		        		$("#sellerPrice_sellerObj_sellerId_edit").val(sellerPrice.sellerObjPri);
					}
				});
				$("#sellerPrice_priceDate_edit").val(sellerPrice.priceDate);
				$("#sellerPrice_buyAddress_edit").val(sellerPrice.buyAddress);
				$("#sellerPrice_priceMemo_edit").val(sellerPrice.priceMemo);
				$('#sellerPriceEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除商家价格信息*/
function sellerPriceDelete(priceId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "SellerPrice/deletes",
			data : {
				priceIds : priceId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#sellerPriceQueryForm").submit();
					//location.href= basePath + "SellerPrice/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交商家价格信息表单给服务器端修改*/
function ajaxSellerPriceModify() {
	$.ajax({
		url :  basePath + "SellerPrice/" + $("#sellerPrice_priceId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#sellerPriceEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#sellerPriceQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*报价日期组件*/
    $('.sellerPrice_priceDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

