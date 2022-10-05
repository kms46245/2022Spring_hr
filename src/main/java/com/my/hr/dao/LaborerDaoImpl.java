package com.my.hr.dao;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.hr.dao.map.LaborerMap;
import com.my.hr.domain.Laborer;

@Repository("laborerDao")
public class LaborerDaoImpl implements LaborerDao{
	@Autowired private LaborerMap laborerMap;
		
	@Override
	public List<Laborer> selectLaborers(){
		return laborerMap.selectLaborers();
	}
	
	@Override
	public Laborer selectLaborer(int laborerId) {
		return laborerMap.selectLaborer(laborerId);
	}
	
	@Override
	public void insertLaborer(String laborerName, LocalDate HireDate) {
		laborerMap.insertLaborer(laborerName, HireDate);
	}
	
	@Override
	public void updateLaborer(Laborer laborer) {
		laborerMap.updateLaborer(laborer);
	}
	
	@Override
	public void deleteLaborer(int laborerId) {
		laborerMap.deleteLaborer(laborerId);
	}
}
