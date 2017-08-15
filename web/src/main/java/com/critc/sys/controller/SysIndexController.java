package com.critc.sys.controller;

import com.critc.core.controller.BaseController;
import com.critc.sys.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @autho 孔垂云
 * @date 2017/7/6.
 */
@RequestMapping("/")
@Controller
public class SysIndexController extends BaseController {
    @Autowired
    private SysUserService sysUserService;
    /**
     * 进入用户管理界面
     *
     * @return
     */
    /*@RequestMapping("/index")
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response, SysUserSearchVO sysUserSearchVO) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/plat/index");// 跳转至Index页面
        return mv;
    }*/


}
