package app.models;

import java.io.Serializable;

public class Culprit implements Serializable {

    private static final long serialVersionUID = 1L;
    private int id_culprit;
    private String identity_card;
    private String name;
    private String birth;
    private String image;
    private String create_at;

    public Culprit() {
    }

    public Culprit(String identity_card, String name, String birth, String image) {
        this.identity_card = identity_card;
        this.name = name;
        this.birth = birth;
        this.image = image;
    }

    public Culprit(int id_culprit, String identity_card, String name, String birth, String image, String create_at) {
        this.id_culprit = id_culprit;
        this.identity_card = identity_card;
        this.name = name;
        this.birth = birth;
        this.image = image;
        this.create_at = app.controllers.Validation.DateSqltoDateJs(create_at);
    }

    public int getId_culprit() {
        return id_culprit;
    }

    public void setId_culprit(int id_culprit) {
        this.id_culprit = id_culprit;
    }

    public String getIdentity_card() {
        return identity_card;
    }

    public void setIdentity_card(String identity_card) {
        this.identity_card = identity_card;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCreate_at() {
        return create_at;
    }

    public void setCreate_at(String create_at) {
        this.create_at = create_at;
    }

    @Override
    public String toString() {
        return "Culprit [id_culprit=" + id_culprit + ", identity_card=" + identity_card + ", name=" + name + ", birth="
                + birth + ", image=" + image + ", create_at=" + create_at + "]";
    }

}
