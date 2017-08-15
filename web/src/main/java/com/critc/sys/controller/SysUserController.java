package com.critc.sys.controller;

import com.critc.core.pub.PubConfig;
import com.critc.sys.service.SysRoleService;
import com.critc.sys.service.SysUserLoginService;
import com.critc.sys.service.SysUserService;
import com.critc.sys.vo.SysUserSearchVO;
import com.critc.sys.vo.SysUserloginSearchVO;
import com.critc.util.code.GlobalCode;
import com.critc.util.json.JsonUtil;
import com.critc.util.session.SessionUtil;
import com.critc.util.string.BackUrlUtil;
import com.critc.util.string.StringUtil;
import com.critc.util.web.WebUtil;
import com.critc.core.controller.BaseController;
import com.critc.sys.model.SysUser;
import com.critc.sys.model.SysUserLogin;
import com.critc.util.page.PageNavigate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 系统用户管理Controller
 *
 * @author 孔垂云
 * @date 2017-06-13
 */
@RequestMapping("/sys/user")
@Controller
public class SysUserController extends BaseController {
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private SysUserLoginService sysUserLoginService;
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private PubConfig pubConfig;

    /**
     * 进入用户管理界面
     *
     * @return
     */
    @RequestMapping("/index")
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response, SysUserSearchVO sysUserSearchVO) {
        ModelAndView mv = new ModelAndView();
        sysUserSearchVO.setCurrentUser(SessionUtil.getUserSession(request).getUsername());//获取当前用户
        int recordCount = sysUserService.count(sysUserSearchVO);// 获取查询总数
        String url = createUrl(sysUserSearchVO);
        PageNavigate pageNavigate = new PageNavigate(url, sysUserSearchVO.getPageIndex(), recordCount);//定义分页对象
        List<SysUser> list = sysUserService.list(sysUserSearchVO);
        mv.addObject("pageNavigate", pageNavigate);// 设置分页的变量
        mv.addObject("list", list);// 把获取的记录放到mv里面
        mv.addObject("listRole", sysRoleService.listCombo());// 角色列表
        mv.setViewName("/sys/user/index");// 跳转至指定页面
        BackUrlUtil.createBackUrl(mv, request, url);// 设置返回url
        return mv;
    }

    // 设置分页url，一般有查询条件的才会用到
    private String createUrl(SysUserSearchVO sysUserSearchVO) {
        String url = pubConfig.getDynamicServer() + "/sys/user/index.htm?";
        if (StringUtil.isNotNullOrEmpty(sysUserSearchVO.getUsername()))
            url += "&username=" + sysUserSearchVO.getUsername();
        if (StringUtil.isNotNullOrEmpty(sysUserSearchVO.getRealname()))//如果为模糊查询，要把该字段encode
            url += "&realname=" + sysUserSearchVO.getRealname();
        if (sysUserSearchVO.getStatus() != null)
            url += "&status=" + sysUserSearchVO.getStatus();
        if (sysUserSearchVO.getRoleId() != null)
            url += "&roleId=" + sysUserSearchVO.getRoleId();
        return url;
    }

    /**
     * 进入添加用户界面
     *
     * @param request
     * @param response
     * @param
     * @retursysUsern
     */
    @RequestMapping("/toAdd")
    public ModelAndView toAdd(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("listRole", sysRoleService.listCombo());// 角色列表
        SysUser sysUser = new SysUser();
        mv.addObject("sysUser", sysUser);
        mv.setViewName("/sys/user/add");
        BackUrlUtil.setBackUrl(mv, request);// 设置返回的url
        return mv;
    }

    /**
     * 进入修改用户界面
     *
     * @param request
     * @param response
     * @param
     * @return
     */
    @RequestMapping("/toUpdate")
    public ModelAndView toUpdate(HttpServletRequest request, HttpServletResponse response, int id) {
        ModelAndView mv = new ModelAndView();
        SysUser sysUser = sysUserService.get(id);
        mv.addObject("sysUser", sysUser);
        mv.addObject("listRole", sysRoleService.listCombo());// 角色列表
        mv.setViewName("/sys/user/update");
        BackUrlUtil.setBackUrl(mv, request);// 设置返回的url
        return mv;
    }

    /**
     * 新增用户
     *
     * @param request
     * @param response
     * @param sysUser
     * @return
     */
    @RequestMapping("/add")
    public String add(HttpServletRequest request, HttpServletResponse response, SysUser sysUser) {
        sysUser.setStatus(1);
        sysUser.setCreatedBy(SessionUtil.getRealname(request));
        sysUser.setAvatar("/assets/common/images/avatar_s.jpg");//默认头像
        int flag = sysUserService.add(sysUser);
        if (flag == 0)
            return "forward:/error.htm?resultCode=" + GlobalCode.OPERA_FAILURE;//用户信息新增失败;
        else if (flag == 2)
            return "forward:/error.htm?resultCode=20104";//用户账号已存在;
        else
            return "forward:/success.htm?resultCode=" + GlobalCode.SAVE_SUCCESS;//用户信息新增成功;
    }

    /**
     * 修改用户
     *
     * @param request
     * @param response
     * @param sysUser
     * @return
     */
    @RequestMapping("/update")
    public String update(HttpServletRequest request, HttpServletResponse response, SysUser sysUser) {
        int flag = sysUserService.update(sysUser);
        if (flag == 0)
            return "forward:/error.htm?resultCode=" + GlobalCode.OPERA_FAILURE;//用户信息修改失败;
        else
            return "forward:/success.htm?resultCode=" + GlobalCode.SAVE_SUCCESS;//用户信息修改成功;
    }

    /**
     * 删除用户
     *
     * @param request
     * @param response
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    public String delete(HttpServletRequest request, HttpServletResponse response, int id) {
        int flag = sysUserService.delete(id);
        if (flag == 0)
            return "forward:/error.htm?resultCode=" + GlobalCode.OPERA_FAILURE;//用户删除失败;
        else
            return "forward:/success.htm?resultCode=" + GlobalCode.DELETE_SUCCESS;//用户删除成功;
    }

    /**
     * 重置密码
     *
     * @param request
     * @param response
     */
    @RequestMapping("/saveResetPass")
    public String saveResetPass(HttpServletRequest request, HttpServletResponse response, int id) {
        int flag = sysUserService.saveResetPass(id);
        if (flag == 0)
            return "forward:/error.htm?resultCode=" + GlobalCode.OPERA_FAILURE;//用户重置密码失败;
        else
            return "forward:/success.htm?resultCode=10101";//用户重置密码成功，重置后密码变为123456;
    }

    /**
     * 用户加锁，状态由1变为0
     *
     * @param request
     * @param response
     * @param id
     */
    @RequestMapping("/saveLock")
    public String saveLock(HttpServletRequest request, HttpServletResponse response, int id) {
        int flag = sysUserService.updateStatus(id, 2);
        if (flag == 0)
            return "forward:/error.htm?resultCode=" + GlobalCode.OPERA_FAILURE;//用户锁定失败;
        else
            return "forward:/success.htm?resultCode=" + GlobalCode.OPERA_SUCCESS;//用户锁定成功");
    }

    /**
     * 用户解锁，状态由2变为1
     *
     * @param request
     * @param response
     * @param id
     */
    @RequestMapping("/saveUnlock")
    public String saveUnlock(HttpServletRequest request, HttpServletResponse response, int id) {
        int flag = sysUserService.updateStatus(id, 1);
        if (flag == 0)
            return "forward:/error.htm?resultCode=" + GlobalCode.OPERA_FAILURE;//用户解锁失败;
        else
            return "forward:/success.htm?resultCode=" + GlobalCode.OPERA_SUCCESS;//用户解锁成功;
    }


    /**
     * 验证用户代码是否存在
     *
     * @param request
     * @param response
     */
    @RequestMapping("/checkUserExist")
    public void checkUserExist(HttpServletRequest request, HttpServletResponse response, String username) {
        SysUser sysUser = sysUserService.getByUsername(username);
        if (sysUser == null)
            WebUtil.out(response, "true");
        else
            WebUtil.out(response, "false");
    }

    /**
     * 用户登录信息
     *
     * @param request
     * @param response
     */
    @RequestMapping("/searchUserLogin")
    public void searchUserLogin(HttpServletRequest request, HttpServletResponse response, SysUserloginSearchVO sysUserloginSearchVO) {
        int recordCount = sysUserLoginService.count(sysUserloginSearchVO);// 获取查询总数
        List<SysUserLogin> list = sysUserLoginService.list(sysUserloginSearchVO);
        WebUtil.out(response, JsonUtil.createDataTablePageJson(sysUserloginSearchVO.getPageIndex(), recordCount, JsonUtil.toStr(list)));
    }

}
