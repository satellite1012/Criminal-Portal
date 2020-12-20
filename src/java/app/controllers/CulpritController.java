package app.controllers;

import app.dao.CaseDao;
import app.dao.Case_CulpritDao;
import app.dao.CulpritDao;
import app.dao.DatabaseIO;
import app.dao.HistoryDao;
import app.models.Case;
import app.models.Case_Culprit;
import app.models.Culprit;
import app.models.User;
import com.opensymphony.xwork2.ActionSupport;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

public class CulpritController extends ActionSupport implements SessionAware {

    public static ArrayList<Culprit> culpritList = null;
    public static Culprit culpritSelected = null;
    public static ArrayList<Case> culpritCaseList = null;
    private String url = null;
    private Map<String, Object> session;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    private String log = null;

    public String getLog() {
        return log;
    }

    public void setLog(String log) {
        this.log = log;
    }

    public String getAll() {
        try {
            //Excute
            CulpritDao culpritDao = new CulpritDao();
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            culpritDao.setConnect(db.getConnection());
            if (culpritList == null) {
                try {
                    culpritList = culpritDao.getListCulprits();
                    db.closeConnection();
                } catch (SQLException e) {
                    e.printStackTrace();
                    db.closeConnection();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            log = e.toString();
            return "failure";
        }
        //View
        return "success";
    }

    public String getCulpritAtId() {
        try {
            //Init
            HttpServletRequest request = ServletActionContext.getRequest();
            CulpritDao culpritDao = new CulpritDao();
            CaseDao caseDao = new CaseDao();
            Case_CulpritDao caseCulpritDao = new Case_CulpritDao();
            int id = Integer.parseInt(request.getParameter("culpritId_show"));
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                culpritDao.setConnect(db.getConnection());
                caseCulpritDao.setConnect(db.getConnection());
                caseDao.setConnect(db.getConnection());
                culpritSelected = culpritDao.getCulpritByID(id);
                ArrayList<Case_Culprit> temp = caseCulpritDao.getCase_CulpritByID_Culprit(id);
                culpritCaseList = caseDao.getCase_ByCulpritID(id, temp);
                db.closeConnection();
            } catch (SQLException e) {
                e.printStackTrace();
                db.closeConnection();
            }
        } catch (Exception e) {
            e.printStackTrace();
            log = e.toString();
            return "failure";
        }
        //View
        return "success";
    }

    public String editCulprit() {
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
            CulpritDao culpritDao = new CulpritDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            int culpritId = Integer.parseInt(request.getParameter("culpritId_edit"));
            String identity = request.getParameter("identity_card");
            String name = request.getParameter("name");
            String birth = request.getParameter("birth");
            String image = request.getParameter("image");
            //Validation
            Validation.validateEmpty(name);
            Validation.validateCannotClick(name);
            Validation.validateCannotClick(image);
            Validation.validateString(identity);
            Validation.validateNumber(birth, 1000, 3000);
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                culpritDao.setConnect(db.getConnection());
                culpritSelected = culpritDao.getCulpritByID(culpritId);
                culpritSelected.setIdentity_card(identity);
                culpritSelected.setName(name);
                culpritSelected.setBirth(birth);
                culpritSelected.setImage(image);
                culpritDao.updateCulpritByID(culpritSelected);
                //Update List
                culpritList = culpritDao.getListCulprits();
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
        url = "tables";
        return "redirect";
    }

    public String editCulpritImage() {
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
            CulpritDao culpritDao = new CulpritDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            int culpritId = Integer.parseInt(request.getParameter("culpritId_edit_image"));
            String image = request.getParameter("image");
            //Validation
            Validation.validateCannotClick(image);
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                culpritDao.setConnect(db.getConnection());
                culpritSelected = culpritDao.getCulpritByID(culpritId);
                culpritSelected.setImage(image);
                culpritDao.updateCulpritByID(culpritSelected);
                //Update List
                culpritList = culpritDao.getListCulprits();
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
        url = "culprit";
        return "redirect";
    }

    public String editCulpritMore() {
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
            CulpritDao culpritDao = new CulpritDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            int culpritId = Integer.parseInt(request.getParameter("culpritId_edit_more"));
            String identity = request.getParameter("identity_card");
            String name = request.getParameter("name");
            String birth = request.getParameter("birth");
            String create = request.getParameter("create_at");
            //Validation
            Validation.validateEmpty(name);
            Validation.validateCannotClick(name);
            Validation.validateString(identity);
            Validation.validateNumber(birth, 1000, 3000);
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                culpritDao.setConnect(db.getConnection());
                culpritSelected = culpritDao.getCulpritByID(culpritId);
                culpritSelected.setIdentity_card(identity);
                culpritSelected.setName(name);
                culpritSelected.setBirth(birth);
                culpritSelected.setCreate_at(create);
                culpritDao.updateCulpritByID(culpritSelected);
                //Update List
                culpritList = culpritDao.getListCulprits();
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
        url = "culprit";
        return "redirect";
    }

    public String addCulpritCase() {
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
            CulpritDao culpritDao = new CulpritDao();
            Case_CulpritDao caseCulpritDao = new Case_CulpritDao();
            CaseDao caseDao = new CaseDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            int id = Integer.parseInt(request.getParameter("culpritId_add_case"));
            int caseId = Integer.parseInt(request.getParameter("id_case"));
            //Validation
            Validation.validateCaseExited_ForThisCulprit(caseId, culpritCaseList);
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                culpritDao.setConnect(db.getConnection());
                caseCulpritDao.setConnect(db.getConnection());
                caseDao.setConnect(db.getConnection());
                caseCulpritDao.addCaseCulprit(new Case_Culprit(id, caseId));
                //Update
                culpritSelected = culpritDao.getCulpritByID(id);
                ArrayList<Case_Culprit> a = caseCulpritDao.getCase_CulpritByID_Culprit(id);
                culpritCaseList = caseDao.getCase_ByCulpritID(id, a);
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
        url = "culprit";
        return "redirect";
    }

    public String deleteCulpritCase() {
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
            Case_CulpritDao caseCulpritDao = new Case_CulpritDao();
            CaseDao caseDao = new CaseDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            int caseId = Integer.parseInt(request.getParameter("caseId_delete"));
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                caseDao.setConnect(db.getConnection());
                caseCulpritDao.setConnect(db.getConnection());
                caseCulpritDao.deleteByCaseID(caseId);
                //Update
                ArrayList<Case_Culprit> a = caseCulpritDao.getCase_CulpritByID_Culprit(culpritSelected.getId_culprit());
                culpritCaseList = caseDao.getCase_ByCulpritID(culpritSelected.getId_culprit(), a);
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
        url = "culprit";
        return "redirect";
    }

    public String deleteCulprit() {
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
            CulpritDao culpritDao = new CulpritDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                culpritDao.setConnect(db.getConnection());
                culpritDao.deleteCulpritByID(Integer.parseInt(request.getParameter("culpritId_delete")));
                //Update list
                culpritList = culpritDao.getListCulprits();
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
        url = "tables";
        return "redirect";
    }

    public String addCulprit() {
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
            CulpritDao culpritDao = new CulpritDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            String identity = request.getParameter("identity_card");
            String name = request.getParameter("name");
            String birth = request.getParameter("birth");
            String image = request.getParameter("image");
            if (image.equals("")) {
                image = "https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png";
            }
            //Validation
            Validation.validateEmpty(name);
            Validation.validateCannotClick(name);
            Validation.validateCannotClick(image);
            Validation.validateString(identity);
            Validation.validateNumber(birth, 1000, 3000);
            Validation.validateCulpritIndentity(identity, culpritList);
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                culpritDao.setConnect(db.getConnection());
                culpritSelected = new Culprit();
                culpritSelected.setIdentity_card(identity);
                culpritSelected.setName(name);
                culpritSelected.setBirth(birth);
                culpritSelected.setImage(image);
                culpritDao.addCulprit(culpritSelected);
                //Update list
                culpritList = culpritDao.getListCulprits();
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
        url = "tables";
        return "redirect";
    }

    @Override
    public void setSession(Map<String, Object> map) {
        session = map;
    }
}
