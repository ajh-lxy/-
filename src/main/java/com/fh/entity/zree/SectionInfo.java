package com.fh.entity.zree;

import java.io.Serializable;

public class SectionInfo implements Serializable {

    private static final long serialVersionUID = -983993989486222078L;
    private String id;
    private String pId;
    private String name;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getpId() {
        return pId;
    }

    public void setpId(String pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
