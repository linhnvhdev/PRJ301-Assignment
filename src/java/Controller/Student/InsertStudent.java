/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller.Student;

import Dal.AccountDBContext;
import Dal.ClassDBContext;
import Dal.StudentDBContext;
import Dal.UserDBContext;
import Model.Classes;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Linhnvhdev
 */
public class InsertStudent extends HttpServlet {
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ClassDBContext classDB = new ClassDBContext();
        ArrayList<Classes> classes = classDB.getClasses();
        request.setAttribute("classes", classes);
        request.getRequestDispatcher("../View/Student/insert.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get raw data
        String raw_name = request.getParameter("name");
        String raw_gender = request.getParameter("gender");
        String raw_classId = request.getParameter("classId");
        String raw_phoneNumber = request.getParameter("phoneNumber");
        String raw_roomId = request.getParameter("roomId");
        //Validate data
        String name = raw_name;
        boolean gender = Boolean.parseBoolean(raw_gender);
        int classId = Integer.parseInt(raw_classId);
        String phoneNumber = raw_phoneNumber;
        int roomId = Integer.parseInt(raw_roomId);
        //Insert
        UserDBContext userDB = new UserDBContext();
        StudentDBContext studentDB = new StudentDBContext();
        AccountDBContext accountDB = new AccountDBContext();
        
        int userId = userDB.insertUser(name, gender, phoneNumber, "none", "student");
        int studentId = studentDB.insertStudent(classId,userId,roomId);
        accountDB.createAccount(name.replaceAll("\\s","")+studentId,"12345678", userId);
        response.sendRedirect("search");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
