package com.fh.service.virtualmoney;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("vmtypeService")
public class VmTypeService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("VmTypeMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("VmTypeMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("VmTypeMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("VmTypeMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("VmTypeMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("VmTypeMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("VmTypeMapper.deleteAll", ArrayDATA_IDS);
	}
	
	/*
	* 开盘，停盘
	*/
	public void editIsuspended(PageData pd)throws Exception{
		dao.update("VmTypeMapper.editIsuspended", pd);
	}
	
	/*
	* 禁用
	*/
	public void editDisable(PageData pd)throws Exception{
		dao.update("VmTypeMapper.editDisable", pd);
	}
	
	/*
	* 新增手续费信息
	*/
	public void saveChargeFee(PageData pd)throws Exception{
		dao.save("VmTypeMapper.saveChargeFee", pd);
	}
	
	/*
	* 通过id获取手续费数据
	*/
	public PageData findChargeFeeById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("VmTypeMapper.findChargeFeeById", pd);
	}
	
	/*
	* 修改手续费信息
	*/
	public void editChargeFee(PageData pd)throws Exception{
		dao.update("VmTypeMapper.editChargeFee", pd);
	}
}

