/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dal;

import Model.Classes;
import Model.Student;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Linhnvhdev
 */
public class StudentDBContext extends DBContext{
    
    public int getLastInserted(){
        try {
            String sql="SELECT MAX(Id) maxId FROM [Student]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if(rs.next()) return rs.getInt("maxId");
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
    public ArrayList<Student> getStudents(){
        ArrayList<Student> students = new ArrayList<>();
        try {
            String sql = "SELECT s.Id,u.Name,s.ClassId,s.RoomId,\n" +
            "		u.PhoneNumber,u.Sex,u.Gmail\n" +
            "FROM Student s INNER JOIN [User] u ON s.UserId = u.Id\n";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                Student s = new Student();
                s.setId(rs.getInt("Id"));
                s.setName(rs.getString("Name"));
                ClassDBContext classDB = new ClassDBContext();
                Classes c = classDB.getClasses(rs.getInt("ClassId"));
                s.setClass(c);
                s.setRoomId(rs.getInt("RoomId"));
                s.setPhoneNumber(rs.getString("PhoneNumber"));
                s.setSex(rs.getBoolean("Sex"));
                s.setGmail(rs.getString("Gmail"));
                students.add(s);
            }
            return students;
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return students;
    }
    
    public Student getStudent(int studentId){
        Student s = new Student();
        try {
            String sql = "SELECT s.Id,u.Name,s.ClassId,s.RoomId,\n" +
            "		u.PhoneNumber,u.Sex,u.Gmail\n" +
            "FROM Student s INNER JOIN [User] u ON s.UserId = u.Id\n"+
            "WHERE s.Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, studentId);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                s.setId(rs.getInt("Id"));
                s.setName(rs.getString("Name"));
                ClassDBContext classDB = new ClassDBContext();
                Classes c = classDB.getClasses(rs.getInt("ClassId"));
                s.setClass(c);
                s.setRoomId(rs.getInt("RoomId"));
                s.setPhoneNumber(rs.getString("PhoneNumber"));
                s.setSex(rs.getBoolean("Sex"));
                s.setGmail(rs.getString("Gmail"));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return s;
    }

    public int insertStudent(int classId, int userId, int roomId) {
        try {
            String sql="INSERT INTO [PRJ301-Assignment].[dbo].[Student]\n" +
            "           ([ClassId]\n" +
            "           ,[UserId]\n" +
            "           ,[RoomId])\n" +
            "     VALUES\n" +
            "           (?\n" +
            "           ,?\n" +
            "           ,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, userId);
            stm.setInt(3, roomId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return getLastInserted();
    }

    public int getUser(int studentId) {
        try {
            String sql = "SELECT UserId\n" +
            "FROM Student\n" +
            "WHERE Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, studentId);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                return rs.getInt("UserId");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public void update(int studentId, int classId, int userId, int roomId) {
        try {
            String sql="UPDATE [PRJ301-Assignment].[dbo].[Student]\n" +
            "   SET [ClassId] = ?\n" +
            "      ,[UserId] = ?\n" +
            "      ,[RoomId] = ?\n" +
            "   WHERE Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, classId);
            stm.setInt(2, userId);
            stm.setInt(3, roomId);
            stm.setInt(4, studentId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }        
    }

    public void delete(int studentId) {
        try {
            String sql="DELETE FROM [PRJ301-Assignment].[dbo].[Student]\n" +
                    "      WHERE Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, studentId);
            stm.executeUpdate();        
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Student getStudentByUserId(int uid) {
        Student s = new Student();
        try {
            String sql = "SELECT s.Id,u.Name,s.ClassId,s.RoomId,\n" +
            "		u.PhoneNumber,u.Sex,u.Gmail\n" +
            "FROM Student s INNER JOIN [User] u ON s.UserId = u.Id\n"+
            "WHERE u.Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                s.setId(rs.getInt("Id"));
                s.setName(rs.getString("Name"));
                ClassDBContext classDB = new ClassDBContext();
                Classes c = classDB.getClasses(rs.getInt("ClassId"));
                s.setClass(c);
                s.setRoomId(rs.getInt("RoomId"));
                s.setPhoneNumber(rs.getString("PhoneNumber"));
                s.setSex(rs.getBoolean("Sex"));
                s.setGmail(rs.getString("Gmail"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return s;        
    }
}
