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
import java.util.Collections;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Linhnvhdev
 */
public class TeacherController extends HttpServlet {

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
        TeacherDBContext teacherDB = new TeacherDBContext();
        ArrayList<Classes> classes = classDB.getClasses();
        ArrayList<Teacher> teachers = teacherDB.getTeacher();
        request.setAttribute("teachers", teachers);
        request.setAttribute("classes", classes);
        Collections.sort(teachers);
        request.getRequestDispatcher("../View/Teacher/teacher.jsp").forward(request, response);
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
        String raw_name = request.getParameter("sname");
        String raw_gender = request.getParameter("sgender");
        String raw_classId = request.getParameter("sclassId");
        //Validate data
        String name = (raw_name == null || raw_name.trim().length() == 0)?"none":raw_name;
        String gender = (raw_gender == null || raw_gender.trim().length() == 0)?"none":raw_gender;
        int classId = (raw_classId == null)?-1:Integer.parseInt(raw_classId);
        String phoneNumber = "none";
        String gmail = "none";
        //Initialize
        UserDBContext userDB = new UserDBContext();
        TeacherDBContext teacherDB = new TeacherDBContext();
        ClassDBContext classDB = new ClassDBContext();
        
        // Search
        
        ArrayList<Integer> usersId = userDB.getUser(name,gender,phoneNumber,gmail,"teacher");
        ArrayList<Teacher> teachers = new ArrayList();
        for(int uid : usersId){
            Teacher t = teacherDB.getTeacherByUserId(uid);
            if(classId == -1 || t.getClasses().getId()== classId)
                teachers.add(t);
        }
        request.setAttribute("teachers", teachers);
        Collections.sort(teachers);
        ArrayList<Classes> classes = classDB.getClasses();
        request.setAttribute("classes", classes);
        request.getRequestDispatcher("../View/Teacher/teacher.jsp").forward(request, response);
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
