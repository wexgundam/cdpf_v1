package com.critc.sys.vo;

import com.critc.util.page.PageSearchVO;

/**
 * 用户查询VO
 *
 * @author 孔垂云
 * @date 2017-06-13
 */
public class SysUserSearchVO extends PageSearchVO {
    private String username;//username
    private Integer status;//状态
    private Integer roleId;//角色
    private String realname;//姓名
    private String currentUser;//当前用户，如果为system，可以看全部的，如果不为system，不能看system用户


    //姓名模糊查询
    public String getRealnameStr() {
        return "%" + realname + "%";
    }

    public String getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(String currentUser) {
        this.currentUser = currentUser;
    }

    @Override
    public String toString() {
        return "SysUserSearchVO{" +
                "username='" + username + '\'' +
                ", status=" + status +
                ", roleId=" + roleId +
                ", realname='" + realname + '\'' +
                '}';
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }


    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }


    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

}
