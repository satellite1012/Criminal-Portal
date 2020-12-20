package app.models;

import java.io.Serializable;

public class HistoryModified implements Serializable {

    private static final long serialVersionUID = 1L;
    private int id_history;
    private int id_user;
    private int edited_at_id_user;
    private int edited_at_id_case;
    private int edited_at_id_culprit;
    private int edited_at_id_case_culprit;
    private String action;
    private String modified_at;

    public HistoryModified() {
    }

    public HistoryModified(int id_user, int edited_at_id_user, int edited_at_id_case, int edited_at_id_culprit, int edited_at_id_case_culprit, String action) {
        this.id_user = id_user;
        this.edited_at_id_user = edited_at_id_user;
        this.edited_at_id_case = edited_at_id_case;
        this.edited_at_id_culprit = edited_at_id_culprit;
        this.edited_at_id_case_culprit = edited_at_id_case_culprit;
        this.action = action;
    }

    public HistoryModified(int id_history, int id_user, int edited_at_id_user, int edited_at_id_case, int edited_at_id_culprit, int edited_at_id_case_culprit, String action, String modified_at) {
        this.id_history = id_history;
        this.id_user = id_user;
        this.edited_at_id_user = edited_at_id_user;
        this.edited_at_id_case = edited_at_id_case;
        this.edited_at_id_culprit = edited_at_id_culprit;
        this.edited_at_id_case_culprit = edited_at_id_case_culprit;
        this.action = action;
        this.modified_at = app.controllers.Validation.DateSqltoDateJs(modified_at);
    }

    public int getId_history() {
        return id_history;
    }

    public void setId_history(int id_history) {
        this.id_history = id_history;
    }

    public int getId_user() {
        return id_user;
    }

    public void setId_user(int id_user) {
        this.id_user = id_user;
    }

    public int getEdited_at_id_user() {
        return edited_at_id_user;
    }

    public void setEdited_at_id_user(int edited_at_id_user) {
        this.edited_at_id_user = edited_at_id_user;
    }

    public int getEdited_at_id_case() {
        return edited_at_id_case;
    }

    public void setEdited_at_id_case(int edited_at_id_case) {
        this.edited_at_id_case = edited_at_id_case;
    }

    public int getEdited_at_id_culprit() {
        return edited_at_id_culprit;
    }

    public void setEdited_at_id_culprit(int edited_at_id_culprit) {
        this.edited_at_id_culprit = edited_at_id_culprit;
    }

    public int getEdited_at_id_case_culprit() {
        return edited_at_id_case_culprit;
    }

    public void setEdited_at_id_case_culprit(int edited_at_id_case_culprit) {
        this.edited_at_id_case_culprit = edited_at_id_case_culprit;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getModified_at() {
        return modified_at;
    }

    public void setModified_at(String modified_at) {
        this.modified_at = modified_at;
    }

}
