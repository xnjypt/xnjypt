package com.fh.controller.virtualmoney;

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
import com.fh.service.virtualmoney.VmTypeService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Tools;

/** 
 * 类名称：VmTypeController
 * 创建人：FH 
 * 创建时间：2016-10-26
 */
@Controller
@RequestMapping(value="/vmtype")
public class VmTypeController extends BaseController {
	
	String menuUrl = "vmtype/list.do"; //菜单地址(权限用)
	@Resource(name="vmtypeService")
	private VmTypeService vmtypeService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增VmType");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("VMTYPE_ID", this.get32UUID());	//主键
		pd.put("CREATEDATETIME", Tools.date2Str(new Date()));	//创建时间
		pd.put("CREATEUSER", this.getUserName());	//创建人
		pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//修改时间
		pd.put("UPDATEUSER", "");	//修改人
		vmtypeService.save(pd);
		
		pd.put("LEVEL1C", 0);
		pd.put("LEVEL1T", 0);
		pd.put("LEVEL2C", 0);
		pd.put("LEVEL2T", 0);
		pd.put("LEVEL3C", 0);
		pd.put("LEVEL3T", 0);
		pd.put("LEVEL4C", 0);
		pd.put("LEVEL4T", 0);
		pd.put("LEVEL5C", 0);
		pd.put("LEVEL5T", 0);
		pd.put("LEVEL6C", 0);
		pd.put("LEVEL6T", 0);
		vmtypeService.saveChargeFee(pd);
		
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除VmType");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			vmtypeService.delete(pd);
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
		logBefore(logger, "修改VmType");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		vmtypeService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	/**
	 * 停盘
	 */
	@RequestMapping(value="/stop")
	@ResponseBody
	public Object stop() {
		logBefore(logger, "停盘VmType");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			
			pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//修改时间
			pd.put("UPDATEUSER", this.getUserName());	//修改人
			pd.put("ISUSPENDED", "true");	//停盘
			vmtypeService.editIsuspended(pd);
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
	 * 开盘
	 */
	@RequestMapping(value="/start")
	@ResponseBody
	public Object start() {
		logBefore(logger, "开盘VmType");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			
			pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//修改时间
			pd.put("UPDATEUSER", this.getUserName());	//修改人
			pd.put("ISUSPENDED", "false");	//开盘
			vmtypeService.editIsuspended(pd);
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
	 * 禁用
	 */
	@RequestMapping(value="/disable")
	@ResponseBody
	public Object disable() {
		logBefore(logger, "禁用VmType");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			
			pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//修改时间
			pd.put("UPDATEUSER", this.getUserName());	//修改人
			pd.put("STATUS", "禁用");	//禁用
			vmtypeService.editDisable(pd);
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
		logBefore(logger, "列表VmType");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			List<PageData>	varList = vmtypeService.list(page);	//列出VmType列表
			mv.setViewName("virtualmoney/vmtype/vmtype_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/listAll")
	public ModelAndView listAll(Page page){
		logBefore(logger, "列表VmType");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			List<PageData>	varList = vmtypeService.listAll(pd);	//列出VmType列表
			System.out.println(varList);
			mv.setViewName("virtualmoney/vmtype/vmtype_list");
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
		logBefore(logger, "去新增VmType页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("virtualmoney/vmtype/vmtype_edit");
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
		logBefore(logger, "去修改VmType页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = vmtypeService.findById(pd);	//根据ID读取
			mv.setViewName("virtualmoney/vmtype/vmtype_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去修改手续费页面
	 */
	@RequestMapping(value="/goChargeFee")
	public ModelAndView goChargeFee(){
		logBefore(logger, "去修改VmType手续费页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = vmtypeService.findChargeFeeById(pd);	//根据ID读取
			mv.setViewName("virtualmoney/vmtype/vmtype_editChargeFee");
			mv.addObject("msg", "editChargeFee");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 修改手续费信息
	 */
	@RequestMapping(value="/editChargeFee")
	public ModelAndView editChargeFee() throws Exception{
		logBefore(logger, "修改editChargeFee");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("UPDATEUSER", this.getUserName());
		pd.put("UPDATEDATETIME", Tools.date2Str(new Date()));	//修改时间
		vmtypeService.editChargeFee(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除VmType");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				vmtypeService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, "导出VmType到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("创建时间");	//1
			titles.add("创建人");	//2
			titles.add("修改时间");	//3
			titles.add("修改人");	//4
			titles.add("排序");	//5
			titles.add("描述");	//6
			titles.add("简体类型名称");	//7
			titles.add("繁体类型名称");	//8
			titles.add("英语类型名称");	//9
			titles.add("货币编码");	//10
			titles.add("父ID");	//11
			titles.add("语言");	//12
			titles.add("状态");	//13
			titles.add("简称");	//14
			titles.add("符号");	//15
			titles.add("ip");	//16
			titles.add("url");	//17
			titles.add("端口");	//18
			titles.add("是否可以交易");	//19
			titles.add("是否可以提现");	//20
			titles.add("是否停盘");	//21
			titles.add("开盘时间");	//22
			titles.add("停盘时间");	//23
			titles.add("介绍");	//24
			titles.add("accessKey");	//25
			titles.add("secrtKey");	//26
			titles.add("logo");	//27
			titles.add("关键字");	//28
			dataMap.put("titles", titles);
			List<PageData> varOList = vmtypeService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("CREATEDATETIME"));	//1
				vpd.put("var2", varOList.get(i).getString("CREATEUSER"));	//2
				vpd.put("var3", varOList.get(i).getString("UPDATEDATETIME"));	//3
				vpd.put("var4", varOList.get(i).getString("UPDATEUSER"));	//4
				vpd.put("var5", varOList.get(i).get("SEQ").toString());	//5
				vpd.put("var6", varOList.get(i).getString("DESCRIPTION"));	//6
				vpd.put("var7", varOList.get(i).getString("JTTYPENAME"));	//7
				vpd.put("var8", varOList.get(i).getString("FTTYPENAME"));	//8
				vpd.put("var9", varOList.get(i).getString("ENTYPENAME"));	//9
				vpd.put("var10", varOList.get(i).getString("VMNUMBER"));	//10
				vpd.put("var11", varOList.get(i).getString("PID"));	//11
				vpd.put("var12", varOList.get(i).getString("LANGUAGE"));	//12
				vpd.put("var13", varOList.get(i).getString("STATUS"));	//13
				vpd.put("var14", varOList.get(i).getString("SHORTNAME"));	//14
				vpd.put("var15", varOList.get(i).getString("SYMBOL"));	//15
				vpd.put("var16", varOList.get(i).getString("IP"));	//16
				vpd.put("var17", varOList.get(i).getString("URL"));	//17
				vpd.put("var18", varOList.get(i).getString("PORT"));	//18
				vpd.put("var19", varOList.get(i).getString("ISTRADING"));	//19
				vpd.put("var20", varOList.get(i).getString("ISWITHDRAWAL"));	//20
				vpd.put("var21", varOList.get(i).getString("ISUSPENDED"));	//21
				vpd.put("var22", varOList.get(i).getString("OPENDATETIME"));	//22
				vpd.put("var23", varOList.get(i).getString("CLOSEDATETIME"));	//23
				vpd.put("var24", varOList.get(i).getString("INTRODUCTION"));	//24
				vpd.put("var25", varOList.get(i).getString("ACCESSKEY"));	//25
				vpd.put("var26", varOList.get(i).getString("SECRTKEY"));	//26
				vpd.put("var27", varOList.get(i).getString("LOGO"));	//27
				vpd.put("var28", varOList.get(i).getString("KEYWORD"));	//28
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
	
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/typeList")
	@ResponseBody
	public Object typeList() throws Exception{
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData>	varList = vmtypeService.listAll(pd);	//列出VmType列表
			map.put("list", varList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
}
