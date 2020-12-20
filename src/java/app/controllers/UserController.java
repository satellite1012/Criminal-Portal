package app.controllers;

import app.dao.DatabaseIO;
import app.dao.HistoryDao;
import app.dao.UserDao;
import app.models.User;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import static java.lang.System.currentTimeMillis;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

public class UserController extends ActionSupport implements SessionAware {

    private static final long serialVersionUID = 1L;
    public static ArrayList<User> userList = null;
    public static User userSelected = null;
    private Map<String, Object> session;
    private String log = null;
    private String url = null;
    public String user;//FRONT-END (User=UserName=Email)
    public String pass;//FRONT-END
    public String gmail_user;//FRONT-END
    public String gmail_avatar;//FRONT-END
    public String gmail_name;//FRONT-END
    public String gmail_token;//FRONT-END

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
            UserDao userDao = new UserDao();
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            userDao.setConnect(db.getConnection());
            if (userList == null) {
                try {
                    userList = userDao.getListUsers();
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

    public User validateUser(String user, String pass) throws Exception {
        if (user.equals("guest") && pass.equals("guest")) {
            throw new Exception("This is the guest account");
        }
        UserDao userDao = new UserDao();
        DatabaseIO db = new DatabaseIO();
        db.openConnectionCloud();
        userDao.setConnect(db.getConnection());
        try {
            ArrayList<User> a = userDao.getListUsers();
            for (User i : a) {
                if (user.equals(i.getUsername()) && pass.equals(i.getPassword())) {
                    return i;
                }
            }
            db.closeConnection();
        } catch (SQLException e) {
            db.closeConnection();
        }
        return null;
    }

    public String login() {
        try {
            //Validation
            User s = validateUser(user, pass);
            if (s == null) {
                throw new Exception("Username or pass is incorrect");
            }
            //View
            session.put("user", s);
            url = "index";
            return "redirect";
        } catch (Exception e) {
            log = e.toString().replaceFirst("java.lang.Exception:", "");
            return "failure";
        }
    }

    public String logout() {
        try {
            SessionMap map = (SessionMap) ActionContext.getContext().getSession();
            map.invalidate();
            HistoryController.historyList = null;
            UserController.userList = null;
            url = "index";
            return "redirect";
        } catch (Exception e) {
            log = "Details: " + e.toString();
            return "failure";
        }
    }

    public void validationEmailToken(String clientEmail, String clientToken) throws Exception {
        if (clientEmail.isEmpty()) {
            throw new Exception("Empty Email");
        }
        if (!clientEmail.contains("@fpt.edu.vn")) {
            throw new Exception("You only can using FPT email to login");
        }
        HttpTransport transport = new NetHttpTransport();
        JsonFactory jsonFactory = new JacksonFactory();
        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
                .setAudience(Collections.singletonList("888567468389-5h2gfmlvp5blgria6dnauldlbniloaio.apps.googleusercontent.com"))
                .build();

        // Validate by token
        GoogleIdToken idToken = verifier.verify(clientToken);
        if (idToken == null) {
            throw new Exception("Invalidate token");
        } else {
            Payload payload = idToken.getPayload();
            String email = payload.getEmail();
            if (!email.equals(clientEmail)) {
                throw new Exception("Token not accept");
            }
        }
    }

    public String randomPass() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        return RandomStringUtils.random(8, characters);
    }

    public String loginGmail() {
        try {
            //Validation
            validationEmailToken(gmail_user, gmail_token);
            //Excute
            UserDao userDao = new UserDao();
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            userDao.setConnect(db.getConnection());
            try {
                User s = userDao.findUserByUsername(gmail_user);
                if (s == null) {
                    s = new User(gmail_user, randomPass(), gmail_avatar, gmail_user, "Bạn đang sử dụng tài khoản của trường đại học FPT", gmail_name, 2);
                    userDao.addUser(s);
                    s = userDao.findUserByUsername(gmail_user);
                }
                session.put("user", s);
                //Update
                userList = userDao.getListUsers();
                db.closeConnection();
            } catch (SQLException e) {
                db.closeConnection();
            }
            //View
            url = "index";
            return "redirect";
        } catch (Exception e) {
            log = e.toString().replaceFirst("java.lang.Exception:", "");
            return "failure";
        }
    }

    public String getUserAtId() {
        try {
            //Excute
            UserDao userDao = new UserDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            userDao.setConnect(db.getConnection());
            try {
                userSelected = userDao.getUserByID(Integer.parseInt(request.getParameter("userId_show")));
                db.closeConnection();
            } catch (SQLException e) {
                db.closeConnection();
            }
        } catch (Exception e) {
            log = e.toString();
            return "failure";
        }
        //View
        return "success";
    }

    public String editUser() {
        long a = currentTimeMillis();
        try {
            //Validation User
            User temp = (User) session.get("user");
            if (temp == null) {
                throw new Exception("Not login");
            }
            if (temp.getRole() > 0) {
                throw new Exception("Role not accepted");
            }
            //Init
            UserDao userDao = new UserDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            int userId = Integer.parseInt(request.getParameter("userId_edit"));
            String password = request.getParameter("password");
            int role = Integer.parseInt(request.getParameter("role"));
            String avatar = request.getParameter("avatar");
            String fullname = request.getParameter("full_name");
            //Validation
            Validation.validateEmpty(fullname);
            Validation.validateCannotClick(avatar);
            Validation.validateCannotClick(fullname);
            Validation.validateString(password);
            Validation.validateNumberRange(role, 0, 2);
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            userDao.setConnect(db.getConnection());
            try {
                userSelected = userDao.getUserByID(userId);
                userSelected.setPassword(password);
                userSelected.setRole(role);
                userSelected.setAvatar(avatar);
                userSelected.setFull_name(fullname);
                userDao.updateUserByID(userSelected);
                //Update
                if (temp.getId_user() == userId) {
                    session.replace("user", userSelected);
                }
                userList = userDao.getListUsers();
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
        url = "user";
        return "redirect";
    }

    public String editUserMore() {
        try {
            //Validation User
            User temp = (User) session.get("user");
            if (temp == null) {
                throw new Exception("Not login");
            }
            //Init
            UserDao userDao = new UserDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            int userId = Integer.parseInt(request.getParameter("userId_edit"));
            String password = request.getParameter("password");
            String avatar = request.getParameter("avatar");
            String fullname = request.getParameter("full_name");
            //Validation
            Validation.validateEmpty(fullname);
            Validation.validateCannotClick(avatar);
            Validation.validateCannotClick(fullname);
            Validation.validateString(password);
            if (temp.getRole() > 0 && temp.getId_user() != userId) {
                throw new Exception("Role not accepted");
            }
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                userDao.setConnect(db.getConnection());
                userSelected = userDao.getUserByID(userId);
                userSelected.setPassword(password);
                userSelected.setAvatar(avatar);
                userSelected.setFull_name(fullname);

                userDao.updateUserByID(userSelected);
                //Update
                if (temp.getId_user() == userId) {
                    url = "localProfile";
                    session.replace("user", userSelected);
                } else {
                    url = "globalProfile";
                }
                userList = userDao.getListUsers();
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
            HttpServletRequest request = ServletActionContext.getRequest();
            int userId = Integer.parseInt(request.getParameter("userId_edit"));
            User temp = (User) session.get("user");
            if (temp.getId_user() == userId) {
                url = "localProfile.jsp";
            } else {
                url = "globalProfile.jsp";
            }
            log = e.toString().replaceFirst("java.lang.Exception:", "");
            return "failure";
        }
        //View

        return "redirect";
    }

    public String editUserTitle() {
        try {
            //Validation User
            User temp = (User) session.get("user");
            if (temp == null) {
                throw new Exception("Not login");
            }
            //Init
            UserDao userDao = new UserDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            int userId = Integer.parseInt(request.getParameter("userId_edit"));
            String title = request.getParameter("profile_title");
            System.out.println(userId + " | " + title);
            //Validation
            Validation.validateEmpty(title);
            Validation.validateCannotClick(title);
            if (temp.getRole() > 0 && temp.getId_user() != userId) {
                throw new Exception("Role not accepted");
            }
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                userDao.setConnect(db.getConnection());
                userSelected = userDao.getUserByID(userId);
                userSelected.setProfile_title(title);
                userDao.updateUserByID(userSelected);
                //Update
                if (temp.getId_user() == userId) {
                    url = "localProfile";
                    session.replace("user", userSelected);
                } else {
                    url = "globalProfile";
                }
                userList = userDao.getListUsers();
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
            HttpServletRequest request = ServletActionContext.getRequest();
            int userId = Integer.parseInt(request.getParameter("userId_edit"));
            User temp = (User) session.get("user");
            if (temp.getId_user() == userId) {
                url = "localProfile.jsp";
            } else {
                url = "globalProfile.jsp";
            }
            log = e.toString().replaceFirst("java.lang.Exception:", "");
            return "failure";
        }
        //View
        return "redirect";
    }

    public String editUserDescription() {
        try {
            //Validation User
            User temp = (User) session.get("user");
            if (temp == null) {
                throw new Exception("Not login");
            }
            if (temp.getRole() > 0) {
                throw new Exception("Role not accepted");
            }
            //Init
            UserDao userDao = new UserDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            int userId = Integer.parseInt(request.getParameter("userId_edit"));
            String des = request.getParameter("profile_description");
            //Validation
            Validation.validateEmpty(des);
            Validation.validateCannotClick(des);
            if (temp.getRole() > 0 && temp.getId_user() != userId) {
                throw new Exception("Role not accepted");
            }
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                userDao.setConnect(db.getConnection());
                userSelected = userDao.getUserByID(userId);
                userSelected.setProfile_description(des);
                userDao.updateUserByID(userSelected);
                //Update
                if (temp.getId_user() == userId) {
                    url = "localProfile";
                    session.replace("user", userSelected);
                } else {
                    url = "globalProfile";
                }
                userList = userDao.getListUsers();
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
            HttpServletRequest request = ServletActionContext.getRequest();
            int userId = Integer.parseInt(request.getParameter("userId_edit"));
            User temp = (User) session.get("user");
            if (temp.getId_user() == userId) {
                url = "localProfile.jsp";
            } else {
                url = "globalProfile.jsp";
            }
            log = e.toString().replaceFirst("java.lang.Exception:", "");
            return "failure";
        }
        //View
        return "redirect";
    }

    public String deleteUser() {
        try {
            //Validation User
            User temp = (User) session.get("user");
            if (temp == null) {
                throw new Exception("Not login");
            }
            if (temp.getRole() > 0) {
                throw new Exception("Role not accepted");
            }
            //Init
            UserDao userDao = new UserDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            int userId = Integer.parseInt(request.getParameter("userId_delete"));
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                userDao.setConnect(db.getConnection());
                userDao.deleteUserByID(userId);
                //Update
                if (temp.getId_user() == userId) {
                    logout();
                }
                userList = userDao.getListUsers();
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
        url = "user";
        return "redirect";
    }

    public String addUser() {
        try {
            //Validation User
            User temp = (User) session.get("user");
            if (temp == null) {
                throw new Exception("Not login");
            }
            if (temp.getRole() > 0) {
                throw new Exception("Role not accepted");
            }
            //Init
            UserDao userDao = new UserDao();
            HttpServletRequest request = ServletActionContext.getRequest();
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            int role = Integer.parseInt(request.getParameter("role"));
            String avatar = request.getParameter("avatar");
            String fullname = request.getParameter("full_name");
            if (avatar.equals("")) {
                avatar = "https://cdn.vietnambiz.vn/2020/3/23/8982723811481067122020783325787206735364096o-1584933586721423227199.jpg";
            }
            //Validation
            Validation.validateEmpty(fullname);
            Validation.validateCannotClick(avatar);
            Validation.validateCannotClick(fullname);
            Validation.validateString(username);
            Validation.validateString(password);
            Validation.validateUsernameExited(username, userList);
            Validation.validateNumberRange(role, 0, 2);
            //Excute
            DatabaseIO db = new DatabaseIO();
            db.openConnectionCloud();
            try {
                userDao.setConnect(db.getConnection());
                userSelected = new User();
                userSelected.setUsername(username);
                userSelected.setPassword(password);
                userSelected.setRole(role);
                userSelected.setFull_name(fullname);
                userSelected.setAvatar(avatar);
                userDao.addUser(userSelected);
                //Update
                userList = userDao.getListUsers();
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
        url = "user";
        return "redirect";
    }

    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

}
