package com.my.hr.dao.map;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.my.hr.domain.Laborer;

public interface LaborerMap {
	List<Laborer> selectLaborers();
	Laborer selectLaborer(int laborerId);
	void insertLaborer(@Param("name")String laborerName,
					   @Param("hireDate")LocalDate HireDate);
	void updateLaborer(Laborer laborer);
	void deleteLaborer(int laborerId);
}
