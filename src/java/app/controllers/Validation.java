package app.controllers;
//Author: Doan Duc Tin

import app.dao.CulpritDao;
import app.dao.UserDao;
import app.models.Case;
import app.models.Culprit;
import app.models.User;
import java.util.ArrayList;

public class Validation {

    public static String DateSqltoDateJs(String s) {
        if (s != null) {
            s = s.replaceAll(" ", "T");
        }
        return s;
    }

    public static String DateJstoDateSql(String s) {
        if (s != null) {
            s = s.replaceAll("T", " ");
        }
        return s;
    }

    public static boolean validateString(String a) throws Exception {
        if (a == null || a.equals("")) {
            throw new Exception("Không được để trống các trường");
        }
        if (!a.matches("[A-Za-z0-9@._-]+")) {
            throw new Exception("Không được nhập ký tự đặc biệt: " + a);
        }
        return true;
    }

    public static boolean validateEmpty(String a) throws Exception{
        if (a == null || a.equals("") || a.isEmpty()) {
            throw new Exception("Không được để trống các trường");
        }
        return true;
    }

    public static boolean validateNumber(String a, int min, int max) throws Exception {
        if (!a.matches("[0-9]+")) {
            throw new Exception("Chỉ được nhập số");
        }
        int temp = Integer.parseInt(a);
        if (temp < min || temp > max) {
            throw new Exception("Bạn đã nhập số quá lớn hoặc quá nhỏ so với giới hạn [" + min + " - " + max + "]");
        }
        return true;
    }

    public static boolean validateCannotClick(String s) throws Exception {
        if (s.contains("<") || s.contains(">") || s.contains("\"") || s.contains("\'") || s.contains("`")) {
            throw new Exception("Bạn không được nhập các ký tự [\",\"]|[\',\']|[<,>]");
        }
        return true;
    }

    public static boolean validateNumberRange(int a, int min, int max) throws Exception {
        if (a < min || a > max) {
            throw new Exception("Bạn đã nhập số quá lớn hoặc quá nhỏ so với giới hạn [" + min + " - " + max + "]");
        }
        return true;
    }

    public static boolean validateCaseIdExited(int caseId, ArrayList<Case> list) throws Exception {
        for (Case i : list) {
            if (caseId == i.getId_case()) {
                return true;
            }
        }
        throw new Exception("Vụ án có Id = " + caseId + " không tìm thấy, vui lòng kiểm tra lại");
    }

    public static boolean validateCaseExited_ForThisCulprit(int caseId, ArrayList<Case> a) throws Exception {
        for (Case i : a) {
            if (caseId == i.getId_case()) {
                throw new Exception("Vụ án có Id = " + caseId + " đã có cho tội phạm này, vui lòng nhập id vụ án khác");
            }
        }
        return true;
    }

    public static boolean validateCulpritIndentity(String id, ArrayList<Culprit> a) throws Exception {
        for (Culprit i : a) {
            if (id.equals(i.getIdentity_card())) {
                throw new Exception("CMND \"" + id + "\" đã tồn tại trong danh sách tội phạm, vui lòng nhập một CMND mới");
            }
        }
        return true;
    }

    public static boolean validateUsernameExited(String s, ArrayList<User> a) throws Exception {
        for (User i : a) {
            if (s.equals(i.getUsername())) {
                throw new Exception("Usename \"" + s + "\" đã tồn tại, vui lòng thử một tên đăng nhập khác");
            }
        }
        return true;
    }
}
