package com.pickmeup.jobstartup.resume.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class ImageConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler( "/image/resume/**")
                .addResourceLocations("file:///C:/jobStartUp_fileUpload/profile_img/")
                .addResourceLocations("file:///C:/jobStartUp_fileUpload/resumeFile/");

    }
}
