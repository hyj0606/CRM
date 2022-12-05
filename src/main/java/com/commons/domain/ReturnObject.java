package com.commons.domain;

/**
 * @ClassName ReturnObject
 * @Description TODO
 * @Author hyj98
 * @Date 2022-11-24 20:55
 * @Version 1.0
 */

public class ReturnObject {
    private String code;//处理成功或失败的标记: 1---成功, 0---失败
    private String message;//提示信息
    private Object retData;//其它数据

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getRetData() {
        return retData;
    }

    public void setRetData(Object retData) {
        this.retData = retData;
    }
}
