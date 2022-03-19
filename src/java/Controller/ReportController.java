/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dal.AttendanceDBContext;
import Dal.OrderDBContext;
import Dal.StudentDBContext;
import Model.Student;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Month;
import java.time.Year;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Hashtable;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Linhnvhdev
 */
public class ReportController extends HttpServlet {

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
        // Get data
        int moneyPerMonth = Integer.parseInt(request.getServletContext().getInitParameter("MoneyPerMonth"));
        int moneyPerDay = Integer.parseInt(request.getServletContext().getInitParameter("MoneyPerDay"));
        String raw_month = request.getParameter("month");
        String raw_year = request.getParameter("year");
        String raw_reportAttendance = request.getParameter("reportAttendance");
        LocalDate curDate = LocalDate.now();
        int month = curDate.getMonthValue();
        int year = curDate.getYear();
        int day = curDate.getDayOfMonth();
        boolean reportAttendance = true;
        if(raw_month != null) month = Integer.parseInt(raw_month);
        if(raw_year != null) year = Integer.parseInt(raw_year);
        if(raw_reportAttendance != null) reportAttendance = Boolean.parseBoolean(raw_reportAttendance);
        
        
        StudentDBContext studentDB = new StudentDBContext();
        OrderDBContext oDB = new OrderDBContext();
        AttendanceDBContext attendanceDB = new AttendanceDBContext();
        ArrayList<Student> students = studentDB.getStudents();
        
        Hashtable<Integer,ArrayList<Integer>> attendances = new Hashtable();
        Hashtable<Integer,Integer> totalAttendance = new Hashtable();
        Hashtable<Integer,Boolean> orders = new Hashtable<>();
        
        int daysInMonth = Month.of(month).length(true);
        if(month == 2)
            if(Year.isLeap(year)) daysInMonth = 29;
            else daysInMonth = 28;
        int[] totalPerDay = new int[daysInMonth];
        Arrays.fill(totalPerDay, 0,0,daysInMonth);
        int totalDayEaten = 0;
        int totalMoneyPay = 0;
        int totalLeft = 0;
        
        for(Student s: students){
            boolean status =oDB.getOrder(s.getId(),month,year);
            orders.put(s.getId(),status);
            totalMoneyPay += (status?moneyPerMonth:0);
        }
        
        for(Student s: students){
            LocalDate startDate = LocalDate.of(year, month,1);
            ArrayList<Integer> status = new ArrayList();
            int total = 0;
            for(LocalDate date = startDate; date.getMonthValue() == month; date = date.plusDays(1)){
                Date sqlDate = Date.valueOf(date);
                if(attendanceDB.checkAttendance(sqlDate,s.getId())){
                    int attendanceStatus = attendanceDB.getAttendance(sqlDate, s.getId())?1:0;
                    status.add(attendanceStatus);
                    if(date.getDayOfWeek().getValue() >= 1 && date.getDayOfWeek().getValue() <= 5){
                        total += attendanceStatus;
                        totalPerDay[date.getDayOfMonth()-1] += attendanceStatus;
                    }
                }
                else status.add(-1);
            }
            attendances.put(s.getId(), status);
            totalAttendance.put(s.getId(), total);
        }
        
        for(int t: totalPerDay) totalDayEaten += t;
        for(Student s: students){
            boolean status = orders.get(s.getId());
            totalMoneyPay += (status)? moneyPerMonth:0;
            totalLeft += ((status)? moneyPerMonth:0)-totalAttendance.get(s.getId())*moneyPerDay;
        }
        
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        request.setAttribute("daysInMonth", daysInMonth);
        request.setAttribute("attendances", attendances);
        request.setAttribute("reportAttendance", reportAttendance);
        request.setAttribute("totalAttendance", totalAttendance);
        request.setAttribute("totalPerDay", totalPerDay);
        request.setAttribute("totalMoneyPay", totalMoneyPay);
        request.setAttribute("totalLeft", totalLeft);
        request.setAttribute("students", students);
        request.setAttribute("orders", orders);
        request.setAttribute("totalDayEaten", totalDayEaten);
        request.getRequestDispatcher("View/report.jsp").forward(request, response);
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
