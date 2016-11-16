package com.fh.controller.money.rmbmanual;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.Jurisdiction;
import com.fh.service.money.membermomey.MemberMomeyService;
import com.fh.service.money.rmbmanual.RmbManualService;

/** 
 * 类名称：RmbManualController
 * 创建人：FH 
 * 创建时间：2016-10-28
 */
@Controller
@RequestMapping(value="/rmbmanual")
public class RmbManualController extends BaseController {
	
	String menuUrl = "rmbmanual/list.do"; //菜单地址(权限用)
	@Resource(name="rmbmanualService")
	private RmbManualService rmbmanualService;
	@Resource(name="membermomeyService")
	private MemberMomeyService membermomeyService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增RmbManual");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData pageData = membermomeyService.findByLoginName(pd);
		pd.put("RMBMANUAL_ID", this.get32UUID());	//主键
		pd.put("CREATEDATETIME", Tools.date2Str(new Date()));	//创建时间
		pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//修改时间
		pd.put("CREATEUSER", "");	//创建人
		pd.put("UPDATEUSER", "");	//修改人
		pd.put("KEYWORD", pd.getString("LOGINNAME"));	//关键字
		pd.put("SEQ", "0");	//排序
		pd.put("USERNICKNAME", pageData.get("USERNICKNAME"));	//会员昵称
		pd.put("USERREALNAME", pageData.get("USERREALNAME"));	//会员真实姓名
		pd.put("STATUS", "暂存");	//状态
		pd.put("AUDITPEOPLE", "");	//审核人
		rmbmanualService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除RmbManual");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			rmbmanualService.delete(pd);
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
		logBefore(logger, "审核RmbManual");
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
			rmbmanualService.audit(pd);
			PageData pageData = rmbmanualService.findById(pd);
			pageData.put("UPDATEUSER", USERNAME);
			membermomeyService.edit(pageData);
			
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
		logBefore(logger, "列表RmbManual");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
//			String KEYWORD = pd.getString("KEYWORD");
//			String CREATEDATETIME = pd.getString("CREATEDATETIME");
//			if(null != KEYWORD && !"".equals(KEYWORD)){
//				pd.put("KEYWORD", KEYWORD.trim());
//			}
//			if(null != CREATEDATETIME && !"".equals(CREATEDATETIME)){
//				pd.put("CREATEDATETIME", CREATEDATETIME.trim());
//			}
			page.setPd(pd);
			List<PageData>	varList = rmbmanualService.list(page);	//列出RmbManual列表
			mv.setViewName("money/rmbmanual/rmbmanual_list");
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
		logBefore(logger, "去新增RmbManual页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("money/rmbmanual/rmbmanual_edit");
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
		logBefore(logger, "去修改RmbManual页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = rmbmanualService.findById(pd);	//根据ID读取
			mv.setViewName("money/rmbmanual/rmbmanual_edit");
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
		logBefore(logger, "批量删除RmbManual");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				rmbmanualService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, "导出RmbManual到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("创建时间");	//1
			titles.add("修改时间");	//2
			titles.add("创建人");	//3
			titles.add("修改人");	//4
			titles.add("关键字");	//5
			titles.add("描述");	//6
			titles.add("排序");	//7
			titles.add("登录名");	//8
			titles.add("会员昵称");	//9
			titles.add("会员真实姓名");	//10
			titles.add("汇款方式");	//11
			titles.add("状态");	//12
			titles.add("金额");	//13
			titles.add("审核人");	//14
			dataMap.put("titles", titles);
			List<PageData> varOList = rmbmanualService.listAll(pd);
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
				vpd.put("var11", varOList.get(i).getString("REMITTANCETYPE"));	//11
				vpd.put("var12", varOList.get(i).getString("STATUS"));	//12
				vpd.put("var13", varOList.get(i).get("MONEY").toString());	//13
				vpd.put("var14", varOList.get(i).getString("AUDITPEOPLE"));	//14
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
