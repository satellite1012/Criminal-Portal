package app.controllers;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;

public class HomeController extends ActionSupport {

    private String log = null;

    public String getLog() {
        return log;
    }

    public void setLog(String log) {
        this.log = log;
    }

    @Override
    public String execute() throws Exception {
        return "success";
    }

    public String loadContentFirst() {
        if (BlogController.caseList == null) {
            BlogController blogController = new BlogController();
            if (!blogController.getAll().equals("success")) {
                log = blogController.getLog();
                return "failure";
            }
        }
        if (CulpritController.culpritList == null) {
            CulpritController culpritController = new CulpritController();
            if (!culpritController.getAll().equals("success")) {
                log = culpritController.getLog();
                return "failure";
            }
        }
        if (UserController.userList == null) {
            UserController userController = new UserController();
            if (!userController.getAll().equals("success")) {
                log = userController.getLog();
                return "failure";
            }
        }
        return "success";
    }

    public String loadHistory() {
        HistoryController historyController = new HistoryController();
        if (!historyController.getAll().equals("success")) {
            log = historyController.getLog();
            return "failure";
        }
        return "success";
    }
}
