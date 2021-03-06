package com.fh.controller.money.waitauditxnbt;

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
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.Jurisdiction;
import com.fh.service.money.userxnb.UserxnbService;
import com.fh.service.money.waitauditxnbt.WaitAuditXnbTService;
import com.fh.service.money.xnboperationrecord.XnboperationrecordService;

/** 
 * 类名称：WaitAuditXnbTController
 * 创建人：FH 
 * 创建时间：2016-10-28
 */
@Controller
@RequestMapping(value="/waitauditxnbt")
public class WaitAuditXnbTController extends BaseController {
	
	String menuUrl = "waitauditxnbt/list.do"; //菜单地址(权限用)
	@Resource(name="waitauditxnbtService")
	private WaitAuditXnbTService waitauditxnbtService;
	@Resource(name="xnboperationrecordService")
	private XnboperationrecordService xnboperationrecordService;
	@Resource(name="userxnbService")
	private UserxnbService userxnbService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增WaitAuditXnbT");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("WAITAUDITXNBT_ID", this.get32UUID());	//主键
		pd.put("CREATEDATETIME", Tools.date2Str(new Date()));	//创建时间
		pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//修改时间
		pd.put("CREATEUSER", "");	//创建人
		pd.put("UPDATEUSER", "");	//修改人
		pd.put("KEYWORD", "");	//关键字
		pd.put("LOGINNAME", "");	//登录名
		pd.put("USERNICKNAME", "");	//会员昵称
		pd.put("USERREALNAME", "");	//会员真实姓名
		pd.put("XNBTYPE", "");	//虚拟币类型
		pd.put("STATUS", "");	//状态
		pd.put("TRADINGTYPE", "");	//交易类型
		pd.put("NUM", "");	//数量
		pd.put("POUNDAGE", "");	//手续费
		pd.put("WITHDRAWALADDRESS", "");	//提现地址
		waitauditxnbtService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除WaitAuditXnbT");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			waitauditxnbtService.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, "修改WaitAuditXnbT");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		waitauditxnbtService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 审核
	 */
	@RequestMapping(value="/audit")
	@ResponseBody
	public Object audit() {
		logBefore(logger, "审核WaitAuditXnbT");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			PageData pageData = waitauditxnbtService.findById(pd);
			
			//验证钱包密码是否正确。。。。
			
			if("正在处理".equals(pageData.getString("STATUS"))){
				pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//修改时间
				pd.put("UPDATEUSER", this.getUserName());	//修改人
				pd.put("STATUS", "提现成功");	//状态
				waitauditxnbtService.editStatus(pd);
				//更新虚拟币操作列表
				pd.put("XNBOPERATIONRECORD_ID", pd.getString("WAITAUDITXNBT_ID"));	//修改人
				xnboperationrecordService.editStatus(pd);
				//更新用户虚拟币列表
				userxnbService.plugNum(pageData);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
				pd.put("result", "审核失败,只有状态为:‘正在处理’的提现记录才允许审核!");
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
	
	/**
	 * 锁定
	 */
	@RequestMapping(value="/lock")
	@ResponseBody
	public Object lock() {
		logBefore(logger, "锁定WaitAuditXnbT");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			PageData pageData = waitauditxnbtService.findById(pd);
			
			if("等待提现".equals(pageData.getString("STATUS"))){
				pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//修改时间
				pd.put("UPDATEUSER", this.getUserName());	//修改人
				pd.put("STATUS", "正在处理");	//状态
				waitauditxnbtService.editStatus(pd);
				//更新虚拟币操作列表
				pd.put("XNBOPERATIONRECORD_ID", pd.getString("WAITAUDITXNBT_ID"));	//修改人
				xnboperationrecordService.editStatus(pd);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
				pd.put("result", "锁定失败,只有状态为:‘等待提现’的充值记录才允许锁定!");
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
	
	/**
	 * 取消锁定
	 */
	@RequestMapping(value="/unlock")
	@ResponseBody
	public Object unlock() {
		logBefore(logger, "取消锁定WaitAuditXnbT");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			PageData pageData = waitauditxnbtService.findById(pd);
			
			if("正在处理".equals(pageData.getString("STATUS"))){
				pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//修改时间
				pd.put("UPDATEUSER", this.getUserName());	//修改人
				pd.put("STATUS", "等待提现");	//状态
				waitauditxnbtService.editStatus(pd);
				//更新虚拟币操作列表
				pd.put("XNBOPERATIONRECORD_ID", pd.getString("WAITAUDITXNBT_ID"));	//修改人
				xnboperationrecordService.editStatus(pd);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
				pd.put("result", "取消锁定失败,只有状态为:‘正在处理’的充值记录才允许取消锁定!");
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
	
	/**
	 * 取消提现
	 */
	@RequestMapping(value="/cancel")
	@ResponseBody
	public Object cancel() {
		logBefore(logger, "取消提现WaitAuditXnbT");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			
			pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//修改时间
			pd.put("UPDATEUSER", this.getUserName());	//修改人
			pd.put("STATUS", "取消提现");	//状态
			waitauditxnbtService.editStatus(pd);
			//更新虚拟币操作列表
			pd.put("XNBOPERATIONRECORD_ID", pd.getString("WAITAUDITXNBT_ID"));	//修改人
			xnboperationrecordService.editStatus(pd);
			pd.put("msg", "ok");
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
	
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表WaitAuditXnbT");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			List<PageData>	varList = waitauditxnbtService.list(page);	//列出WaitAuditXnbT列表
			mv.setViewName("money/waitauditxnbt/waitauditxnbt_list");
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
		logBefore(logger, "去新增WaitAuditXnbT页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("money/waitauditxnbt/waitauditxnbt_edit");
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
		logBefore(logger, "去修改WaitAuditXnbT页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = waitauditxnbtService.findById(pd);	//根据ID读取
			mv.setViewName("money/waitauditxnbt/waitauditxnbt_edit");
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
		logBefore(logger, "批量删除WaitAuditXnbT");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				waitauditxnbtService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, "导出WaitAuditXnbT到excel");
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
			titles.add("登录名");	//6
			titles.add("会员昵称");	//7
			titles.add("会员真实姓名");	//8
			titles.add("虚拟币类型");	//9
			titles.add("状态");	//10
			titles.add("交易类型");	//11
			titles.add("数量");	//12
			titles.add("手续费");	//13
			titles.add("提现地址");	//14
			dataMap.put("titles", titles);
			List<PageData> varOList = waitauditxnbtService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("CREATEDATETIME"));	//1
				vpd.put("var2", varOList.get(i).getString("UPDATEDATETIME"));	//2
				vpd.put("var3", varOList.get(i).getString("CREATEUSER"));	//3
				vpd.put("var4", varOList.get(i).getString("UPDATEUSER"));	//4
				vpd.put("var5", varOList.get(i).getString("KEYWORD"));	//5
				vpd.put("var6", varOList.get(i).getString("LOGINNAME"));	//6
				vpd.put("var7", varOList.get(i).getString("USERNICKNAME"));	//7
				vpd.put("var8", varOList.get(i).getString("USERREALNAME"));	//8
				vpd.put("var9", varOList.get(i).getString("XNBTYPE"));	//9
				vpd.put("var10", varOList.get(i).getString("STATUS"));	//10
				vpd.put("var11", varOList.get(i).getString("TRADINGTYPE"));	//11
				vpd.put("var12", varOList.get(i).get("NUM").toString());	//12
				vpd.put("var13", varOList.get(i).get("POUNDAGE").toString());	//13
				vpd.put("var14", varOList.get(i).getString("WITHDRAWALADDRESS"));	//14
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
