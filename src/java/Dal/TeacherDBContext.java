/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dal;

import Model.Classes;
import Model.Teacher;
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
public class TeacherDBContext extends DBContext {
    
        public int getLastInserted(){
        try {
            String sql="SELECT MAX(Id) maxId FROM [Teacher]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if(rs.next()) return rs.getInt("maxId");
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
    public Teacher getTeacherByClassId(int classId){
        try {
            String sql="SELECT t.Id,u.Name,u.PhoneNumber,u.Sex,u.Gmail,t.ClassId\n" +
                    "FROM Teacher t INNER JOIN [User] u ON t.UserId = u.Id\n" +
                    "WHERE t.ClassId=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, classId);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                Teacher t = new Teacher();
                t.setId(rs.getInt("Id"));
                t.setName(rs.getString("Name"));
                t.setPhoneNumber(rs.getString("PhoneNumber"));
                t.setSex(rs.getBoolean("Sex"));
                t.setGmail(rs.getString("Gmail"));
                ClassDBContext classDB = new ClassDBContext();
                Classes c = classDB.getClasses(rs.getInt("ClassId"));
                t.setClasses(c);
                return t;
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Teacher> getTeacher() {
        ArrayList<Teacher> teachers = new ArrayList<>();
        try {    
            String sql = "SELECT t.Id,u.Name,t.ClassId,\n" +
                    "		u.PhoneNumber,u.Sex,u.Gmail\n" +
                    "FROM Teacher t INNER JOIN [User] u ON t.UserId = u.Id\n";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                Teacher t = new Teacher();
                t.setId(rs.getInt("Id"));
                t.setName(rs.getString("Name"));
                ClassDBContext classDB = new ClassDBContext();
                Classes c = classDB.getClasses(rs.getInt("ClassId"));
                t.setClasses(c);
                t.setPhoneNumber(rs.getString("PhoneNumber"));
                t.setSex(rs.getBoolean("Sex"));
                t.setGmail(rs.getString("Gmail"));
                teachers.add(t);
            }       
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return teachers;
    }

    public Teacher getTeacherByUserId(int uid) {
        Teacher t = new Teacher();
        try {
            String sql = "SELECT t.Id,u.Name,t.ClassId,\n" +
                    "		u.PhoneNumber,u.Sex,u.Gmail\n" +
                    "FROM Teacher t INNER JOIN [User] u ON t.UserId = u.Id\n"+
            "WHERE u.Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                t.setId(rs.getInt("Id"));
                t.setName(rs.getString("Name"));
                ClassDBContext classDB = new ClassDBContext();
                Classes c = classDB.getClasses(rs.getInt("ClassId"));
                t.setClasses(c);
                t.setPhoneNumber(rs.getString("PhoneNumber"));
                t.setSex(rs.getBoolean("Sex"));
                t.setGmail(rs.getString("Gmail"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return t;          
    }

    public int insertTeacher(int classId, int userId) {
        try {
            String sql="INSERT INTO [PRJ301-Assignment].[dbo].[Teacher]\n" +
            "           ([UserId]\n" +
            "           ,[ClassId])\n" +
            "     VALUES\n" +
            "           (?\n" +
            "           ,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.setInt(2, classId);
            stm.executeUpdate();
            return getLastInserted();
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public Teacher getTeacher(int teacherId) {
        Teacher t = new Teacher();
        try {
            String sql = "SELECT t.Id,u.Name,t.ClassId,\n" +
                    "		u.PhoneNumber,u.Sex,u.Gmail\n" +
                    "FROM Teacher t INNER JOIN [User] u ON t.UserId = u.Id\n"+
            "WHERE t.Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, teacherId);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                t.setId(rs.getInt("Id"));
                t.setName(rs.getString("Name"));
                ClassDBContext classDB = new ClassDBContext();
                Classes c = classDB.getClasses(rs.getInt("ClassId"));
                t.setClasses(c);
                t.setPhoneNumber(rs.getString("PhoneNumber"));
                t.setSex(rs.getBoolean("Sex"));
                t.setGmail(rs.getString("Gmail"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return t;       
    }

    public int getUserId(int teacherId) {
        try {
            String sql = "SELECT UserId\n" +
            "FROM Teacher\n" +
            "WHERE Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, teacherId);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                return rs.getInt("UserId");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;        
    }

    public void update(int teacherId, int classId, int userId) {
        try {
            String sql="UPDATE [PRJ301-Assignment].[dbo].[Teacher]\n" +
            "   SET [UserId] = ?\n" +
            "      ,[ClassId] = ?\n" +
            "   WHERE Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.setInt(2, classId);
            stm.setInt(3, teacherId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }        
    }

    public void delete(int teacherId) {
        try {
            String sql="DELETE FROM [PRJ301-Assignment].[dbo].[Teacher]\n" +
                    "      WHERE Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, teacherId);
            stm.executeUpdate();        
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
