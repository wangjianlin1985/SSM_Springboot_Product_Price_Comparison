package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Product;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.ProductComment;

import com.chengxusheji.mapper.ProductCommentMapper;
@Service
public class ProductCommentService {

	@Resource ProductCommentMapper productCommentMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加商品评论记录*/
    public void addProductComment(ProductComment productComment) throws Exception {
    	productCommentMapper.addProductComment(productComment);
    }

    /*按照查询条件分页查询商品评论记录*/
    public ArrayList<ProductComment> queryProductComment(Product productObj,UserInfo userObj,String commentTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_productComment.productObj=" + productObj.getProductId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_productComment.userObj='" + userObj.getUser_name() + "'";
    	if(!commentTime.equals("")) where = where + " and t_productComment.commentTime like '%" + commentTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return productCommentMapper.queryProductComment(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ProductComment> queryProductComment(Product productObj,UserInfo userObj,String commentTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_productComment.productObj=" + productObj.getProductId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_productComment.userObj='" + userObj.getUser_name() + "'";
    	if(!commentTime.equals("")) where = where + " and t_productComment.commentTime like '%" + commentTime + "%'";
    	return productCommentMapper.queryProductCommentList(where);
    }

    /*查询所有商品评论记录*/
    public ArrayList<ProductComment> queryAllProductComment()  throws Exception {
        return productCommentMapper.queryProductCommentList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Product productObj,UserInfo userObj,String commentTime) throws Exception {
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_productComment.productObj=" + productObj.getProductId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_productComment.userObj='" + userObj.getUser_name() + "'";
    	if(!commentTime.equals("")) where = where + " and t_productComment.commentTime like '%" + commentTime + "%'";
        recordNumber = productCommentMapper.queryProductCommentCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取商品评论记录*/
    public ProductComment getProductComment(int commentId) throws Exception  {
        ProductComment productComment = productCommentMapper.getProductComment(commentId);
        return productComment;
    }

    /*更新商品评论记录*/
    public void updateProductComment(ProductComment productComment) throws Exception {
        productCommentMapper.updateProductComment(productComment);
    }

    /*删除一条商品评论记录*/
    public void deleteProductComment (int commentId) throws Exception {
        productCommentMapper.deleteProductComment(commentId);
    }

    /*删除多条商品评论信息*/
    public int deleteProductComments (String commentIds) throws Exception {
    	String _commentIds[] = commentIds.split(",");
    	for(String _commentId: _commentIds) {
    		productCommentMapper.deleteProductComment(Integer.parseInt(_commentId));
    	}
    	return _commentIds.length;
    }
}
