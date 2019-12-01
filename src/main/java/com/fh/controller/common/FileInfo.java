package com.fh.controller.common;

import java.io.InputStream;
import java.io.Serializable;

public class FileInfo implements Serializable {
    private static final long serialVersionUID = -6487596168243534410L;
    private InputStream inputStream;
    private String originalFilename;
    private long size;

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public String getOriginalFilename() {
        return originalFilename;
    }

    public void setOriginalFilename(String originalFilename) {
        this.originalFilename = originalFilename;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }
}
