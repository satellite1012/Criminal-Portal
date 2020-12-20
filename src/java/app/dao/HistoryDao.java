package app.dao;

import app.models.HistoryModified;
import static java.lang.System.currentTimeMillis;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class HistoryDao {

    Connection connect;

    public Connection getConnect() {
        return connect;
    }

    public void setConnect(Connection connect) {
        this.connect = connect;
    }

    public ArrayList<HistoryModified> getListHistoryModifieds() throws Exception {
        ArrayList<HistoryModified> list = new ArrayList<>();
        long a = currentTimeMillis();

        Statement stt = connect.createStatement();
        ResultSet rs = stt.executeQuery("Select * from HistoryModified");

        while (rs.next()) {
            int id_history = rs.getInt(1);
            int id_user = rs.getInt(2);
            int edited_at_id_user = rs.getInt(3);
            int edited_at_id_case = rs.getInt(4);
            int edited_at_id_culprit = rs.getInt(5);
            int edited_at_id_case_culprit = rs.getInt(6);
            String action = rs.getString(7);
            String modified_at = rs.getString(8);
            list.add(new HistoryModified(id_history, id_user, edited_at_id_user, edited_at_id_case, edited_at_id_culprit, edited_at_id_case_culprit, action, modified_at));

        }
        return list;
    }

    public void updateHistory_At_UserID_ByID(int id_user, int id_history) throws Exception {

        String sql = "Update HistoryModified "
                + "set id_user  = ? "
                + "where id_history = ?";
        PreparedStatement stt = connect.prepareStatement(sql);
        stt.setInt(1, id_user);
        stt.setInt(2, id_history);
        stt.executeUpdate();

    }

    public void updateHistory_UserPerformed(int id_user) throws Exception {

        String sql = "Update HistoryModified "
                + "set id_user  = ? "
                + "where id_history = (Select max(id_history) from HistoryModified)";
        PreparedStatement stt = connect.prepareStatement(sql);
        stt.setInt(1, id_user);
        stt.executeUpdate();

    }

    public void deleteHistoryByID(int ID) throws Exception {

        String sql = "delete from HistoryModified"
                + " where id_history = " + ID;
        PreparedStatement stt = connect.prepareStatement(sql);
        stt.executeUpdate();

    }

    public void deleteAllHistory() throws Exception {

        String sql = "delete from HistoryModified";
        PreparedStatement stt = connect.prepareStatement(sql);
        stt.executeUpdate();

    }

}
