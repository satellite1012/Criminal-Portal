package app.models;

import java.io.Serializable;

public class Case implements Serializable {

    private static final long serialVersionUID = 1L;
    private int id_case;
    private String case_name;
    private String case_description;
    private String date_start;
    private String date_end;
    private String image;
    private String created_at;

    public Case() {
    }

    public Case(int id_case, String case_name, String case_description, String date_start, String date_end, String image, String created_at) {
        this.id_case = id_case;
        this.case_name = case_name;
        this.case_description = case_description;
        this.date_start = app.controllers.Validation.DateSqltoDateJs(date_start);
        this.date_end = app.controllers.Validation.DateSqltoDateJs(date_end);
        this.image = image;
        this.created_at = app.controllers.Validation.DateSqltoDateJs(created_at);
    }

    public Case(String case_name, String case_description, String date_start, String date_end, String image) {
        this.case_name = case_name;
        this.case_description = case_description;
        this.date_start = app.controllers.Validation.DateSqltoDateJs(date_start);
        this.date_end = app.controllers.Validation.DateSqltoDateJs(date_end);
        this.image = image;
    }

    public String getCase_description() {
        return case_description;
    }

    public void setCase_description(String case_description) {
        this.case_description = case_description;
    }

    public int getId_case() {
        return id_case;
    }

    public void setId_case(int id_case) {
        this.id_case = id_case;
    }

    public String getCase_name() {
        return case_name;
    }

    public void setCase_name(String case_name) {
        this.case_name = case_name;
    }

    public String getDate_start() {
        return date_start;
    }

    public void setDate_start(String date_star) {
        this.date_start = date_star;
    }

    public String getDate_end() {
        return date_end;
    }

    public void setDate_end(String date_end) {
        this.date_end = date_end;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    @Override
    public String toString() {
        return "Case [id_case=" + id_case + ", case_name=" + case_name + ", date_star=" + date_start + ", date_end="
                + date_end + ", image=" + image + ", created_at=" + created_at + "]";
    }
}
