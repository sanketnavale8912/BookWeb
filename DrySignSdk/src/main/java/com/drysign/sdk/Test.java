package com.drysign.sdk;


import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.net.URL;

public class Test {
    public static void main(String[] args) {
        try {
            URL url = new URL("http://10.182.104.63:8080/DrySign2/download/internal?fileName=fd1bdea0-6ac0-45a6-8a51-864ef06a6bbaagreement.pdf");
            File destination = new File("D:/abc.pdf");

            //
            // Copy bytes from the URL to the destination file.
            //
            FileUtils.copyURLToFile(url, destination);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}