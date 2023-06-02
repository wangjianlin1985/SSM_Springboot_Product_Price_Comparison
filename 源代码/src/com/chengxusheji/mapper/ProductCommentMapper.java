package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.ProductComment;

public interface ProductCommentMapper {
	/*添加商品评论信息*/
	public void addProductComment(ProductComment productComment) throws Exception;

	/*按照查询条件分页查询商品评论记录*/
	public ArrayList<ProductComment> queryProductComment(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有商品评论记录*/
	public ArrayList<ProductComment> queryProductCommentList(@Param("where") String where) throws Exception;

	/*按照查询条件的商品评论记录数*/
	public int queryProductCommentCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条商品评论记录*/
	public ProductComment getProductComment(int commentId) throws Exception;

	/*更新商品评论记录*/
	public void updateProductComment(ProductComment productComment) throws Exception;

	/*删除商品评论记录*/
	public void deleteProductComment(int commentId) throws Exception;

}
