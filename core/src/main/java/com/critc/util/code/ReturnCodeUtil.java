package com.critc.util.code;

import java.util.HashMap;

/**
 * @autho 孔垂云
 * 设置公共返回码
 * 100*成功系列
 * 200*失败系列
 * 300*系统部分
 * @date 2017/7/17.
 */
public class ReturnCodeUtil {
    private static HashMap<String, ReturnMsg> hashMap = new HashMap<>();

    /**
     * 初始化该对象
     */
    static {
        /**
         * 成功类
         */
        //新增、修改返回该值
        hashMap.put("10001", new ReturnMsg("10001", "保存成功！"));
        //删除成功返回该值
        hashMap.put("10002", new ReturnMsg("10002", "删除成功！"));
        //操作成功返回该值，比如重置密码、锁定解锁用户
        hashMap.put("10003", new ReturnMsg("10003", "操作成功！"));
        //审核成功返回该值，比如审核是否有问题等
        hashMap.put("10004", new ReturnMsg("10004", "审核成功！"));

        //重置密码成功
        hashMap.put("10101", new ReturnMsg("10101", "用户重置密码成功，重置后密码变为123456！"));



        /**
         * 失败类
         */
        //操作失败返回该值，比如新增、修改、删除失败
        hashMap.put("20001", new ReturnMsg("20001", "操作失败！"));
        hashMap.put("20002", new ReturnMsg("20002", "代码已存在！"));

        /**
         * 分大类错误码,系统管理类
         */
        hashMap.put("20101", new ReturnMsg("20101", "不能和上级节点一样！"));
        hashMap.put("20102", new ReturnMsg("20102", "上级节点不存在！"));
        hashMap.put("20103", new ReturnMsg("20103", "还有下级节点，不能删除！"));
        hashMap.put("20104", new ReturnMsg("20104", "用户账号已存在！"));
        hashMap.put("20105", new ReturnMsg("20105", "原密码输入错误！"));


        /**
         * 系统相关类
         */
        //操作失败返回该值，比如新增、修改、删除失败
        hashMap.put("30001", new ReturnMsg("30001", "权限不足！"));
    }

    /**
     * 获取返回的中文说明
     *
     * @param resultCode
     * @return
     */
    public static String getMsg(String resultCode) {
        if (hashMap.containsKey(resultCode))
            return hashMap.get(resultCode).getCnMsg();
        else return "";
    }

}
