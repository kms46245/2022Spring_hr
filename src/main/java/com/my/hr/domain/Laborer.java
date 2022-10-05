package com.my.hr.domain;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class Laborer {
	private int laborerId;
	private String name;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private LocalDate hireDate;
		
	@Override
	public String toString() {
		return String.format("%2d %5s %s", laborerId ,name, hireDate);
	}	
}
