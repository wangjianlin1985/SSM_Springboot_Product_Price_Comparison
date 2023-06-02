package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Seller;

import com.chengxusheji.mapper.SellerMapper;
@Service
public class SellerService {

	@Resource SellerMapper sellerMapper;
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

    /*添加商家记录*/
    public void addSeller(Seller seller) throws Exception {
    	sellerMapper.addSeller(seller);
    }

    /*按照查询条件分页查询商家记录*/
    public ArrayList<Seller> querySeller(String sellerName,String sellerTelephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!sellerName.equals("")) where = where + " and t_seller.sellerName like '%" + sellerName + "%'";
    	if(!sellerTelephone.equals("")) where = where + " and t_seller.sellerTelephone like '%" + sellerTelephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return sellerMapper.querySeller(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Seller> querySeller(String sellerName,String sellerTelephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!sellerName.equals("")) where = where + " and t_seller.sellerName like '%" + sellerName + "%'";
    	if(!sellerTelephone.equals("")) where = where + " and t_seller.sellerTelephone like '%" + sellerTelephone + "%'";
    	return sellerMapper.querySellerList(where);
    }

    /*查询所有商家记录*/
    public ArrayList<Seller> queryAllSeller()  throws Exception {
        return sellerMapper.querySellerList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String sellerName,String sellerTelephone) throws Exception {
     	String where = "where 1=1";
    	if(!sellerName.equals("")) where = where + " and t_seller.sellerName like '%" + sellerName + "%'";
    	if(!sellerTelephone.equals("")) where = where + " and t_seller.sellerTelephone like '%" + sellerTelephone + "%'";
        recordNumber = sellerMapper.querySellerCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取商家记录*/
    public Seller getSeller(int sellerId) throws Exception  {
        Seller seller = sellerMapper.getSeller(sellerId);
        return seller;
    }

    /*更新商家记录*/
    public void updateSeller(Seller seller) throws Exception {
        sellerMapper.updateSeller(seller);
    }

    /*删除一条商家记录*/
    public void deleteSeller (int sellerId) throws Exception {
        sellerMapper.deleteSeller(sellerId);
    }

    /*删除多条商家信息*/
    public int deleteSellers (String sellerIds) throws Exception {
    	String _sellerIds[] = sellerIds.split(",");
    	for(String _sellerId: _sellerIds) {
    		sellerMapper.deleteSeller(Integer.parseInt(_sellerId));
    	}
    	return _sellerIds.length;
    }
}
