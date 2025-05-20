package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender mailSender;

    public void sendVerificationEmail(String to, String content) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject("Milk Tea Shop - Xác thực tài khoản bằng mã OTP");
        String body = "Xin chào quý khách,\n\n" +
                "Cảm ơn bạn đã đăng ký tài khoản tại hệ thống Milk Tea Shop!\n" +
                "\n" +
                "Để hoàn tất quá trình đăng ký và đảm bảo an toàn cho tài khoản, vui lòng thực hiện bước xác thực dưới đây:\n" +
                content +
                "\n\n" +
                "Lưu ý quan trọng:\n" +
                "- Mã xác thực/OTP chỉ có hiệu lực trong một thời gian ngắn.\n" +
                "- Tuyệt đối không chia sẻ mã này cho bất kỳ ai, kể cả nhân viên Milk Tea Shop.\n" +
                "- Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email này để đảm bảo an toàn thông tin cá nhân.\n" +
                "\n" +
                "Nếu có bất kỳ thắc mắc hoặc cần hỗ trợ, hãy liên hệ với chúng tôi qua email: trankiencuong30072003@gmail.com hoặc số điện thọai: 0369702376.\n" +
                "\n" +
                "Trân trọng,\n" +
                "Trần Kiên Cường";
        message.setText(body);
        mailSender.send(message);
    }
} 