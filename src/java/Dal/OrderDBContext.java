/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Linhnvhdev
 */
public class OrderDBContext extends DBContext {

    public Boolean getOrder(int id, int month, int year) {
        try {
            String sql="SELECT [Status]\n" +
            "  FROM [PRJ301-Assignment].[dbo].[Order]\n" +
            " WHERE [StudentId]=? AND [Month] = ? AND [Year] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setInt(2, month);
            stm.setInt(3, year);
            ResultSet rs = stm.executeQuery();
            if(rs.next())
                return rs.getBoolean("Status");
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void takeOrder(int id, int month, int year, boolean status) {
        if(checkOrder(id,month,year))
            updateOrder(id,month,year,status);
        else
            insertOrder(id,month,year,status);
    }

    public boolean checkOrder(int id, int month, int year) {
        try {
            String sql="SELECT COUNT(*) Total" +
                    "  FROM [PRJ301-Assignment].[dbo].[Order]\n" +
                    "WHERE [StudentId]=? AND [Month] = ? AND [Year] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setInt(2, month);
            stm.setInt(3, year);
            ResultSet rs = stm.executeQuery();
            if(rs.next())
                return rs.getInt("Total") > 0;
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void updateOrder(int id, int month, int year, boolean status) {
        try {
            String sql="UPDATE [PRJ301-Assignment].[dbo].[Order]\n" +
                    "   SET [Status] = ?\n" +
                    " WHERE StudentId = ? AND [Month] = ? AND [Year] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setBoolean(1, status);
            stm.setInt(2, id);
            stm.setInt(3, month);
            stm.setInt(4, year);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertOrder(int id, int month, int year, boolean status) {
        try {
            String sql="INSERT INTO [PRJ301-Assignment].[dbo].[Order]\n" +
                    "           ([StudentId]\n" +
                    "           ,[Month]\n" +
                    "           ,[Year]\n" +
                    "           ,[Status])\n" +
                    "     VALUES\n" +
                    "           (?\n" +
                    "           ,?\n" +
                    "           ,?\n" +
                    "           ,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setInt(2, month);
            stm.setInt(3, year);
            stm.setBoolean(4, status);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void delete(int studentId) {
        try {
            String sql="DELETE FROM [PRJ301-Assignment].[dbo].[Order]\n" +
                         "      WHERE StudentId=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, studentId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
