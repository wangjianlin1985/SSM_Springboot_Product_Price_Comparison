package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Seller {
    /*商家id*/
    private Integer sellerId;
    public Integer getSellerId(){
        return sellerId;
    }
    public void setSellerId(Integer sellerId){
        this.sellerId = sellerId;
    }

    /*商家名称*/
    @NotEmpty(message="商家名称不能为空")
    private String sellerName;
    public String getSellerName() {
        return sellerName;
    }
    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    /*商家logo*/
    private String sellerLogo;
    public String getSellerLogo() {
        return sellerLogo;
    }
    public void setSellerLogo(String sellerLogo) {
        this.sellerLogo = sellerLogo;
    }

    /*商家介绍*/
    @NotEmpty(message="商家介绍不能为空")
    private String sellerDesc;
    public String getSellerDesc() {
        return sellerDesc;
    }
    public void setSellerDesc(String sellerDesc) {
        this.sellerDesc = sellerDesc;
    }

    /*商家电话*/
    @NotEmpty(message="商家电话不能为空")
    private String sellerTelephone;
    public String getSellerTelephone() {
        return sellerTelephone;
    }
    public void setSellerTelephone(String sellerTelephone) {
        this.sellerTelephone = sellerTelephone;
    }

    /*商家地址*/
    @NotEmpty(message="商家地址不能为空")
    private String sellerAddress;
    public String getSellerAddress() {
        return sellerAddress;
    }
    public void setSellerAddress(String sellerAddress) {
        this.sellerAddress = sellerAddress;
    }

    /*商家网站*/
    @NotEmpty(message="商家网站不能为空")
    private String sellerSite;
    public String getSellerSite() {
        return sellerSite;
    }
    public void setSellerSite(String sellerSite) {
        this.sellerSite = sellerSite;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSeller=new JSONObject(); 
		jsonSeller.accumulate("sellerId", this.getSellerId());
		jsonSeller.accumulate("sellerName", this.getSellerName());
		jsonSeller.accumulate("sellerLogo", this.getSellerLogo());
		jsonSeller.accumulate("sellerDesc", this.getSellerDesc());
		jsonSeller.accumulate("sellerTelephone", this.getSellerTelephone());
		jsonSeller.accumulate("sellerAddress", this.getSellerAddress());
		jsonSeller.accumulate("sellerSite", this.getSellerSite());
		return jsonSeller;
    }}