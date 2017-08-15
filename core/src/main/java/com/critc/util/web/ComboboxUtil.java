package com.critc.util.web;

import com.critc.core.spring.SpringContextHolder;
import com.critc.sys.service.SysUserService;
import com.critc.util.model.ComboboxVO;

import java.util.ArrayList;
import java.util.List;

/**
 * 生成下拉框的列表
 *
 * @autho 孔垂云
 * @date 2017/7/17.
 */
public class ComboboxUtil {

    /**
     * 生成下拉框列表
     * @param comboType
     * @return
     */
    public static List<ComboboxVO> createComboboxList(String comboType) {
        List<ComboboxVO> list = new ArrayList<>();//定义下拉框
        switch (comboType) {
            case "sysUser"://系统用户，日志查询用到
                SysUserService sysUserService = SpringContextHolder.getBean("sysUserService");
                list.addAll(sysUserService.listAllUser());
                break;
        }
        return list;
    }

}
