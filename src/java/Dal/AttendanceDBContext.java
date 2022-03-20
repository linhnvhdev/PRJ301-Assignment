/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Linhnvhdev
 */
public class AttendanceDBContext extends DBContext {
    
    public void takeAttendance(Date sqlTodayDate, int id, boolean attendance) {
        if(!checkAttendance(sqlTodayDate,id)){
            insertAttendance(sqlTodayDate,id,attendance);
        }
        else{
            updateAttendance(sqlTodayDate,id,attendance);
        }
    }
    
    public boolean getAttendance(Date sqlTodayDate, int id) {
        try {
            String sql="SELECT [Status]\n" +
                    "  FROM [PRJ301-Assignment].[dbo].[Attendance]\n" +
                    "   WHERE [Date] = ? AND StudentId=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, sqlTodayDate);
            stm.setInt(2, id);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                return rs.getBoolean("Status");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean checkAttendance(Date sqlTodayDate, int id) {
        try {
            String sql="SELECT COUNT(*) Total\n" +
                    "  FROM [PRJ301-Assignment].[dbo].[Attendance]\n" +
                    "   WHERE [Date] = ? AND StudentId=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, sqlTodayDate);
            stm.setInt(2, id);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                return rs.getInt("Total") > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void insertAttendance(Date sqlTodayDate, int id, boolean attendance) {
        try {
            String sql="INSERT INTO [PRJ301-Assignment].[dbo].[Attendance]\n" +
                    "           ([Date]\n" +
                    "           ,[StudentId]\n" +
                    "           ,[Status])\n" +
                    "     VALUES\n" +
                    "           (?\n" +
                    "           ,?\n" +
                    "           ,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, sqlTodayDate);
            stm.setInt(2, id);
            stm.setBoolean(3, attendance);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateAttendance(Date sqlTodayDate, int id, boolean attendance) {
        try {
            String sql="UPDATE [PRJ301-Assignment].[dbo].[Attendance]\n" +
            "   SET [Status] = ?\n" +
            " WHERE [Date] = ? AND StudentId = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setBoolean(1, attendance);
            stm.setDate(2, sqlTodayDate);
            stm.setInt(3, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void delete(int studentId) {
        try {
            String sql="DELETE FROM [PRJ301-Assignment].[dbo].[Attendance]\n" +
                    "      WHERE StudentId = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, studentId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
