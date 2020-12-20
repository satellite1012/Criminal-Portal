package app.models;

import java.io.Serializable;

public class User implements Serializable {

    private static final long serialVersionUID = 1L;
    private int id_user = -1;
    private String username;
    private String password;
    private String avatar;
    private String profile_title = "Chưa có thông tin";
    private String profile_description = "Chưa có thông tin";
    private String full_name;
    private int role;
    private String created_at;

    public User() {
    }

    public User(int id_user, String username, String password, String avatar, String profile_title, String profile_description, String full_name, int role, String created_at) {
        this.id_user = id_user;
        this.username = username;
        this.password = password;
        this.avatar = avatar;
        this.profile_title = profile_title;
        this.profile_description = profile_description;
        this.full_name = full_name;
        this.role = role;
        this.created_at = app.controllers.Validation.DateSqltoDateJs(created_at);
    }

    public User(String username, String password, String avatar, String profile_title, String profile_description, String full_name, int role) {
        this.username = username;
        this.password = password;
        this.avatar = avatar;
        this.profile_title = profile_title;
        this.profile_description = profile_description;
        this.full_name = full_name;
        this.role = role;
    }

    public int getId_user() {
        return id_user;
    }

    public void setId_user(int id_user) {
        this.id_user = id_user;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getProfile_title() {
        return profile_title;
    }

    public void setProfile_title(String profile_title) {
        this.profile_title = profile_title;
    }

    public String getProfile_description() {
        return profile_description;
    }

    public void setProfile_description(String profile_description) {
        this.profile_description = profile_description;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

}
