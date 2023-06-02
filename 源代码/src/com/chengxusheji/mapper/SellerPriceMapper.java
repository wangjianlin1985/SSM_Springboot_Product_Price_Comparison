package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.SellerPrice;

public interface SellerPriceMapper {
	/*添加商家价格信息*/
	public void addSellerPrice(SellerPrice sellerPrice) throws Exception;

	/*按照查询条件分页查询商家价格记录*/
	public ArrayList<SellerPrice> querySellerPrice(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有商家价格记录*/
	public ArrayList<SellerPrice> querySellerPriceList(@Param("where") String where) throws Exception;

	/*按照查询条件的商家价格记录数*/
	public int querySellerPriceCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条商家价格记录*/
	public SellerPrice getSellerPrice(int priceId) throws Exception;

	/*更新商家价格记录*/
	public void updateSellerPrice(SellerPrice sellerPrice) throws Exception;

	/*删除商家价格记录*/
	public void deleteSellerPrice(int priceId) throws Exception;

}
