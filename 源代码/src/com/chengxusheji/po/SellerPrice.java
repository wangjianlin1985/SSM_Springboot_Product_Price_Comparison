package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class SellerPrice {
    /*价格id*/
    private Integer priceId;
    public Integer getPriceId(){
        return priceId;
    }
    public void setPriceId(Integer priceId){
        this.priceId = priceId;
    }

    /*商品信息*/
    private Product productObj;
    public Product getProductObj() {
        return productObj;
    }
    public void setProductObj(Product productObj) {
        this.productObj = productObj;
    }

    /*商品报价*/
    @NotNull(message="必须输入商品报价")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*报价商家*/
    private Seller sellerObj;
    public Seller getSellerObj() {
        return sellerObj;
    }
    public void setSellerObj(Seller sellerObj) {
        this.sellerObj = sellerObj;
    }

    /*报价日期*/
    @NotEmpty(message="报价日期不能为空")
    private String priceDate;
    public String getPriceDate() {
        return priceDate;
    }
    public void setPriceDate(String priceDate) {
        this.priceDate = priceDate;
    }

    /*购买链接*/
    @NotEmpty(message="购买链接不能为空")
    private String buyAddress;
    public String getBuyAddress() {
        return buyAddress;
    }
    public void setBuyAddress(String buyAddress) {
        this.buyAddress = buyAddress;
    }

    /*备注信息*/
    private String priceMemo;
    public String getPriceMemo() {
        return priceMemo;
    }
    public void setPriceMemo(String priceMemo) {
        this.priceMemo = priceMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSellerPrice=new JSONObject(); 
		jsonSellerPrice.accumulate("priceId", this.getPriceId());
		jsonSellerPrice.accumulate("productObj", this.getProductObj().getProductName());
		jsonSellerPrice.accumulate("productObjPri", this.getProductObj().getProductId());
		jsonSellerPrice.accumulate("price", this.getPrice());
		jsonSellerPrice.accumulate("sellerObj", this.getSellerObj().getSellerName());
		jsonSellerPrice.accumulate("sellerObjPri", this.getSellerObj().getSellerId());
		jsonSellerPrice.accumulate("priceDate", this.getPriceDate().length()>19?this.getPriceDate().substring(0,19):this.getPriceDate());
		jsonSellerPrice.accumulate("buyAddress", this.getBuyAddress());
		jsonSellerPrice.accumulate("priceMemo", this.getPriceMemo());
		return jsonSellerPrice;
    }}