package com.critc.sys.controller;

import com.critc.core.controller.BaseController;
import com.critc.core.pub.PubConfig;
import com.critc.sys.model.SysUser;
import com.critc.sys.service.SysUserService;
import com.critc.sys.vo.AvatarScale;
import com.critc.util.code.GlobalCode;
import com.critc.util.date.DateUtil;
import com.critc.util.image.ImageCutUtil;
import com.critc.util.json.JsonUtil;
import com.critc.util.session.SessionUtil;
import com.critc.util.session.UserSession;
import com.critc.util.string.BackUrlUtil;
import com.critc.util.web.WebUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.InputStream;
import java.util.Date;
import java.util.Random;

/**
 * @autho 孔垂云
 * @date 2017/7/18.
 */
@RequestMapping("/sys/info")
@Controller
public class SysInfoController extends BaseController {
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private PubConfig pubConfig;

    /**
     * 个人信息
     *
     * @return
     */
    @RequestMapping("/view")
    public ModelAndView view(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/sys/user/view");
        SysUser sysUser = sysUserService.get(SessionUtil.getUserSession(request).getUserId());
        mv.addObject("sysUser", sysUser);
        BackUrlUtil.createBackUrl(mv, request, pubConfig.getDynamicServer() + "/sys/info/view.htm?");// 设置返回url
        return mv;
    }

    /**
     * 保存头像
     *
     * @param avatar_file
     * @param avatar_data
     * @param request
     * @param response
     */
    @RequestMapping("/uploadAvatar")
    public void uploadAvatar(MultipartFile avatar_file, String avatar_data, HttpServletRequest request, HttpServletResponse response) {
        String dir = File.separator + "avatar" + File.separator + DateUtil.dateToString(new Date(), "yyyyMMdd");//实际上传文件路径
        String saveDir = "/avatar/" + DateUtil.dateToString(new Date(), "yyyyMMdd");//保存上传文件路径
        String oldFileName = avatar_file.getOriginalFilename();
        String fileName = new Date().getTime() + "" + new Random().nextInt(10000) + oldFileName.substring(oldFileName.lastIndexOf('.'));//定义上传文件名
        AvatarScale avatarScale = JsonUtil.toObject(avatar_data, AvatarScale.class);
        // 用户经过剪辑后的图片的大小
        int x = (int) avatarScale.getX();
        int y = (int) avatarScale.getY();
        int w = (int) avatarScale.getWidth();
        int h = (int) avatarScale.getHeight();
        //开始上传
        File targetFile = new File(pubConfig.getImageUploadPath() + dir, fileName);
        try {
            if (!targetFile.exists()) {
                targetFile.mkdirs();
                InputStream is = avatar_file.getInputStream();
                ImageCutUtil.cut(is, targetFile, x, y, w, h);
                is.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.out(response, "{\"result\":" + false + ",\"message\":" + "\"传输失败\"}");
        }
        String url = pubConfig.getImageServer() + saveDir + "/" + fileName;
        //修改库中对应的头像字段
        sysUserService.updateAvatar(SessionUtil.getUserSession(request).getUserId(), saveDir + "/" + fileName);
        //修改session中的头像值
        UserSession userSession = SessionUtil.getUserSession(request);
        userSession.setAvatar(saveDir + "/" + fileName);
        request.getSession().setAttribute("userSession", userSession);
        WebUtil.out(response, "{\"result\":" + true + ",\"message\":\"" + "上传成功" + "\",\"url\":\"" + url + "\"}");
    }


    /**
     * 修改个人基本信息
     *
     * @param request
     * @param response
     * @param sysUser
     * @return
     */
    @RequestMapping("/updateInfo")
    public String updateInfo(HttpServletRequest request, HttpServletResponse response, SysUser sysUser) {
        sysUser.setId(SessionUtil.getUserSession(request).getUserId());
        int flag = sysUserService.updateInfo(sysUser);
        if (flag == 0)
            return "forward:/error.htm?resultCode=" + GlobalCode.OPERA_FAILURE;//用户信息修改失败;
        else
            return "forward:/success.htm?resultCode=" + GlobalCode.SAVE_SUCCESS;//用户信息修改成功;
    }

    /**
     * 进入修改密码界面
     *
     * @param request
     * @param response
     * @param sysUser
     */
    @RequestMapping("/updatePass")
    public ModelAndView updatePass(HttpServletRequest request, HttpServletResponse response, SysUser sysUser) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/sys/user/updatePass");
        mv.addObject("backUrl", pubConfig.getDynamicServer() + "/index.htm");
        return mv;
    }

    /**
     * 修改密码
     */
    @RequestMapping("/saveUpdatePass")
    public String saveUpdatePass(HttpServletRequest request, HttpServletResponse response, SysUser sysUser) {
        String oldPass = WebUtil.getSafeStr(request.getParameter("oldPass"));
        String newPass = WebUtil.getSafeStr(request.getParameter("newPass"));
        UserSession userSession = SessionUtil.getUserSession(request);
        int flag = sysUserService.updatePass(userSession.getUserId(), oldPass, newPass);
        if (flag == 0)
            return "forward:/error.htm?resultCode=" + GlobalCode.OPERA_FAILURE;//密码修改失败;
        else if (flag == 2)
            return "forward:/error.htm?resultCode=20105";//原密码输入错误;
        else
            return "forward:/success.htm?resultCode=" + GlobalCode.OPERA_SUCCESS;//密码修改成功;
    }
}
