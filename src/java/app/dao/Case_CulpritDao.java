package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import app.models.Case_Culprit;

public class Case_CulpritDao {

    Connection connect;

    public Connection getConnect() {
        return connect;
    }

    public void setConnect(Connection connect) {
        this.connect = connect;
    }

    public ArrayList<Case_Culprit> getListCaseCulprits() throws Exception {
        ArrayList<Case_Culprit> list = new ArrayList<>();

        Statement stt = connect.createStatement();
        ResultSet rs = stt.executeQuery("Select * from Case_Culprit");
        while (rs.next()) {
            int id_case_culprit = rs.getInt(1);
            int id_culprit = rs.getInt(2);
            int id_case = rs.getInt(3);
            String information = rs.getString(4);
            list.add(new Case_Culprit(id_case_culprit, id_culprit, id_case, information));
        }

        return list;
    }

    public Case_Culprit getCase_CulpritByID(int ID) throws Exception {

        Statement stt = connect.createStatement();
        ResultSet rs = stt.executeQuery("Select * from Case_Culprit where id_case_culprit=" + ID);
        if (rs.next()) {
            int id_case_culprit = rs.getInt(1);
            int id_culprit = rs.getInt(2);
            int id_case = rs.getInt(3);
            String information = rs.getString(4);
            return new Case_Culprit(id_case_culprit, id_culprit, id_case, information);
        }

        return null;
    }

    public ArrayList<Case_Culprit> getCase_CulpritByID_Culprit(int ID_Culprit) throws Exception {
        ArrayList<Case_Culprit> list = new ArrayList<>();

        Statement stt = connect.createStatement();
        ResultSet rs = stt.executeQuery("Select * from Case_Culprit where id_culprit=" + ID_Culprit);
        while (rs.next()) {
            int id_case_culprit = rs.getInt(1);
            int id_culprit = rs.getInt(2);
            int id_case = rs.getInt(3);
            String information = rs.getString(4);
            list.add(new Case_Culprit(id_case_culprit, id_culprit, id_case, information));
        }

        return list;
    }

    public ArrayList<Case_Culprit> getCase_CulpritByID_Case(int ID_Case) throws Exception {
        ArrayList<Case_Culprit> list = new ArrayList<>();

        Statement stt = connect.createStatement();
        ResultSet rs = stt.executeQuery("Select * from Case_Culprit where id_case=" + ID_Case);
        while (rs.next()) {
            int id_case_culprit = rs.getInt(1);
            int id_culprit = rs.getInt(2);
            int id_case = rs.getInt(3);
            String information = rs.getString(4);
            list.add(new Case_Culprit(id_case_culprit, id_culprit, id_case, information));
        }

        return list;
    }

    public void addCaseCulprit(Case_Culprit case_culprit) throws Exception {

        PreparedStatement stt = connect.prepareStatement(
                "Insert into Case_Culprit(id_culprit,id_case,information) values (?,?,?)");
        stt.setInt(1, case_culprit.getId_culprit());
        stt.setInt(2, case_culprit.getId_case());
        stt.setString(3, case_culprit.getInformation());
        stt.executeUpdate();

    }

    public void deleteByID(int ID) throws Exception {

        PreparedStatement stt = connect.prepareStatement("delete from Case_Culprit where id_case_culprit=" + ID);
        stt.execute();

    }

    public void deleteByCaseID(int ID) throws Exception {

        PreparedStatement stt = connect.prepareStatement("delete from Case_Culprit where id_case=" + ID);
        stt.execute();

    }
}
