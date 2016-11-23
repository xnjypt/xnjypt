package com.fh.service.money.rmboperationrecord;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("rmboperationrecordService")
public class RmboperationrecordService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("RmboperationrecordMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("RmboperationrecordMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("RmboperationrecordMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("RmboperationrecordMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("RmboperationrecordMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("RmboperationrecordMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("RmboperationrecordMapper.deleteAll", ArrayDATA_IDS);
	}
	
	/*
	 * 批量锁定
	 */
	public void lockAll(PageData pd)throws Exception{
		dao.update("RmboperationrecordMapper.lockAll", pd);
	}
	
	/*
	* 修改
	*/
	public void editStatus(PageData pd)throws Exception{
		dao.update("RmboperationrecordMapper.editStatus", pd);
	}
}

