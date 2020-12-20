package app.controllers;

import app.dao.DatabaseIO;
import app.dao.HistoryDao;
import app.models.HistoryModified;
import app.models.User;
import com.opensymphony.xwork2.ActionSupport;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

public class HistoryController extends ActionSupport implements SessionAware {

    public static ArrayList<HistoryModified> historyList = null;
    private String log = null;
    private String url = null;
    private int historyId_delete;//FRONT-END

    public int getHistoryId_delete() {
        return historyId_delete;
    }

    public void setHistoryId_delete(int historyId_delete) {
        this.historyId_delete = historyId_delete;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
    private Map<String, Object> session;

    public String getLog() {
        return log;
    }

    public void setLog(String log) {
        this.log = log;
    }

    public String getAll() {
        try {
            //Excute
            HistoryDao historyDao = new HistoryDao();
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            historyDao.setConnect(db.getConnection());
            if (historyList == null) {
                try {
                    historyList = historyDao.getListHistoryModifieds();
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

    public String deleteAllHistory() {
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
            HistoryDao historyDao = new HistoryDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            String passForDelete = request.getParameter("passForDelete");
            //Validation
            if (!passForDelete.equals("satellite1012")) {
                throw new Exception("Mật khẩu cấp 2 không chính xác");
            }
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                historyDao.setConnect(db.getConnection());
                historyDao.deleteAllHistory();
                //Update list
                historyList = historyDao.getListHistoryModifieds();
                db.closeConnection();
            } catch (SQLException e) {
                db.closeConnection();
            }
        } catch (Exception e) {
            log = e.toString().replaceFirst("java.lang.Exception:", "");
            return "failure";
        }
        //View
        url = "history";
        return "redirect";
    }

    public String deleteHistory() {
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
            HistoryDao historyDao = new HistoryDao();
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                historyDao.setConnect(db.getConnection());
                historyDao.deleteHistoryByID(historyId_delete);
                //Update list
                historyList = historyDao.getListHistoryModifieds();
                db.closeConnection();
            } catch (SQLException e) {
                db.closeConnection();
            }
        } catch (Exception e) {
            log = e.toString();
            return "failure";
        }
        //View
        url = "history";
        return "redirect";
    }

    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
}
