package com.my.hr.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.hr.dao.LaborerDao;
import com.my.hr.domain.Laborer;

@Service("laborerService")
public class LaborerServiceImpl implements LaborerService{
	@Autowired private LaborerDao laborerDao;
		
	@Override
	public List<Laborer> getLaborers(){
		return laborerDao.selectLaborers();
	}
	

	@Override
	public Laborer getLaborer(int laborerId) {
		return laborerDao.selectLaborer(laborerId);
	}
	

	@Override
	public void addLaborer(String laborerName, LocalDate HireDate) {
		laborerDao.insertLaborer(laborerName, HireDate);
	}
	

	@Override
	public void fixLaborer(Laborer laborer) {
		laborerDao.updateLaborer(laborer);
	}
	
	@Override
	public void delLaborer(int laborerId) {
		laborerDao.deleteLaborer(laborerId);
	}
}
