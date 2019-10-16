package zoopeter.module.library.cli;

import java.io.File;


import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;

import org.springframework.web.multipart.MultipartFile;

public class Fileupdown {

	public FileupdownVar FileUploadSave( String currentProfile, String partbase, MultipartFile file ) {
		try {
			if( file.getBytes().length == 0 ) return null;
			if( "".equals( file.getOriginalFilename() ) ) return null;
		} catch (IOException e) {}
		
		FileupdownVar ret_var = new FileupdownVar();
		
		String uploadbase = getBasepath( currentProfile );

	    File basedir = new File( uploadbase );
        if( !basedir.isDirectory() ) {
        	basedir.mkdirs();
        }
        
        String partcheck = uploadbase + "/" + partbase;
	    File basedir2 = new File( partcheck );
        if( !basedir2.isDirectory() ) {
        	basedir2.mkdirs();
        }
        
	    try {
	        //just temporary save file info into ufile
	        System.out.println("file length : " + file.getBytes().length);
	        System.out.println("file name : " + file.getOriginalFilename());
	        
	        String today = new SimpleDateFormat("yyyyMMdd").format(System.currentTimeMillis());
	        String todaytime = new SimpleDateFormat("yyyyMMddHHmmss").format(System.currentTimeMillis());
	        File dir = new File( uploadbase + "/" + partbase + "/" + today );
	        if( !dir.isDirectory() ) {
	        	dir.mkdirs();
	        }
	        
	        String savefilename = uploadbase + "/" + partbase + "/" + today + "/" + todaytime + "_" + file.getOriginalFilename();
	        String savefilepath = partbase + "/" + today + "/" + todaytime + "_" + file.getOriginalFilename();
	        
	        InputStream inputStream = null; 
	        OutputStream outputStream = null;
	        try { 
	            inputStream = file.getInputStream(); 
	            File newFile = new File( savefilename ); 
	            if (!newFile.exists()) { 
	                newFile.createNewFile(); 
	            } 
	            outputStream = new FileOutputStream(newFile); 
	            int read = 0; 
	            byte[] bytes = new byte[1024]; 
	            while ((read = inputStream.read(bytes)) != -1) { 
	                outputStream.write(bytes, 0, read); 
	            } 
	        } catch (IOException e) { 
	            e.printStackTrace(); 
	        } finally {
	            try {
	                inputStream.close();
	                outputStream.close();
	                ret_var.savefilepath = savefilepath;
	                ret_var.savefilename = file.getOriginalFilename();
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }
	        
	    } catch (IOException e) {
	        System.out.println(e.getMessage());
	        e.printStackTrace();
	    }
	    return ret_var;
	} 
	
	public static String getBasepath( String currentProfile ) {
		String uploadbase = "";
		if( "local".equals( currentProfile ) ) { 
			uploadbase = "C:/uploadfolder";
		}
		else { 
			uploadbase = "/uploadfolder";
		}
				
		return uploadbase;
	}

}
