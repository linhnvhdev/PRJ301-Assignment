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
public class Student extends User implements Comparable<Student> {
    private int roomId;
    private Classes classes;
    public Student() {
    }
    
    public Student(int roomId, Classes classes, int id, String name, boolean sex, String phoneNumber, String gmail) {
        super(id, name, sex, phoneNumber, gmail);
        this.roomId = roomId;
        this.classes = classes;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public Classes getClasses() {
        return classes;
    }

    public void setClass(Classes classes) {
        this.classes = classes;
    }

    @Override
    public int compareTo(Student t) {
        return this.getClasses().getId() - t.getClasses().getId();
    }

    
}
