package com.critc.sys.model;

import com.critc.util.model.BaseModel;

/**
 * 系统用户
 *
 * @author 孔垂云
 * @date 2017-06-13
 */
public class SysUser extends BaseModel {

    private Integer id;//用户id
    private Integer roleId;//所属角色
    private String roleName;//角色描述
    private String username;//登录账号
    private String password;//登录密码
    private String randomcode;//随机数
    private Integer status;//账号状态
    private String realname;//姓名
    private String mobile;//手机号

    private String email;//邮件
    private String avatar;//头像
    private Integer isDelete;//是否能够删除

    @Override
    public String toString() {
        return "SysUser{" +
                "id=" + id +
                ", roleId=" + roleId +
                ", roleName='" + roleName + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", randomcode='" + randomcode + '\'' +
                ", status=" + status +
                ", realname='" + realname + '\'' +
                ", mobile='" + mobile + '\'' +
                ", email='" + email + '\'' +
                ", avatar='" + avatar + '\'' +
                ", isDelete=" + isDelete +
                '}';
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRandomcode() {
        return randomcode;
    }

    public void setRandomcode(String randomcode) {
        this.randomcode = randomcode;
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

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

}
