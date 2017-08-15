package com.critc.util.web;

import com.critc.core.spring.SpringContextHolder;
import com.critc.sys.service.SysRoleService;
import com.critc.util.model.ComboboxVO;
import com.critc.util.session.SessionUtil;
import com.critc.util.session.UserSession;
import com.critc.util.string.StringUtil;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * 页面标签，用于直接处理页面数据，展示使用
 *
 * @author 孔垂云
 * @date 2017-05-23
 */
public class WebTag {

    /**
     * 获取用户状态，系统管理-用户管理用到
     *
     * @param user_status
     * @return
     */
    public static String getUserStatus(Integer user_status) {
        if (user_status == 1)
            return "<span class=\"label  label-info\"> 正常 </span>";
        else if (user_status == 2)
            return "<span class=\"label label-danger\"> 已锁定 </span>";
        else
            return "";
    }


    /**
     * 生成菜单
     *
     * @param request 请求
     * @return 菜单
     */
    public static String createMenu(HttpServletRequest request) {
        UserSession userSession = SessionUtil.getUserSession(request);
        SysRoleService sysRoleService = SpringContextHolder.getBean("sysRoleService");
        return sysRoleService.createMenuStr(userSession.getRoleId());
    }

    /**
     * 判断按钮权限
     *
     * @param buttonCode
     * @return
     */
    public static boolean isPrivilege(String buttonCode) {
        SysRoleService sysRoleService = SpringContextHolder.getBean("sysRoleService");
        return sysRoleService.checkBtnPrivilege(buttonCode);
    }

    /**
     * 标签生成下拉框
     *
     * @param comboType 下拉框类型
     * @param selValue   选中值
     * @param firstType 下拉框第一项是的类型，0不要，1全部，2请选择
     * @param id        下拉框的id
     * @param name      下拉框的name
     * @param cssClass  下拉框的样式
     * @return
     */
    public static String createCombo(String comboType, String selValue, Integer firstType, String id, String name, String cssClass) {
        List<ComboboxVO> list = new ArrayList<>();//定义下拉框
        if (firstType == 1)
            list.add(new ComboboxVO("", "全部"));
        else if (firstType == 2)
            list.add(new ComboboxVO("", "请选择"));
        list.addAll(ComboboxUtil.createComboboxList(comboType));
        StringBuilder sb = new StringBuilder("<select id=\"" + id + "\" name=\"" + name + "\" class=\"" + cssClass + "\">");
        for (ComboboxVO comboboxVO : list) {
            String selected = "";//判断是否选中
            if (StringUtil.isNotNullOrEmpty(selValue) && comboboxVO.getValue().equals(selValue)) {
                selected = " selected=\"selected\"";
            }
            sb.append("<option value=\"" + comboboxVO.getValue() + "\" " + selected + ">" + comboboxVO.getContent() + "</option>");
        }
        sb.append("</select>");
        return sb.toString();
    }

    /**
     * 生成固定值的下拉框
     *
     * @param value 前台传过来的下拉框的值
     * @param selValue   选中值
     * @param firstType 下拉框第一项是的类型，0不要，1全部，2请选择
     * @param id        下拉框的id
     * @param name      下拉框的name
     * @param cssClass  下拉框的样式
     * @return
     */
    public static String createCombo2(String value, String selValue, Integer firstType, String id, String name, String cssClass) {
        //String value="{1:管理员,2:普通用户}";
        List<ComboboxVO> list = new ArrayList<>();//定义下拉框
        if (firstType == 1)
            list.add(new ComboboxVO("", "全部"));
        else if (firstType == 2)
            list.add(new ComboboxVO("", "请选择"));

        //把取得的值拼装成combobox
        String[] valueArr = value.substring(1, value.length() - 1).split("\\,");
        for (String str : valueArr) {
            if (StringUtil.isNotNullOrEmpty(str) && str.indexOf(":") > -1)//不为空，且包含：
            {
                String[] val = str.split(":");
                ComboboxVO comboboxVO = new ComboboxVO(val[0], val[1]);
                list.add(comboboxVO);
            }
        }
        //生成下拉框的html代码
        StringBuilder sb = new StringBuilder("<select id=\"" + id + "\" name=\"" + name + "\" class=\"" + cssClass + "\">");
        for (ComboboxVO comboboxVO : list) {
            String selected = "";//判断是否选中
            if (StringUtil.isNotNullOrEmpty(selValue) && comboboxVO.getValue().equals(selValue)) {
                selected = " selected=\"selected\"";
            }
            sb.append("<option value=\"" + comboboxVO.getValue() + "\" " + selected + ">" + comboboxVO.getContent() + "</option>");
        }
        sb.append("</select>");
        return sb.toString();
    }

}
