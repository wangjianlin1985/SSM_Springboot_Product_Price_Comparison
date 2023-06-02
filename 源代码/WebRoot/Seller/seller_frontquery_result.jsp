<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Seller" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Seller> sellerList = (List<Seller>)request.getAttribute("sellerList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String sellerName = (String)request.getAttribute("sellerName"); //商家名称查询关键字
    String sellerTelephone = (String)request.getAttribute("sellerTelephone"); //商家电话查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>商家查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Seller/frontlist">商家信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Seller/seller_frontAdd.jsp" style="display:none;">添加商家</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<sellerList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Seller seller = sellerList.get(i); //获取到商家对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Seller/<%=seller.getSellerId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=seller.getSellerLogo()%>" /></a>
			     <div class="showFields">
			     	 
			     	<div class="field">
	            		商家名称:<%=seller.getSellerName() %>
			     	</div>
			     	<div class="field">
	            		商家介绍:<%=seller.getSellerDesc() %>
			     	</div>
			     	<div class="field">
	            		商家电话:<%=seller.getSellerTelephone() %>
			     	</div>
			     	<div class="field">
	            		商家地址:<%=seller.getSellerAddress() %>
			     	</div>
			     	<div class="field">
	            		商家网站:<%=seller.getSellerSite() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Seller/<%=seller.getSellerId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="sellerEdit('<%=seller.getSellerId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="sellerDelete('<%=seller.getSellerId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>商家查询</h1>
		</div>
		<form name="sellerQueryForm" id="sellerQueryForm" action="<%=basePath %>Seller/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="sellerName">商家名称:</label>
				<input type="text" id="sellerName" name="sellerName" value="<%=sellerName %>" class="form-control" placeholder="请输入商家名称">
			</div>
			<div class="form-group">
				<label for="sellerTelephone">商家电话:</label>
				<input type="text" id="sellerTelephone" name="sellerTelephone" value="<%=sellerTelephone %>" class="form-control" placeholder="请输入商家电话">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="sellerEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;商家信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="sellerEditForm" id="sellerEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="seller_sellerId_edit" class="col-md-3 text-right">商家id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="seller_sellerId_edit" name="seller.sellerId" class="form-control" placeholder="请输入商家id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="seller_sellerName_edit" class="col-md-3 text-right">商家名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_sellerName_edit" name="seller.sellerName" class="form-control" placeholder="请输入商家名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_sellerLogo_edit" class="col-md-3 text-right">商家logo:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="seller_sellerLogoImg" border="0px"/><br/>
			    <input type="hidden" id="seller_sellerLogo" name="seller.sellerLogo"/>
			    <input id="sellerLogoFile" name="sellerLogoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_sellerDesc_edit" class="col-md-3 text-right">商家介绍:</label>
		  	 <div class="col-md-9">
			    <textarea id="seller_sellerDesc_edit" name="seller.sellerDesc" rows="8" class="form-control" placeholder="请输入商家介绍"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_sellerTelephone_edit" class="col-md-3 text-right">商家电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_sellerTelephone_edit" name="seller.sellerTelephone" class="form-control" placeholder="请输入商家电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_sellerAddress_edit" class="col-md-3 text-right">商家地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_sellerAddress_edit" name="seller.sellerAddress" class="form-control" placeholder="请输入商家地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="seller_sellerSite_edit" class="col-md-3 text-right">商家网站:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="seller_sellerSite_edit" name="seller.sellerSite" class="form-control" placeholder="请输入商家网站">
			 </div>
		  </div>
		</form> 
	    <style>#sellerEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSellerModify();">提交</button>
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
    document.sellerQueryForm.currentPage.value = currentPage;
    document.sellerQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.sellerQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.sellerQueryForm.currentPage.value = pageValue;
    documentsellerQueryForm.submit();
}

/*弹出修改商家界面并初始化数据*/
function sellerEdit(sellerId) {
	$.ajax({
		url :  basePath + "Seller/" + sellerId + "/update",
		type : "get",
		dataType: "json",
		success : function (seller, response, status) {
			if (seller) {
				$("#seller_sellerId_edit").val(seller.sellerId);
				$("#seller_sellerName_edit").val(seller.sellerName);
				$("#seller_sellerLogo").val(seller.sellerLogo);
				$("#seller_sellerLogoImg").attr("src", basePath +　seller.sellerLogo);
				$("#seller_sellerDesc_edit").val(seller.sellerDesc);
				$("#seller_sellerTelephone_edit").val(seller.sellerTelephone);
				$("#seller_sellerAddress_edit").val(seller.sellerAddress);
				$("#seller_sellerSite_edit").val(seller.sellerSite);
				$('#sellerEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除商家信息*/
function sellerDelete(sellerId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Seller/deletes",
			data : {
				sellerIds : sellerId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#sellerQueryForm").submit();
					//location.href= basePath + "Seller/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交商家信息表单给服务器端修改*/
function ajaxSellerModify() {
	$.ajax({
		url :  basePath + "Seller/" + $("#seller_sellerId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#sellerEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#sellerQueryForm").submit();
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

})
</script>
</body>
</html>

