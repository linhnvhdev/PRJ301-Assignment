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
public class User {
    private int id;
    private String name;
    private boolean sex;
    private String phoneNumber;
    private String gmail;
    private int role;

    public User() {
    }

    public User(int id, String name, boolean sex, String phoneNumber, String gmail) {
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.phoneNumber = phoneNumber;
        this.gmail = gmail;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public boolean isSex() {
        return sex;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getGmail() {
        return gmail;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setSex(boolean sex) {
        this.sex = sex;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setGmail(String gmail) {
        this.gmail = gmail;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
    
    
}
