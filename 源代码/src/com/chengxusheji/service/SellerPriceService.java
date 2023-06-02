package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Product;
import com.chengxusheji.po.Seller;
import com.chengxusheji.po.SellerPrice;

import com.chengxusheji.mapper.SellerPriceMapper;
@Service
public class SellerPriceService {

	@Resource SellerPriceMapper sellerPriceMapper;
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

    /*添加商家价格记录*/
    public void addSellerPrice(SellerPrice sellerPrice) throws Exception {
    	sellerPriceMapper.addSellerPrice(sellerPrice);
    }

    /*按照查询条件分页查询商家价格记录*/
    public ArrayList<SellerPrice> querySellerPrice(Product productObj,Seller sellerObj,String priceDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_sellerPrice.productObj=" + productObj.getProductId();
    	if(null != sellerObj && sellerObj.getSellerId()!= null && sellerObj.getSellerId()!= 0)  where += " and t_sellerPrice.sellerObj=" + sellerObj.getSellerId();
    	if(!priceDate.equals("")) where = where + " and t_sellerPrice.priceDate like '%" + priceDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return sellerPriceMapper.querySellerPrice(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<SellerPrice> querySellerPrice(Product productObj,Seller sellerObj,String priceDate) throws Exception  { 
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_sellerPrice.productObj=" + productObj.getProductId();
    	if(null != sellerObj && sellerObj.getSellerId()!= null && sellerObj.getSellerId()!= 0)  where += " and t_sellerPrice.sellerObj=" + sellerObj.getSellerId();
    	if(!priceDate.equals("")) where = where + " and t_sellerPrice.priceDate like '%" + priceDate + "%'";
    	return sellerPriceMapper.querySellerPriceList(where);
    }

    /*查询所有商家价格记录*/
    public ArrayList<SellerPrice> queryAllSellerPrice()  throws Exception {
        return sellerPriceMapper.querySellerPriceList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Product productObj,Seller sellerObj,String priceDate) throws Exception {
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_sellerPrice.productObj=" + productObj.getProductId();
    	if(null != sellerObj && sellerObj.getSellerId()!= null && sellerObj.getSellerId()!= 0)  where += " and t_sellerPrice.sellerObj=" + sellerObj.getSellerId();
    	if(!priceDate.equals("")) where = where + " and t_sellerPrice.priceDate like '%" + priceDate + "%'";
        recordNumber = sellerPriceMapper.querySellerPriceCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取商家价格记录*/
    public SellerPrice getSellerPrice(int priceId) throws Exception  {
        SellerPrice sellerPrice = sellerPriceMapper.getSellerPrice(priceId);
        return sellerPrice;
    }

    /*更新商家价格记录*/
    public void updateSellerPrice(SellerPrice sellerPrice) throws Exception {
        sellerPriceMapper.updateSellerPrice(sellerPrice);
    }

    /*删除一条商家价格记录*/
    public void deleteSellerPrice (int priceId) throws Exception {
        sellerPriceMapper.deleteSellerPrice(priceId);
    }

    /*删除多条商家价格信息*/
    public int deleteSellerPrices (String priceIds) throws Exception {
    	String _priceIds[] = priceIds.split(",");
    	for(String _priceId: _priceIds) {
    		sellerPriceMapper.deleteSellerPrice(Integer.parseInt(_priceId));
    	}
    	return _priceIds.length;
    }
}
