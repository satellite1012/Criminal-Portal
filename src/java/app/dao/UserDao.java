package app.dao;

import app.models.User;
import static java.lang.System.currentTimeMillis;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class UserDao {

    Connection connect;

    public Connection getConnect() {
        return connect;
    }

    public void setConnect(Connection connect) {
        this.connect = connect;
    }

    public ArrayList<User> getListUsers() throws Exception {
        ArrayList<User> list = new ArrayList<>();
        Statement stt = connect.createStatement();
        ResultSet rs = stt.executeQuery("Select * from Users");
        while (rs.next()) {
            int id_user = rs.getInt(1);
            String username = rs.getString(2);
            String password = rs.getString(3);
            String avatar = rs.getString(4);
            String profile_title = rs.getString(5);
            String profile_description = rs.getString(6);
            String full_name = rs.getString(7);
            int role = rs.getInt(8);
            String create_at = rs.getString(9);
            list.add(new User(id_user, username, password, avatar, profile_title, profile_description, full_name, role, create_at));
        }
        return list;
    }

    public void addUser(User user) throws Exception {
        PreparedStatement stt = connect
                .prepareStatement("Insert into Users( username,password,avatar,profile_title,profile_description,full_name,role) "
                        + "values (?,?,?,?,?,?,?)");
        stt.setString(1, user.getUsername());
        stt.setString(2, user.getPassword());
        stt.setString(3, user.getAvatar());
        stt.setString(4, user.getProfile_title());
        stt.setString(5, user.getProfile_description());
        stt.setString(6, user.getFull_name());
        stt.setInt(7, user.getRole());
        stt.executeUpdate();
    }

    public User getUserByID(int ID) throws Exception {
        User s = null;
        Statement stt = connect.createStatement();
        ResultSet rs = stt.executeQuery("select * from Users where id_user = " + ID);
        if (rs.next()) {
            int id_user = rs.getInt(1);
            String username = rs.getString(2);
            String password = rs.getString(3);
            String avatar = rs.getString(4);
            String profile_title = rs.getString(5);
            String profile_description = rs.getString(6);
            String full_name = rs.getString(7);
            int role = rs.getInt(8);
            String create_at = rs.getString(9);
            s = new User(id_user, username, password, avatar, profile_title, profile_description, full_name, role, create_at);
        }
        return s;
    }

    public User findUserByUsername(String user) throws Exception {
        ArrayList<User> a = getListUsers();
        for (User i : a) {
            if (user.equals(i.getUsername())) {
                return i;
            }
        }
        return null;
    }

    public void updateUserByID(User user) throws Exception {
        String sql = "Update Users "
                + "set username  = ?,"
                + "password = ?,avatar=?,"
                + "profile_title = ?,profile_description=?,"
                + "full_name=?,role=? "
                + "where id_user = ?";
        PreparedStatement stt = connect.prepareStatement(sql);
        stt.setString(1, user.getUsername());
        stt.setString(2, user.getPassword());
        stt.setString(3, user.getAvatar());
        stt.setString(4, user.getProfile_title());
        stt.setString(5, user.getProfile_description());
        stt.setString(6, user.getFull_name());
        stt.setInt(7, user.getRole());
        stt.setInt(8, user.getId_user());
        stt.executeUpdate();
    }

    public void deleteUserByID(int ID) throws Exception {
        String sql = "delete from Users"
                + " where id_user = " + ID;
        PreparedStatement stt = connect.prepareStatement(sql);
        stt.executeUpdate();
    }

}
