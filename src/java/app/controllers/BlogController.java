package app.controllers;

import app.dao.CaseDao;
import app.dao.DatabaseIO;
import app.dao.HistoryDao;
import app.models.Case;
import app.models.User;
import com.opensymphony.xwork2.ActionSupport;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

public class BlogController extends ActionSupport implements SessionAware {

    public static ArrayList<Case> caseList = null;
    private String log = null;
    private String url = null;
    private Map<String, Object> session;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getLog() {
        return log;
    }

    public void setLog(String log) {
        this.log = log;
    }

    public String getAll() {
        try {
            //Excute
            CaseDao caseDao = new CaseDao();
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            caseDao.setConnect(db.getConnection());
            if (caseList == null) {
                try {
                    caseList = caseDao.getListCases();
                    db.closeConnection();
                } catch (SQLException e) {
                    db.closeConnection();
                }
            }
        } catch (Exception e) {
            log = e.toString();
            return "failure";
        }
        //View
        return "success";
    }

    public String editCase() {
        try {
            //Validation User
            User temp = (User) session.get("user");
            if (temp == null) {
                throw new Exception("Not login");
            }
            if (temp.getRole() > 1) {
                throw new Exception("Role not accepted");
            }
            //Init
            CaseDao caseDao = new CaseDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            int caseId = Integer.parseInt(request.getParameter("caseId_edit"));
            String case_name = request.getParameter("case_name");
            String case_des = request.getParameter("case_description");
            String date_start = request.getParameter("date_start");
            String date_end = request.getParameter("date_end");
            String image = request.getParameter("image");
            if (date_end.equals("")) {
                date_end = null;
            }
            if (image.equals("")) {
                image = "https://tranhieuit.com/wp-content/uploads/2019/04/ngan-chan-loi-404-wordpress.jpg";
            }
            //Validation
            Validation.validateEmpty(case_name);
            Validation.validateEmpty(case_des);
            Validation.validateCannotClick(case_name);
            Validation.validateCannotClick(case_des);
            Validation.validateCannotClick(image);
            date_start = Validation.DateJstoDateSql(date_start);
            date_end = Validation.DateJstoDateSql(date_end);
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                caseDao.setConnect(db.getConnection());
                Case caseSelected = caseDao.getCaseByID(caseId);
                caseSelected.setCase_name(case_name);
                caseSelected.setCase_description(case_des);
                caseSelected.setDate_start(date_start);
                caseSelected.setDate_end(date_end);
                caseSelected.setImage(image);
                caseDao.updateCaseByID(caseSelected);
                //Update List
                caseList = caseDao.getListCases();
                //History
                HistoryDao historyDao = new HistoryDao();
                historyDao.setConnect(db.getConnection());
                historyDao.updateHistory_UserPerformed(temp.getId_user());
                HistoryController.historyList = historyDao.getListHistoryModifieds();
                db.closeConnection();
            } catch (SQLException e) {
                db.closeConnection();
            }
        } catch (Exception e) {
            log = e.toString().replaceFirst("java.lang.Exception:", "");
            return "failure";
        }
        //View
        url = "forms";
        return "redirect";
    }

    public String deleteCase() {
        try {
            //Validation User
            User temp = (User) session.get("user");
            if (temp == null) {
                throw new Exception("Not login");
            }
            if (temp.getRole() > 1) {
                throw new Exception("Role not accepted");
            }
            //Init
            CaseDao caseDao = new CaseDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                caseDao.setConnect(db.getConnection());
                caseDao.deleteCaseByID(Integer.parseInt(request.getParameter("caseId_delete")));
                //Update list
                caseList = caseDao.getListCases();
                //History
                HistoryDao historyDao = new HistoryDao();
                historyDao.setConnect(db.getConnection());
                historyDao.updateHistory_UserPerformed(temp.getId_user());
                HistoryController.historyList = historyDao.getListHistoryModifieds();
                db.closeConnection();
            } catch (SQLException e) {
                db.closeConnection();
            }
        } catch (Exception e) {
            log = e.toString();
            return "failure";
        }
        //View
        url = "forms";
        return "redirect";
    }

    public String addCase() {
        try {
            //Validation User
            User temp = (User) session.get("user");
            if (temp == null) {
                throw new Exception("Not login");
            }
            if (temp.getRole() > 1) {
                throw new Exception("Role not accepted");
            }
            //Init
            CaseDao caseDao = new CaseDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            String case_name = request.getParameter("case_name");
            String case_des = request.getParameter("case_description");
            String date_start = request.getParameter("date_start");
            String date_end = request.getParameter("date_end");
            String image = request.getParameter("image");
            if (date_end.equals("")) {
                date_end = null;
            }
            if (image.equals("")) {
                image = "https://tranhieuit.com/wp-content/uploads/2019/04/ngan-chan-loi-404-wordpress.jpg";
            }
            //Validation
            Validation.validateEmpty(case_name);
            Validation.validateEmpty(case_des);
            Validation.validateCannotClick(case_name);
            Validation.validateCannotClick(case_des);
            Validation.validateCannotClick(image);
            date_start = Validation.DateJstoDateSql(date_start);
            date_end = Validation.DateJstoDateSql(date_end);
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                caseDao.setConnect(db.getConnection());
                Case caseSelected = new Case();
                caseSelected.setCase_name(case_name);
                caseSelected.setCase_description(case_des);
                caseSelected.setDate_start(date_start);
                caseSelected.setDate_end(date_end);
                caseSelected.setImage(image);
                caseDao.addCase(caseSelected);
                //Update List
                caseList = caseDao.getListCases();
                //History
                HistoryDao historyDao = new HistoryDao();
                historyDao.setConnect(db.getConnection());
                historyDao.updateHistory_UserPerformed(temp.getId_user());
                HistoryController.historyList = historyDao.getListHistoryModifieds();
                db.closeConnection();
            } catch (SQLException e) {
                db.closeConnection();
            }
        } catch (Exception e) {
            log = e.toString().replaceFirst("java.lang.Exception:", "");
            return "failure";
        }
        //View
        url = "forms";
        return "redirect";
    }

    @Override
    public void setSession(Map<String, Object> map) {
        session = map;
    }
}
