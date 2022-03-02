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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Linhnvhdev
 */
public class TeacherDBContext extends DBContext {
    public Teacher getTeacher(int classId){
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
}
