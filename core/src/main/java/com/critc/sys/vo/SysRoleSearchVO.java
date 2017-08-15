package com.critc.sys.vo;

import com.critc.util.page.PageSearchVO;

/**
 * 用户查询VO
 *
 * @author 孔垂云
 * @date 2017-06-13
 */
public class SysRoleSearchVO extends PageSearchVO {
    private Integer isBuildin = 0;//是否内置角色，默认为0

    public Integer getIsBuildin() {
        return isBuildin;
    }

    public void setIsBuildin(Integer isBuildin) {
        this.isBuildin = isBuildin;
    }

    @Override
    public String toString() {
        return "SysRoleSearchVO{" +
                "isBuildin=" + isBuildin +
                '}';
    }
}
