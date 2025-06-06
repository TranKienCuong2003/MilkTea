package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.IOException;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender mailSender;

    public void sendVerificationEmail(String to, String otp) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        
        helper.setTo(to);
        helper.setSubject("Milk Tea Shop - Xác thực tài khoản");

        String htmlContent = "<!DOCTYPE html>" +
            "<html><head>" +
            "<meta charset='UTF-8'>" +
            "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
            "<style>" +
            "body {background: #f4f8fb; margin:0; padding:0;}" +
            ".container {max-width: 520px; margin: 30px auto; background: #fff; border-radius: 18px; box-shadow:0 4px 24px #0001; padding: 32px 18px 18px 18px;}" +
            ".logo-wrap {text-align:center; margin-bottom: 12px;}" +
            ".logo-img {width: 90px; height: 90px; object-fit: contain; border-radius: 50%; box-shadow:0 2px 12px #007bff33; border: 4px solid #fff; background: #fff; display: block; margin: 0 auto;}" +
            ".slogan {text-align:center; color:#007bff; font-size: 20px; font-weight:600; margin-bottom: 6px;}" +
            ".intro {text-align:center; color:#444; font-size:15px; margin-bottom: 18px;}" +
            ".desc {color:#333; font-size:15px; margin: 18px 0 18px 0; line-height:1.7;}" +
            ".otp-box {background: #eaf4ff; border: 2px solid #007bff; border-radius: 10px; padding: 22px 0; margin: 24px 0 18px 0; text-align:center; box-shadow:0 2px 8px #007bff11;}" +
            ".otp-label {font-size: 15px; color: #007bff; margin-bottom: 8px;}" +
            ".otp-code {font-size: 38px; font-weight: bold; color: #007bff; letter-spacing: 8px; background: #fff; padding: 8px 24px; border-radius: 8px; display: inline-block; border: 1.5px dashed #007bff;}" +
            ".note {background: #fffbe6; border-left: 4px solid #ffc107; padding: 12px 16px; border-radius: 6px; color: #856404; margin-bottom: 18px; font-size: 14px;}" +
            ".footer {margin-top: 32px; padding-top: 18px; border-top: 1px solid #e0e0e0; text-align:center; font-size: 13px; color: #888;}" +
            ".footer .contact {margin-top: 8px;}" +
            ".footer .icon {width:16px; vertical-align:middle; margin-right:4px;}" +
            "@media (max-width:600px){.container{padding:10px;}.otp-code{font-size:28px;}}" +
            "</style></head><body>" +
            "<div class='container'>" +
            "<div class='logo-wrap'>" +
            "<img src='https://static.vecteezy.com/system/resources/previews/046/790/031/non_2x/milk-tea-illustration-design-free-vector.jpg' alt='Milk Tea Shop Logo' class='logo-img'>" +
            "</div>" +
            "<div class='slogan'>Milk Tea Shop - Hương vị đích thực của trà sữa</div>" +
            "<div class='intro'>Chào mừng bạn đến với cộng đồng yêu trà sữa!<br>Chúng tôi cam kết mang đến trải nghiệm tuyệt vời và an toàn nhất cho khách hàng.</div>" +
            "<div class='desc'>Chúng tôi tự hào mang đến cho bạn những ly trà sữa thơm ngon, nguyên liệu tự nhiên, quy trình kiểm soát chất lượng nghiêm ngặt và dịch vụ tận tâm.<br><br>Đội ngũ Milk Tea Shop luôn lắng nghe ý kiến khách hàng để không ngừng cải tiến sản phẩm, dịch vụ và công nghệ. Sự hài lòng và an toàn của bạn là ưu tiên số 1 của chúng tôi.</div>" +
            "<div class='otp-box'>" +
            "<div class='otp-label'>Mã xác thực (OTP) của bạn:</div>" +
            "<div class='otp-code'>" + otp + "</div>" +
            "</div>" +
            "<div class='note'><b>Lưu ý:</b> Mã OTP chỉ có hiệu lực trong thời gian ngắn. Tuyệt đối không chia sẻ mã này cho bất kỳ ai, kể cả nhân viên Milk Tea Shop.</div>" +
            "<div class='desc'>Nếu bạn cần hỗ trợ hoặc có bất kỳ thắc mắc nào về tài khoản, đơn hàng hoặc dịch vụ, vui lòng liên hệ với chúng tôi qua email hoặc số điện thoại bên dưới. Đội ngũ CSKH của Milk Tea Shop luôn sẵn sàng hỗ trợ bạn 24/7.<br><br>Chúng tôi cam kết bảo mật tuyệt đối thông tin cá nhân và giao dịch của bạn. Mọi yêu cầu xác thực đều được xử lý tự động, không ai có quyền yêu cầu bạn cung cấp mã OTP ngoài hệ thống.</div>" +
            "<div class='note' style='margin-top:18px;background:#f8d7da;color:#721c24;border-left:4px solid #dc3545;'>Nếu bạn không thực hiện yêu cầu này, hãy bỏ qua email này để đảm bảo an toàn thông tin cá nhân.</div>" +
            "<div class='footer'>" +
            "Trân trọng,<br><b>Milk Tea Shop Team</b>" +
            "<div class='contact'>" +
            "<img class='icon' src='https://cdn-icons-png.flaticon.com/512/561/561127.png'/> trankiencuong30072003@gmail.com &nbsp;|&nbsp; " +
            "<img class='icon' src='https://cdn-icons-png.flaticon.com/512/597/597177.png'/> 0369702376" +
            "</div>" +
            "</div>" +
            "</div></body></html>";

        helper.addInline("logoImage", new ClassPathResource("images/milk-tea-logo.png"));
        helper.setText(htmlContent, true);
        mailSender.send(message);
    }

    public void sendRegistrationSuccessEmail(String to) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        helper.setTo(to);
        helper.setSubject("Milk Tea Shop - Xác nhận đăng ký tài khoản thành công");
        String htmlContent = "<!DOCTYPE html>" +
            "<html><head>" +
            "<meta charset='UTF-8'>" +
            "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
            "<style>" +
            "body {background: #f4f8fb; margin:0; padding:0;}" +
            ".container {max-width: 520px; margin: 30px auto; background: #fff; border-radius: 18px; box-shadow:0 4px 24px #0001; padding: 32px 18px 18px 18px;}" +
            ".logo-wrap {text-align:center; margin-bottom: 12px;}" +
            ".logo-img {width: 90px; height: 90px; object-fit: contain; border-radius: 50%; box-shadow:0 2px 12px #007bff33; border: 4px solid #fff; background: #fff; display: block; margin: 0 auto;}" +
            ".slogan {text-align:center; color:#007bff; font-size: 20px; font-weight:600; margin-bottom: 6px;}" +
            ".intro {text-align:center; color:#444; font-size:15px; margin-bottom: 18px;}" +
            ".desc {color:#333; font-size:15px; margin: 18px 0 18px 0; line-height:1.7;}" +
            ".section-title {color:#007bff; font-weight:600; margin-top:24px; margin-bottom:8px; font-size:16px;}" +
            ".footer {margin-top: 32px; padding-top: 18px; border-top: 1px solid #e0e0e0; text-align:center; font-size: 13px; color: #888;}" +
            ".footer .contact {margin-top: 8px;}" +
            ".footer .icon {width:16px; vertical-align:middle; margin-right:4px;}" +
            "@media (max-width:600px){.container{padding:10px;}}" +
            "</style></head><body>" +
            "<div class='container'>" +
            "<div class='logo-wrap'>" +
            "<img src='https://static.vecteezy.com/system/resources/previews/046/790/031/non_2x/milk-tea-illustration-design-free-vector.jpg' alt='Milk Tea Shop Logo' class='logo-img'>" +
            "</div>" +
            "<div class='slogan'>Milk Tea Shop - Hương vị đích thực của trà sữa</div>" +
            "<div class='intro'>Chúc mừng bạn đã đăng ký tài khoản thành công tại hệ thống Milk Tea Shop!</div>" +
            "<div class='desc'>Cảm ơn bạn đã tin tưởng và lựa chọn Milk Tea Shop. Chúng tôi cam kết mang đến cho bạn những trải nghiệm tuyệt vời nhất về sản phẩm và dịch vụ.<br><br>Hãy khám phá các ưu đãi, đặt hàng nhanh chóng và tận hưởng những ly trà sữa thơm ngon cùng cộng đồng yêu trà sữa trên toàn quốc!</div>" +
            "<div class='section-title'>Điều khoản dịch vụ</div>" +
            "<div class='desc'>- Khi sử dụng dịch vụ của Milk Tea Shop, bạn đồng ý tuân thủ các quy định về sử dụng tài khoản, bảo mật thông tin và thanh toán.<br>- Không sử dụng tài khoản cho các mục đích vi phạm pháp luật hoặc gây ảnh hưởng đến hệ thống.<br>- Mọi hành vi gian lận, giả mạo sẽ bị xử lý theo quy định của pháp luật và chính sách của Milk Tea Shop.</div>" +
            "<div class='section-title'>Chính sách bảo mật</div>" +
            "<div class='desc'>- Thông tin cá nhân của bạn được bảo mật tuyệt đối và chỉ sử dụng cho mục đích phục vụ khách hàng.<br>- Chúng tôi không chia sẻ thông tin của bạn cho bên thứ ba khi chưa có sự đồng ý.<br>- Mọi giao dịch đều được mã hóa và bảo vệ bởi hệ thống bảo mật hiện đại.</div>" +
            "<div class='desc'>Nếu bạn cần hỗ trợ hoặc có bất kỳ thắc mắc nào, vui lòng liên hệ với chúng tôi qua email hoặc số điện thoại bên dưới. Đội ngũ CSKH của Milk Tea Shop luôn sẵn sàng hỗ trợ bạn 24/7.</div>" +
            "<div class='footer'>" +
            "Trân trọng,<br><b>Milk Tea Shop Team</b>" +
            "<div class='contact'>" +
            "<img class='icon' src='https://cdn-icons-png.flaticon.com/512/561/561127.png'/> trankiencuong30072003@gmail.com &nbsp;|&nbsp; " +
            "<img class='icon' src='https://cdn-icons-png.flaticon.com/512/597/597177.png'/> 0369702376" +
            "</div>" +
            "</div>" +
            "</div></body></html>";
        helper.setText(htmlContent, true);
        mailSender.send(message);
    }

    public void sendEmailChangeNotification(String oldEmail, String newEmail) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        
        helper.setTo(oldEmail);
        helper.setSubject("Milk Tea Shop - Thông báo thay đổi email");

        String htmlContent = "<!DOCTYPE html>" +
            "<html><head>" +
            "<meta charset='UTF-8'>" +
            "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
            "<style>" +
            "body {background: #f4f8fb; margin:0; padding:0;}" +
            ".container {max-width: 520px; margin: 30px auto; background: #fff; border-radius: 18px; box-shadow:0 4px 24px #0001; padding: 32px 18px 18px 18px;}" +
            ".logo-wrap {text-align:center; margin-bottom: 12px;}" +
            ".logo-img {width: 90px; height: 90px; object-fit: contain; border-radius: 50%; box-shadow:0 2px 12px #007bff33; border: 4px solid #fff; background: #fff; display: block; margin: 0 auto;}" +
            ".slogan {text-align:center; color:#007bff; font-size: 20px; font-weight:600; margin-bottom: 6px;}" +
            ".intro {text-align:center; color:#444; font-size:15px; margin-bottom: 18px;}" +
            ".desc {color:#333; font-size:15px; margin: 18px 0 18px 0; line-height:1.7;}" +
            ".email-box {background: #eaf4ff; border: 2px solid #007bff; border-radius: 10px; padding: 22px; margin: 24px 0 18px 0;}" +
            ".email-label {font-size: 15px; color: #007bff; margin-bottom: 8px;}" +
            ".email-value {font-size: 16px; font-weight: 500; color: #333;}" +
            ".note {background: #fffbe6; border-left: 4px solid #ffc107; padding: 12px 16px; border-radius: 6px; color: #856404; margin-bottom: 18px; font-size: 14px;}" +
            ".warning {background: #f8d7da; border-left: 4px solid #dc3545; padding: 12px 16px; border-radius: 6px; color: #721c24; margin-bottom: 18px; font-size: 14px;}" +
            ".footer {margin-top: 32px; padding-top: 18px; border-top: 1px solid #e0e0e0; text-align:center; font-size: 13px; color: #888;}" +
            ".footer .contact {margin-top: 8px;}" +
            ".footer .icon {width:16px; vertical-align:middle; margin-right:4px;}" +
            "@media (max-width:600px){.container{padding:10px;}}" +
            "</style></head><body>" +
            "<div class='container'>" +
            "<div class='logo-wrap'>" +
            "<img src='https://static.vecteezy.com/system/resources/previews/046/790/031/non_2x/milk-tea-illustration-design-free-vector.jpg' alt='Milk Tea Shop Logo' class='logo-img'>" +
            "</div>" +
            "<div class='slogan'>Milk Tea Shop - Hương vị đích thực của trà sữa</div>" +
            "<div class='intro'>Thông báo thay đổi email tài khoản</div>" +
            "<div class='desc'>Kính gửi Quý khách hàng,<br><br>Chúng tôi nhận được yêu cầu thay đổi email của tài khoản Milk Tea Shop của bạn. Email của bạn đã được thay đổi thành công.</div>" +
            "<div class='email-box'>" +
            "<div class='email-label'>Email cũ:</div>" +
            "<div class='email-value'>" + oldEmail + "</div>" +
            "<div class='email-label' style='margin-top:12px;'>Email mới:</div>" +
            "<div class='email-value'>" + newEmail + "</div>" +
            "</div>" +
            "<div class='warning'>Nếu bạn không thực hiện thay đổi này, vui lòng liên hệ ngay với chúng tôi để được hỗ trợ.</div>" +
            "<div class='desc'>Để đảm bảo an toàn cho tài khoản của bạn, chúng tôi khuyến nghị:<br>" +
            "1. Kiểm tra lại thông tin đăng nhập<br>" +
            "2. Bật xác thực 2 lớp nếu chưa bật<br>" +
            "3. Không chia sẻ thông tin đăng nhập với người khác</div>" +
            "<div class='footer'>" +
            "Trân trọng,<br><b>Milk Tea Shop Team</b>" +
            "<div class='contact'>" +
            "<img class='icon' src='https://cdn-icons-png.flaticon.com/512/561/561127.png'/> trankiencuong30072003@gmail.com &nbsp;|&nbsp; " +
            "<img class='icon' src='https://cdn-icons-png.flaticon.com/512/597/597177.png'/> 0369702376" +
            "</div>" +
            "</div>" +
            "</div></body></html>";

        helper.setText(htmlContent, true);
        mailSender.send(message);
    }

    public void sendChangeEmailOtp(String to, String otp) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        helper.setTo(to);
        helper.setSubject("Milk Tea Shop - Xác thực đổi email tài khoản");

        String htmlContent = "<!DOCTYPE html>" +
            "<html><head>" +
            "<meta charset='UTF-8'>" +
            "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
            "<style>" +
            "body {background: #f4f8fb; margin:0; padding:0;}" +
            ".container {max-width: 520px; margin: 30px auto; background: #fff; border-radius: 18px; box-shadow:0 4px 24px #0001; padding: 32px 18px 18px 18px;}" +
            ".logo-wrap {text-align:center; margin-bottom: 12px;}" +
            ".logo-img {width: 90px; height: 90px; object-fit: contain; border-radius: 50%; box-shadow:0 2px 12px #007bff33; border: 4px solid #fff; background: #fff; display: block; margin: 0 auto;}" +
            ".slogan {text-align:center; color:#007bff; font-size: 20px; font-weight:600; margin-bottom: 6px;}" +
            ".intro {text-align:center; color:#444; font-size:15px; margin-bottom: 18px;}" +
            ".desc {color:#333; font-size:15px; margin: 18px 0 18px 0; line-height:1.7;}" +
            ".otp-box {background: #eaf4ff; border: 2px solid #007bff; border-radius: 10px; padding: 22px 0; margin: 24px 0 18px 0; text-align:center; box-shadow:0 2px 8px #007bff11;}" +
            ".otp-label {font-size: 15px; color: #007bff; margin-bottom: 8px;}" +
            ".otp-code {font-size: 38px; font-weight: bold; color: #007bff; letter-spacing: 8px; background: #fff; padding: 8px 24px; border-radius: 8px; display: inline-block; border: 1.5px dashed #007bff;}" +
            ".note {background: #fffbe6; border-left: 4px solid #ffc107; padding: 12px 16px; border-radius: 6px; color: #856404; margin-bottom: 18px; font-size: 14px;}" +
            ".footer {margin-top: 32px; padding-top: 18px; border-top: 1px solid #e0e0e0; text-align:center; font-size: 13px; color: #888;}" +
            ".footer .contact {margin-top: 8px;}" +
            ".footer .icon {width:16px; vertical-align:middle; margin-right:4px;}" +
            "@media (max-width:600px){.container{padding:10px;}.otp-code{font-size:28px;}}" +
            "</style></head><body>" +
            "<div class='container'>" +
            "<div class='logo-wrap'>" +
            "<img src='https://static.vecteezy.com/system/resources/previews/046/790/031/non_2x/milk-tea-illustration-design-free-vector.jpg' alt='Milk Tea Shop Logo' class='logo-img'>" +
            "</div>" +
            "<div class='slogan'>Milk Tea Shop - Xác thực đổi email</div>" +
            "<div class='intro'>Bạn vừa yêu cầu thay đổi địa chỉ email cho tài khoản Milk Tea Shop.</div>" +
            "<div class='desc'>Để hoàn tất việc thay đổi email, vui lòng sử dụng mã xác thực (OTP) bên dưới. Nếu bạn không thực hiện yêu cầu này, hãy bỏ qua email này để đảm bảo an toàn cho tài khoản.</div>" +
            "<div class='otp-box'>" +
            "<div class='otp-label'>Mã xác thực (OTP) cho việc đổi email:</div>" +
            "<div class='otp-code'>" + otp + "</div>" +
            "</div>" +
            "<div class='note'><b>Lưu ý:</b> Mã OTP chỉ có hiệu lực trong thời gian ngắn. Tuyệt đối không chia sẻ mã này cho bất kỳ ai, kể cả nhân viên Milk Tea Shop.</div>" +
            "<div class='footer'>" +
            "Trân trọng,<br><b>Milk Tea Shop Team</b>" +
            "<div class='contact'>" +
            "<img class='icon' src='https://cdn-icons-png.flaticon.com/512/561/561127.png'/> trankiencuong30072003@gmail.com &nbsp;|&nbsp; " +
            "<img class='icon' src='https://cdn-icons-png.flaticon.com/512/597/597177.png'/> 0369702376" +
            "</div>" +
            "</div>" +
            "</div></body></html>";

        helper.setText(htmlContent, true);
        mailSender.send(message);
    }
} 