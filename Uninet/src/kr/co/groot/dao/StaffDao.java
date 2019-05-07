package kr.co.groot.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import kr.co.groot.dto.Staff;

public class StaffDao {
  private Connection conn;
  private PreparedStatement pstmt;
  private ResultSet rs;
  private DataSource ds;

  public StaffDao() throws NamingException {
    Context context = new InitialContext();
    ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
  }

  /*
   * @method Name: selectAll
   * 
   * @date: 2019. 5. 7
   * 
   * @author: 정성윤
   * 
   * @description: 부서별 관리자의 데이터를 모두 가져오기 위해서 사용한다
   * 
   * @param spec: none
   * 
   * @return: List<Staff>
   */

  public List<Staff> selectAll() throws SQLException {
    String sql = "select * from staff s " + "left join department d "
        + "on dept_id = d.id ";

    conn = ds.getConnection();
    pstmt = conn.prepareStatement(sql);

    rs = pstmt.executeQuery();

    List<Staff> staffList = new ArrayList<>();
    while (rs.next()) {
      Staff staff = new Staff();
      staff.setId(rs.getInt(1));
      staff.setStaffId(rs.getString("staff_id"));
      staff.setEmail(rs.getString("email"));
      staff.setPhoneNumber(rs.getString("phoneNumber"));
      staff.setStaffName(rs.getString("staff_name"));
      staff.setBirthday(rs.getTimestamp("birthday"));
      staff.setImage(rs.getString("image"));
      staff.setIsAdmin(rs.getString("isAdmin"));
      staff.setIsManager(rs.getString("isManager"));
      staff.setDeptId(rs.getInt("dept_id"));
      staff.setDeptName(rs.getString("dept_name"));
      staffList.add(staff);
    }

    rs.close();
    pstmt.close();
    conn.close();

    return staffList;
  }

  public Staff selectStaff(String id) throws SQLException {
    String sql = "select * from staff left join department "
        + "on staff.dept_id = department.id where staff_id = ?";
    Staff staff = new Staff();

    conn = ds.getConnection();
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);
    rs = pstmt.executeQuery();

    if (rs.next()) {
      staff.setId(rs.getInt("id"));
      staff.setStaffId(rs.getString(2));
      staff.setPassword(rs.getString(3));
      staff.setEmail(rs.getString(4));
      staff.setPhoneNumber(rs.getString(5));
      staff.setStaffName(rs.getString(6));
      staff.setBirthday(rs.getTimestamp(7));
      staff.setImage(rs.getString(8));
      staff.setIsAdmin(rs.getString(9));
      staff.setIsManager(rs.getString(10));
      staff.setDeptId(rs.getInt(11));
      staff.setDeptName(rs.getString("dept_name"));
    }
    
    return staff;
  }

  /*
   * @method Name: insertStaff
   * 
   * @date: 2019. 5. 7
   * 
   * @author: 정성윤
   * 
   * @description: 부서별 관리자의 데이터를 삽입하기 위해서 사용한다
   * 
   * @param spec: Staff staff
   * 
   * @return: int
   */
  public int insertStaff(Staff staff) throws SQLException {
    int row = 0;
    String sql = "insert into staff(staff_id, password, staff_name, phone_number,"
        + "email, birthday, dept_id, image, isManager, isAdmin) "
        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    conn = ds.getConnection();
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, staff.getStaffId());
    pstmt.setString(2, staff.getPassword());
    pstmt.setString(3, staff.getStaffName());
    pstmt.setString(4, staff.getPhoneNumber());
    pstmt.setString(5, staff.getEmail());
    pstmt.setTimestamp(6, staff.getBirthday());
    pstmt.setInt(7, staff.getDeptId());
    pstmt.setString(8, staff.getImage());
    pstmt.setString(9, staff.getIsManager());
    pstmt.setString(10, staff.getIsAdmin());

    row = pstmt.executeUpdate();
    pstmt.close();
    conn.close();

    return row;
  }

  /*
   * @method Name: deleteStaff
   * 
   * @date: 2019. 5. 7
   * 
   * @author: 정성윤
   * 
   * @description: 부서별 관리자를 삭제하기 위해 사용한다
   * 
   * @param spec: int id
   * 
   * @return: int
   */

  public int deleteStaff(int id) throws SQLException {
    int row = 0;
    String sql = "delete from staff where id = ?";

    conn = ds.getConnection();
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, id);

    row = pstmt.executeUpdate();
    pstmt.close();
    conn.close();

    return row;
  }

  /*
   * @method Name: updateStaff
   * 
   * @date: 2019. 5. 7
   * 
   * @author: 윤종석
   * 
   * @description: 교직원의 정보를 수정한다.
   * 
   * @param spec: Staff staff
   *
   * @return: int
   */
  public int updateStaff(Staff staff) throws SQLException {
    String sql = "update staff set staff email = ?, phoneNumber = ?, "
        + "staff_name = ?, birthday = ?, isAdmin = ?, isManager = ?, "
        + "dept_id = ? where id = ?";

    conn = ds.getConnection();
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, staff.getEmail());
    pstmt.setString(2, staff.getPhoneNumber());
    pstmt.setString(3, staff.getStaffName());
    pstmt.setTimestamp(4, staff.getBirthday());
    pstmt.setString(5, staff.getIsAdmin());
    pstmt.setString(6, staff.getIsManager());
    pstmt.setInt(7, staff.getDeptId());
    pstmt.setInt(8, staff.getId());

    int row = pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    return row;
  }

  /*
   * @method Name: selectByDept
   * 
   * @date: 2019. 5. 7
   * 
   * @author: 윤종석
   * 
   * @description: 부서별로 교직원을 검색한다
   * 
   * @param spec: int deptId
   * 
   * @return: List<Staff>
   */
  public List<Staff> selectByDept(int deptId) throws SQLException {
    String sql = "select * from staff s " + "left join department d "
        + "on dept_id = d.id " + "where dept_id = ?";

    conn = ds.getConnection();
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, deptId);

    rs = pstmt.executeQuery();

    List<Staff> staffList = new ArrayList<>();
    while (rs.next()) {
      Staff staff = new Staff();
      staff.setId(rs.getInt(1));
      staff.setStaffId(rs.getString("staff_id"));
      staff.setEmail(rs.getString("email"));
      staff.setPhoneNumber(rs.getString("phoneNumber"));
      staff.setStaffName(rs.getString("staff_name"));
      staff.setBirthday(rs.getTimestamp("birthday"));
      staff.setImage(rs.getString("image"));
      staff.setIsAdmin(rs.getString("isAdmin"));
      staff.setIsManager(rs.getString("isManager"));
      staff.setDeptId(rs.getInt("dept_id"));
      staff.setDeptName(rs.getString("dept_name"));
      staffList.add(staff);
    }

    rs.close();
    pstmt.close();
    conn.close();

    return staffList;
  }

  /*
   * @method Name: selectByName
   * 
   * @date: 2019. 5. 7
   * 
   * @author: 윤종석
   * 
   * @description: 입력한 값을 포함하는 이름을 가진 교직원을 불러온다
   * 
   * @param spec: String input
   * 
   * @return: List<Staff>
   */
  public List<Staff> selectByName(String input) throws SQLException {
    String sql = "select * from staff s " + "left join department d "
        + "on dept_id = d.id " + "where staff_name like ?";

    conn = ds.getConnection();
    pstmt = conn.prepareStatement(sql);
    input = "%" + input + "%";
    pstmt.setString(1, input);

    rs = pstmt.executeQuery();

    List<Staff> staffList = new ArrayList<>();
    while (rs.next()) {
      Staff staff = new Staff();
      staff.setId(rs.getInt(1));
      staff.setStaffId(rs.getString("staff_id"));
      staff.setEmail(rs.getString("email"));
      staff.setPhoneNumber(rs.getString("phoneNumber"));
      staff.setStaffName(rs.getString("staff_name"));
      staff.setBirthday(rs.getTimestamp("birthday"));
      staff.setImage(rs.getString("image"));
      staff.setIsAdmin(rs.getString("isAdmin"));
      staff.setIsManager(rs.getString("isManager"));
      staff.setDeptId(rs.getInt("dept_id"));
      staff.setDeptName(rs.getString("dept_name"));
      staffList.add(staff);
    }

    rs.close();
    pstmt.close();
    conn.close();

    return staffList;
  }

  /*
   * @method Name: selectById
   * 
   * @date: 2019. 5. 7
   * 
   * @author: 윤종석
   * 
   * @description: 입력한 값을 포함하는 아이디를 가진 교직원을 검색한다.
   * 
   * @param spec: String input
   * 
   * @return: List<Staff>
   */
  public List<Staff> selectById(String input) throws SQLException {
    String sql = "select * from staff s " + "left join department d "
        + "on dept_id = d.id " + "where staff_id like ?";

    conn = ds.getConnection();
    pstmt = conn.prepareStatement(sql);
    input = "%" + input + "%";
    pstmt.setString(1, input);

    rs = pstmt.executeQuery();

    List<Staff> staffList = new ArrayList<>();
    while (rs.next()) {
      Staff staff = new Staff();
      staff.setId(rs.getInt(1));
      staff.setStaffId(rs.getString("staff_id"));
      staff.setEmail(rs.getString("email"));
      staff.setPhoneNumber(rs.getString("phoneNumber"));
      staff.setStaffName(rs.getString("staff_name"));
      staff.setBirthday(rs.getTimestamp("birthday"));
      staff.setImage(rs.getString("image"));
      staff.setIsAdmin(rs.getString("isAdmin"));
      staff.setIsManager(rs.getString("isManager"));
      staff.setDeptId(rs.getInt("dept_id"));
      staff.setDeptName(rs.getString("dept_name"));
      staffList.add(staff);
    }

    rs.close();
    pstmt.close();
    conn.close();

    return staffList;
  }
}
