package com.fh.controller.money.xnbmanual;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.money.userxnb.UserxnbService;
import com.fh.service.money.xnbmanual.XnbManualService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

/** 
 * 类名称：XnbManualController
 * 创建人：FH 
 * 创建时间：2016-10-28
 */
@Controller
@RequestMapping(value="/xnbmanual")
public class XnbManualController extends BaseController {
	
	String menuUrl = "xnbmanual/list.do"; //菜单地址(权限用)
	@Resource(name="xnbmanualService")
	private XnbManualService xnbmanualService;
	@Resource(name="userxnbService")
	private UserxnbService userxnbService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增XnbManual");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData pageData = userxnbService.findByLoginNameXnbType(pd);
		pd.put("XNBMANUAL_ID", this.get32UUID());	//主键
		pd.put("CREATEDATETIME", Tools.date2Str(new Date()));	//创建时间
		pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//更新时间
		pd.put("CREATEUSER", "");	//创建人
		pd.put("UPDATEUSER", "");	//更新人
		pd.put("USERNICKNAME", pageData.get("USERNICKNAME"));	//会员昵称
		pd.put("USERREALNAME", pageData.get("USERREALNAME"));	//会员真实姓名
		pd.put("AUDITDATETIME", "");	//审核时间
		pd.put("AUDITPEOPLE", "");	//审核人
		xnbmanualService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除XnbManual");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			xnbmanualService.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 审核
	 */
	@RequestMapping(value="/audit")
	public void audit(PrintWriter out){
		logBefore(logger, "审核XnbManual");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			String USERNAME = session.getAttribute(Const.SESSION_USERNAME).toString();	//获取当前登录者loginname
			pd.put("AUDITPEOPLE", USERNAME);
			pd.put("STATUS", "冻结");	//状态
			xnbmanualService.audit(pd);
			PageData pageData = xnbmanualService.findById(pd);
			pageData.put("UPDATEUSER", USERNAME);
			userxnbService.editFreezeNum(pageData);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	
	/**
	 * 发放冻结
	 */
	@RequestMapping(value="/unFreeze")
	public void unFreeze(PrintWriter out){
		logBefore(logger, "发放冻结XnbManual");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			String USERNAME = session.getAttribute(Const.SESSION_USERNAME).toString();	//获取当前登录者loginname
			pd.put("AUDITPEOPLE", USERNAME);
			pd.put("STATUS", "已审核");	//状态
			xnbmanualService.audit(pd);
			PageData pageData = xnbmanualService.findById(pd);
			pageData.put("UPDATEUSER", USERNAME);
			userxnbService.edit(pageData);
			
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表XnbManual");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
//			String LOGINNAME = pd.getString("LOGINNAME");
//			String CREATEDATETIME = pd.getString("CREATEDATETIME");
//			if(null != LOGINNAME && !"".equals(LOGINNAME)){
//				pd.put("LOGINNAME", LOGINNAME.trim());
//			}
//			if(null != CREATEDATETIME && !"".equals(CREATEDATETIME)){
//				pd.put("CREATEDATETIME", CREATEDATETIME.trim());
//			}
			page.setPd(pd);
			List<PageData>	varList = xnbmanualService.list(page);	//列出XnbManual列表
			mv.setViewName("money/xnbmanual/xnbmanual_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增XnbManual页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("money/xnbmanual/xnbmanual_edit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改XnbManual页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = xnbmanualService.findById(pd);	//根据ID读取
			mv.setViewName("money/xnbmanual/xnbmanual_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除XnbManual");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				xnbmanualService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出XnbManual到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("创建时间");	//1
			titles.add("更新时间");	//2
			titles.add("创建人");	//3
			titles.add("更新人");	//4
			titles.add("关键字");	//5
			titles.add("描述");	//6
			titles.add("排序");	//7
			titles.add("登录名");	//8
			titles.add("会员昵称");	//9
			titles.add("会员真实姓名");	//10
			titles.add("虚拟币类型");	//11
			titles.add("状态");	//12
			titles.add("数量");	//13
			titles.add("审核时间");	//14
			titles.add("审核人");	//15
			titles.add("是否发送消息");	//16
			dataMap.put("titles", titles);
			List<PageData> varOList = xnbmanualService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("CREATEDATETIME"));	//1
				vpd.put("var2", varOList.get(i).getString("UPDATEDATETIME"));	//2
				vpd.put("var3", varOList.get(i).getString("CREATEUSER"));	//3
				vpd.put("var4", varOList.get(i).getString("UPDATEUSER"));	//4
				vpd.put("var5", varOList.get(i).getString("KEYWORD"));	//5
				vpd.put("var6", varOList.get(i).getString("DESCRIPTION"));	//6
				vpd.put("var7", varOList.get(i).get("SEQ").toString());	//7
				vpd.put("var8", varOList.get(i).getString("LOGINNAME"));	//8
				vpd.put("var9", varOList.get(i).getString("USERNICKNAME"));	//9
				vpd.put("var10", varOList.get(i).getString("USERREALNAME"));	//10
				vpd.put("var11", varOList.get(i).getString("XNBTYPE"));	//11
				vpd.put("var12", varOList.get(i).getString("STATUS"));	//12
				vpd.put("var13", varOList.get(i).get("NUM").toString());	//13
				vpd.put("var14", varOList.get(i).getString("AUDITDATETIME"));	//14
				vpd.put("var15", varOList.get(i).getString("AUDITPEOPLE"));	//15
				vpd.put("var16", varOList.get(i).getString("SENDMESSAGE"));	//16
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
