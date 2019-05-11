package kr.co.groot.page;

import kr.co.groot.dao.StaffDao;

public class PaginatorByAdmin {
	private StaffDao staffDao;
	
	public int getPageNumber() throws Exception {
		staffDao = new StaffDao();
		
		int staff = staffDao.countHowManyStaff();
		int page = (staff % 20 == 0) ? (staff / 20) : (staff / 20 +1);
		
		return page;
	}
	
	public int getPageNumber(String option, String word) throws Exception {
		staffDao = new StaffDao();
		int page = 0;
		int staff = 0;
		
		switch(option) {
		case "deptname" :
		case "name" :
			staff = staffDao.countHowManyStaffWithOption(option, word);
			break;
		case "default" :
			staff = staffDao.countHowManyStaff();
			break;
		}
		
		page = (staff % 20 == 0) ? (staff / 20) : (staff / 20 +1);
		return page;
		
	}
}
