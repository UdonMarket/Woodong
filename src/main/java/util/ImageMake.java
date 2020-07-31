package util;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;


public class ImageMake {

	public static void main(String[] args) {
		try {
			
			 BufferedImage image1 = ImageIO.read(new File("c:\\02Utils\\image1.jpg"));
			 BufferedImage image2 = ImageIO.read(new File("c:\\02Utils\\image2.jpg"));
			 BufferedImage image3 = ImageIO.read(new File("c:\\02Utils\\image3.jpg"));
			 BufferedImage image4 = ImageIO.read(new File("c:\\02Utils\\image4.jpg"));
			 BufferedImage image5 = ImageIO.read(new File("c:\\02Utils\\image5.jpg"));
			 BufferedImage image6 = ImageIO.read(new File("c:\\02Utils\\image6.jpg"));
			 BufferedImage image7 = ImageIO.read(new File("c:\\02Utils\\image7.jpg"));
			 BufferedImage image8 = ImageIO.read(new File("c:\\02Utils\\image8.jpg"));
			
	        Image resizeImage1 = image1.getScaledInstance(550, 550, Image.SCALE_SMOOTH);
	        Image resizeImage2 = image2.getScaledInstance(550, 550, Image.SCALE_SMOOTH);
	        Image resizeImage3 = image3.getScaledInstance(550, 550, Image.SCALE_SMOOTH);
	        Image resizeImage4 = image4.getScaledInstance(550, 550, Image.SCALE_SMOOTH);
	        Image resizeImage5 = image5.getScaledInstance(550, 550, Image.SCALE_SMOOTH);
	        Image resizeImage6 = image6.getScaledInstance(550, 550, Image.SCALE_SMOOTH);
	        Image resizeImage7 = image7.getScaledInstance(550, 550, Image.SCALE_SMOOTH);
	        Image resizeImage8 = image8.getScaledInstance(550, 550, Image.SCALE_SMOOTH);

			//System.out.println("getHeight "+resizeImage1.getHeight(null)+" "+"getWidth "+resizeImage1.getWidth(null));
			
			int width = 550*8;
			int height = 550;
			
			BufferedImage mergedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			Graphics2D graphics = (Graphics2D) mergedImage.getGraphics();

			graphics.setBackground(Color.WHITE);
			graphics.drawImage(resizeImage1, 0, 0, null);
			graphics.drawImage(resizeImage2, 550, 0, null);
			graphics.drawImage(resizeImage3, 550*2, 0, null);
			graphics.drawImage(resizeImage4, 550*3, 0, null);
			graphics.drawImage(resizeImage5, 550*4, 0, null);
			graphics.drawImage(resizeImage6, 550*5, 0, null);
			graphics.drawImage(resizeImage7, 550*6, 0, null);
			graphics.drawImage(resizeImage8, 550*7, 0, null);
			graphics.dispose();
			
			ImageIO.write(mergedImage, "jpg", new File("c:\\02Utils\\mergedImage3.jpg"));
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}

		System.out.println("이미지 합성이 완료되었습니다... 에헤라 디야~~");
	}
}
