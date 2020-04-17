
package com.example.cookbook.utils;
import java.util.Map;


public class ResponseDTO {
    private boolean success;
    private Map<String, Object> data;
    private String errors;
    private String msg;

    public ResponseDTO() {
    }
    
    public ResponseDTO(boolean success, Map<String, Object> data, String errors, String msg) {
        this.success = success;
        this.data = data;
        this.errors = errors;
        this.msg = msg;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    public String getErrors() {
        return errors;
    }

    public void setErrors(String errors) {
        this.errors = errors;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    

}