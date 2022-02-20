/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author Linhnvhdev
 */
public class Student extends User {
    private int roomId;
    private int classId;
    private Teacher teacher;

    public Student() {
    }
    
    public Student(int roomId, int classId,Teacher teacher, int id, String name, boolean sex, String phoneNumber, String gmail) {
        super(id, name, sex, phoneNumber, gmail);
        this.roomId = roomId;
        this.teacher = teacher;
        this.classId = classId;
    }

    public int getRoomId() {
        return roomId;
    }

    public Teacher getTeacher() {
        return teacher;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    
}
