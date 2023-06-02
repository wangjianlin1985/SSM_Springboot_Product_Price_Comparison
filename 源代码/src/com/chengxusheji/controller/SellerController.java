package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.SellerService;
import com.chengxusheji.po.Seller;

//Seller管理控制层
@Controller
@RequestMapping("/Seller")
public class SellerController extends BaseController {

    /*业务层对象*/
    @Resource SellerService sellerService;

	@InitBinder("seller")
	public void initBinderSeller(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("seller.");
	}
	/*跳转到添加Seller视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Seller());
		return "Seller_add";
	}

	/*客户端ajax方式提交添加商家信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Seller seller, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			seller.setSellerLogo(this.handlePhotoUpload(request, "sellerLogoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        sellerService.addSeller(seller);
        message = "商家添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询商家信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String sellerName,String sellerTelephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (sellerName == null) sellerName = "";
		if (sellerTelephone == null) sellerTelephone = "";
		if(rows != 0)sellerService.setRows(rows);
		List<Seller> sellerList = sellerService.querySeller(sellerName, sellerTelephone, page);
	    /*计算总的页数和总的记录数*/
	    sellerService.queryTotalPageAndRecordNumber(sellerName, sellerTelephone);
	    /*获取到总的页码数目*/
	    int totalPage = sellerService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = sellerService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Seller seller:sellerList) {
			JSONObject jsonSeller = seller.getJsonObject();
			jsonArray.put(jsonSeller);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询商家信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Seller> sellerList = sellerService.queryAllSeller();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Seller seller:sellerList) {
			JSONObject jsonSeller = new JSONObject();
			jsonSeller.accumulate("sellerId", seller.getSellerId());
			jsonSeller.accumulate("sellerName", seller.getSellerName());
			jsonArray.put(jsonSeller);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询商家信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String sellerName,String sellerTelephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (sellerName == null) sellerName = "";
		if (sellerTelephone == null) sellerTelephone = "";
		List<Seller> sellerList = sellerService.querySeller(sellerName, sellerTelephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    sellerService.queryTotalPageAndRecordNumber(sellerName, sellerTelephone);
	    /*获取到总的页码数目*/
	    int totalPage = sellerService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = sellerService.getRecordNumber();
	    request.setAttribute("sellerList",  sellerList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("sellerName", sellerName);
	    request.setAttribute("sellerTelephone", sellerTelephone);
		return "Seller/seller_frontquery_result"; 
	}

     /*前台查询Seller信息*/
	@RequestMapping(value="/{sellerId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer sellerId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键sellerId获取Seller对象*/
        Seller seller = sellerService.getSeller(sellerId);

        request.setAttribute("seller",  seller);
        return "Seller/seller_frontshow";
	}

	/*ajax方式显示商家修改jsp视图页*/
	@RequestMapping(value="/{sellerId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer sellerId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键sellerId获取Seller对象*/
        Seller seller = sellerService.getSeller(sellerId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSeller = seller.getJsonObject();
		out.println(jsonSeller.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新商家信息*/
	@RequestMapping(value = "/{sellerId}/update", method = RequestMethod.POST)
	public void update(@Validated Seller seller, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String sellerLogoFileName = this.handlePhotoUpload(request, "sellerLogoFile");
		if(!sellerLogoFileName.equals("upload/NoImage.jpg"))seller.setSellerLogo(sellerLogoFileName); 


		try {
			sellerService.updateSeller(seller);
			message = "商家更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "商家更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除商家信息*/
	@RequestMapping(value="/{sellerId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer sellerId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  sellerService.deleteSeller(sellerId);
	            request.setAttribute("message", "商家删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "商家删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条商家记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String sellerIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = sellerService.deleteSellers(sellerIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出商家信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String sellerName,String sellerTelephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(sellerName == null) sellerName = "";
        if(sellerTelephone == null) sellerTelephone = "";
        List<Seller> sellerList = sellerService.querySeller(sellerName,sellerTelephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Seller信息记录"; 
        String[] headers = { "商家id","商家名称","商家logo","商家介绍","商家电话","商家地址","商家网站"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<sellerList.size();i++) {
        	Seller seller = sellerList.get(i); 
        	dataset.add(new String[]{seller.getSellerId() + "",seller.getSellerName(),seller.getSellerLogo(),seller.getSellerDesc(),seller.getSellerTelephone(),seller.getSellerAddress(),seller.getSellerSite()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Seller.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
