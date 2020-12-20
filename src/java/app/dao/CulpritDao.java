package app.dao;

import app.models.Case_Culprit;
import app.models.Culprit;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class CulpritDao {

    Connection connect;

    public Connection getConnect() {
        return connect;
    }

    public void setConnect(Connection connect) {
        this.connect = connect;
    }

    public ArrayList<Culprit> getCulprit_ByCaseID(int caseID, ArrayList<Case_Culprit> a) throws Exception {
        ArrayList<Culprit> list = new ArrayList<>();
        for (Case_Culprit i : a) {
            list.add(getCulpritByID(i.getId_culprit()));
        }
        return list;
    }

    public ArrayList<Culprit> getListCulprits() throws Exception {
        ArrayList<Culprit> list = new ArrayList<>();

        Statement stt = connect.createStatement();
        ResultSet rs = stt.executeQuery("Select * from Culprits");

        while (rs.next()) {

            int id_culprit = rs.getInt(1);
            String identity_card = rs.getString(2);
            String name = rs.getString(3);
            String birth = rs.getString(4);
            String image = rs.getString(5);
            String create_at = rs.getString(6);

            list.add(new Culprit(id_culprit, identity_card, name, birth, image, create_at));
        }

        return list;
    }

    public void addCulprit(Culprit culprit) throws Exception {

        PreparedStatement stt = connect
                .prepareStatement("Insert into Culprits(identity_card,name,birth,image) values (?,?,?,?)");
        stt.setString(1, culprit.getIdentity_card());
        stt.setString(2, culprit.getName());
        stt.setString(3, culprit.getBirth());
        stt.setString(4, culprit.getImage());
        stt.executeUpdate();

    }

    public Culprit getCulpritByID(int ID) throws Exception {
        Culprit c = null;

        Statement stt = connect.createStatement();
        ResultSet rs = stt.executeQuery("Select * from Culprits where id_culprit=" + ID);
        if (rs.next()) {
            int id_culprit = rs.getInt(1);
            String identity_card = rs.getString(2);
            String name = rs.getString(3);
            String birth = rs.getString(4);
            String image = rs.getString(5);
            String create_at = rs.getString(6);
            c = new Culprit(id_culprit, identity_card, name, birth, image, create_at);
        }

        return c;
    }

    public void updateCulpritByID(Culprit culprit) throws Exception {

        String sql = "Update Culprits "
                + "set identity_card = ?,"
                + "name = ?,birth=?,"
                + "image = ? "
                + "where id_culprit = ?";
        PreparedStatement stt = connect.prepareStatement(sql);
        stt.setString(1, culprit.getIdentity_card());
        stt.setString(2, culprit.getName());
        stt.setString(3, culprit.getBirth());
        stt.setString(4, culprit.getImage());
        stt.setInt(5, culprit.getId_culprit());
        stt.executeUpdate();

    }

    public void deleteCulpritByID(int ID) throws Exception {

        String sql = "delete from Culprits"
                + " where id_culprit = " + ID;
        PreparedStatement stt = connect.prepareStatement(sql);
        stt.executeUpdate();

    }

}
