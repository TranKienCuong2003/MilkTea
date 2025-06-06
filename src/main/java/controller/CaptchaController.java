package controller;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CaptchaController {

    
    @GetMapping("/captcha")
    public void getCaptcha(HttpSession session, HttpServletResponse response) throws IOException {
        int width = 120;
        int height = 40;
        int codeLength = 5;
        String captchaChars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        Random random = new Random();
        StringBuilder captchaStr = new StringBuilder();

        for (int i = 0; i < codeLength; i++) {
            captchaStr.append(captchaChars.charAt(random.nextInt(captchaChars.length())));
        }

        String captcha = captchaStr.toString();

        session.setAttribute("captcha", captcha);

        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = image.createGraphics();
        g2d.setColor(Color.WHITE);
        g2d.fillRect(0, 0, width, height);

        g2d.setFont(new Font("Arial", Font.BOLD, 28));
        g2d.setColor(new Color(0, 102, 204));
        g2d.drawString(captcha, 18, 30);

        g2d.setColor(new Color(180, 180, 180));
        for (int i = 0; i < 10; i++) {
            int x1 = random.nextInt(width);
            int y1 = random.nextInt(height);
            int x2 = random.nextInt(width);
            int y2 = random.nextInt(height);
            g2d.drawLine(x1, y1, x2, y2);
        }

        g2d.dispose();

        response.setContentType("image/png");
        ServletOutputStream out = response.getOutputStream();

        ImageIO.write(image, "png", out);
        out.close(); // Đóng luồng
    }
}
