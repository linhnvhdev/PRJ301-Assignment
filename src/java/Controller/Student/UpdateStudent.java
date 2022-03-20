/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller.Student;

import Dal.ClassDBContext;
import Dal.StudentDBContext;
import Dal.UserDBContext;
import Model.Account;
import Model.Classes;
import Model.Student;
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
public class UpdateStudent extends HttpServlet {

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
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        ClassDBContext classDB = new ClassDBContext();
        StudentDBContext studentDB = new StudentDBContext();
        ArrayList<Classes> classes = classDB.getClasses();
        Student student = studentDB.getStudent(studentId);
        request.setAttribute("classes", classes);
        request.setAttribute("student", student);
        request.getRequestDispatcher("../View/Student/update.jsp").forward(request, response);        
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
        request.setCharacterEncoding("utf-8");
        Account account = (Account) request.getSession().getAttribute("account");
        // Get raw data
        String raw_studentId = request.getParameter("studentId");
        String raw_name = request.getParameter("name");
        String raw_gender = request.getParameter("gender");
        String raw_classId = request.getParameter("classId");
        String raw_phoneNumber = request.getParameter("phoneNumber");
        String raw_roomId = request.getParameter("roomId");
        //Validate data
        int studentId = Integer.parseInt(raw_studentId);
        String name = raw_name;
        boolean gender = Boolean.parseBoolean(raw_gender);
        int classId = Integer.parseInt(raw_classId);
        String phoneNumber = raw_phoneNumber;
        int roomId = Integer.parseInt(raw_roomId);
        //Update
        UserDBContext userDB = new UserDBContext();
        StudentDBContext studentDB = new StudentDBContext();
        int userId = studentDB.getUser(studentId);
        userDB.update(userId,name, gender, phoneNumber, "none", 4);
        
        studentDB.update(studentId,classId,userId,roomId);
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
