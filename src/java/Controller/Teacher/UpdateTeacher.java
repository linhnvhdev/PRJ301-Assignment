/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller.Teacher;

import Dal.ClassDBContext;
import Dal.StudentDBContext;
import Dal.TeacherDBContext;
import Dal.UserDBContext;
import Model.Classes;
import Model.Student;
import Model.Teacher;
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
public class UpdateTeacher extends HttpServlet {

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
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));
        ClassDBContext classDB = new ClassDBContext();
        ArrayList<Classes> classes = classDB.getClasses();
        TeacherDBContext teacherDB = new TeacherDBContext();
        Teacher teacher = teacherDB.getTeacher(teacherId);
        request.setAttribute("classes", classes);
        request.setAttribute("teacher", teacher);
        request.getRequestDispatcher("../View/Teacher/update.jsp").forward(request, response);        
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
        request.setCharacterEncoding("utf-8");
        String raw_teacherId = request.getParameter("teacherId");
        String raw_name = request.getParameter("name");
        String raw_gender = request.getParameter("gender");
        String raw_classId = request.getParameter("classId");
        String raw_phoneNumber = request.getParameter("phoneNumber");
        String raw_gmail = request.getParameter("gmail");
        //Validate data
        int teacherId = Integer.parseInt(raw_teacherId);
        String name = raw_name;
        boolean gender = Boolean.parseBoolean(raw_gender);
        int classId = Integer.parseInt(raw_classId);
        String phoneNumber = raw_phoneNumber;
        String gmail = raw_gmail;
        //Update
        UserDBContext userDB = new UserDBContext();
        TeacherDBContext teacherDB = new TeacherDBContext();
        int userId = teacherDB.getUserId(teacherId);
        userDB.update(userId,name, gender, phoneNumber, gmail, 3);
        teacherDB.update(teacherId,classId,userId);
        response.sendRedirect("list");
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
