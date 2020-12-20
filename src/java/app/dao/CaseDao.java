package app.dao;

import app.models.Case;
import app.models.Case_Culprit;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class CaseDao {

    Connection connect;

    public Connection getConnect() {
        return connect;
    }

    public void setConnect(Connection connect) {
        this.connect = connect;
    }

    public ArrayList<Case> getCase_ByCulpritID(int culpritID, ArrayList<Case_Culprit> a) throws Exception {
        ArrayList<Case> list = new ArrayList<>();
        for (Case_Culprit i : a) {
            list.add(getCaseByID(i.getId_case()));
        }
        return list;
    }

    public ArrayList<Case> getListCases() throws Exception {
        ArrayList<Case> list = new ArrayList<>();
        Statement stt = connect.createStatement();
        ResultSet rs = stt.executeQuery("Select * from Cases");
        while (rs.next()) {
            int id_case = rs.getInt(1);
            String case_name = rs.getString(2);
            String case_description = rs.getString(3);
            String date_start = rs.getString(4);
            String date_end = rs.getString(5);
            String image = rs.getString(6);
            String create_at = rs.getString(7);
            list.add(new Case(id_case, case_name, case_description, date_start, date_end, image, create_at));
        }
        return list;
    }

    public void addCase(Case Case) throws Exception {
        PreparedStatement stt = connect
                .prepareStatement("Insert into Cases(case_name, case_description, date_start, date_end, image)"
                        + " values (?,?,?,?,?)");
        stt.setString(1, Case.getCase_name());
        stt.setString(2, Case.getCase_description());
        stt.setString(3, Case.getDate_start());
        stt.setString(4, Case.getDate_end());
        stt.setString(5, Case.getImage());
        stt.executeUpdate();
    }

    public Case getCaseByID(int ID) throws Exception {
        Case c = null;
        Statement stt = connect.createStatement();
        ResultSet rs = stt.executeQuery("select * from Cases where id_case=" + ID);
        if (rs.next()) {
            int id_case = rs.getInt(1);
            String case_name = rs.getString(2);
            String case_description = rs.getString(3);
            String date_start = rs.getString(4);
            String date_end = rs.getString(5);
            String image = rs.getString(6);
            String created_at = rs.getString(7);
            c = new Case(id_case, case_name, case_description, date_start, date_end, image, created_at);
        }
        return c;
    }

    public void updateCaseByID(Case Case) throws Exception {
        String sql = "Update Cases "
                + "set case_name = ?,case_description  = ?,"
                + "date_start = ?,date_end=?,"
                + "image = ? "
                + "where id_case = ?";
        PreparedStatement stt = connect.prepareStatement(sql);
        stt.setString(1, Case.getCase_name());
        stt.setString(2, Case.getCase_description());
        stt.setString(3, Case.getDate_start());
        stt.setString(4, Case.getDate_end());
        stt.setString(5, Case.getImage());
        stt.setInt(6, Case.getId_case());
        stt.executeUpdate();
    }

    public void deleteCaseByID(int ID) throws Exception {
        String sql = "delete from Cases"
                + " where id_case = " + ID;
        PreparedStatement stt = connect.prepareStatement(sql);
        stt.executeUpdate();
    }

}
