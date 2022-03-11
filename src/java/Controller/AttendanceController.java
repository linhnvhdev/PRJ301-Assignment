/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dal.AttendanceDBContext;
import Dal.ClassDBContext;
import Dal.StudentDBContext;
import Dal.TeacherDBContext;
import Model.Account;
import Model.Classes;
import Model.Student;
import Model.Teacher;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Hashtable;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Linhnvhdev
 */
public class AttendanceController extends HttpServlet {

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
        Account account = (Account) request.getSession().getAttribute("account");
        User user = account.getUser();
        Date sqlDate = new Date(System.currentTimeMillis());
        String raw_date = request.getParameter("date");
        if(raw_date != null){
            sqlDate = Date.valueOf(raw_date);
        }
        StudentDBContext studentDB = new StudentDBContext();
        TeacherDBContext teacherDB = new TeacherDBContext();
        AttendanceDBContext attendanceDB = new AttendanceDBContext();
        ArrayList<Student> students;
        Hashtable<Integer,Boolean> attendances = new Hashtable();
        if(user.getRole() == 3){
            Teacher teacher = teacherDB.getTeacherByUserId(user.getId());
            students = studentDB.getStudentsByClass(teacher.getClasses().getId());
            request.setAttribute("teacher", teacher);
        }
        else{
            students = studentDB.getStudents();
        }
        for(Student s: students){
            if(attendanceDB.checkAttendance(sqlDate,s.getId())){
                attendances.put(s.getId(), attendanceDB.getAttendance(sqlDate, s.getId()));
            }
            else attendances.put(s.getId(), false);
        }
        request.setAttribute("Date", sqlDate);
        request.setAttribute("students", students);
        request.setAttribute("attendances",attendances);
        request.getRequestDispatcher("View/attendance.jsp").forward(request, response);
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
        Account account = (Account) request.getSession().getAttribute("account");
        User user = account.getUser();
        Date sqlDate = new Date(System.currentTimeMillis());
        String raw_date = request.getParameter("date");
        if(raw_date != null){
            sqlDate = Date.valueOf(raw_date);
        }
        
        StudentDBContext studentDB = new StudentDBContext();
        TeacherDBContext teacherDB = new TeacherDBContext();
        ArrayList<Student> students;
        
        if(user.getRole() == 3){
            Teacher teacher = teacherDB.getTeacherByUserId(user.getId());
            students = studentDB.getStudentsByClass(teacher.getClasses().getId());
            request.setAttribute("teacher", teacher);
        }
        else{
            students = studentDB.getStudents();
        }
        
        request.setAttribute("students", students);
        AttendanceDBContext attendanceDB =  new AttendanceDBContext();
        for(Student s: students){
            String param = "attendance"+s.getId();
            boolean attendance = Boolean.parseBoolean(request.getParameter(param));
            attendanceDB.takeAttendance(sqlDate,s.getId(),attendance);
        }
        response.sendRedirect("attendance?date="+sqlDate);
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
