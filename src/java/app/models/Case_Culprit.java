package app.models;
//Author: Doan Duc Tin

public class Case_Culprit {

    private int id_case_culprit;
    private int id_culprit;
    private int id_case;
    private String information;

    public Case_Culprit(int id_culprit, int id_case) {
        this.id_culprit = id_culprit;
        this.id_case = id_case;
        this.information = "Chưa có thông tin";
    }

    public Case_Culprit(int id_case_culprit, int id_culprit, int id_case, String information) {
        this.id_case_culprit = id_case_culprit;
        this.id_case = id_case;
        this.id_culprit = id_culprit;
        this.information = information;
    }

    public int getId_case_culprit() {
        return id_case_culprit;
    }

    public void setId_case_culprit(int id_case_culprit) {
        this.id_case_culprit = id_case_culprit;
    }

    public int getId_case() {
        return id_case;
    }

    public void setId_case(int id_case) {
        this.id_case = id_case;
    }

    public int getId_culprit() {
        return id_culprit;
    }

    public void setId_culprit(int id_culprit) {
        this.id_culprit = id_culprit;
    }

    public String getInformation() {
        return information;
    }

    public void setInfomation(String information) {
        this.information = information;
    }

}
