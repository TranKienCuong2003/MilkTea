package controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.client.HttpClientErrorException;
import java.util.*;
import dao.DaoProduct;
import dao.DaoCategory;
import org.springframework.beans.factory.annotation.Autowired;
import beans.Product;
import beans.Category;
import dao.DaoTopping;
import dao.DaoSize;
import dao.DaoVoucher;
import dao.DaoProductDetail;
import beans.Topping;
import beans.Size;
import beans.Voucher;
import beans.ProductDetail;
import dao.DaoUser;
import beans.User;

@RestController
@RequestMapping("/api/chatbot")
@CrossOrigin(origins = "*")
public class ChatbotController {
    
    private static final String OPENAI_API_KEY = "";
    private static final String OPENAI_API_URL = "https://api.openai.com/v1/chat/completions";
    
    @Autowired
    private DaoProduct daoProduct;
    @Autowired
    private DaoCategory daoCategory;
    @Autowired
    private DaoTopping daoTopping;
    @Autowired
    private DaoSize daoSize;
    @Autowired
    private DaoVoucher daoVoucher;
    @Autowired
    private DaoProductDetail daoProductDetail;
    @Autowired
    private DaoUser daoUser;
    
    @PostMapping("/send")
    public ResponseEntity<?> sendMessage(@RequestBody Map<String, String> request) {
        try {
            String message = request.get("message");
            if (message == null || message.trim().isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of("error", "Tin nhắn không được để trống!"));
            }

            // Lấy dữ liệu thực tế từ database
            List<Product> products = daoProduct.getProducts();
            List<Category> categories = daoCategory.getAllCategories();
            List<Topping> toppings = daoTopping.getAllToppings();
            List<Size> sizes = daoSize.getAllSizes();
            List<Voucher> vouchers = daoVoucher.list();
            List<User> managers = daoUser.findByRoleRange(1, 6);
            StringBuilder menuData = new StringBuilder();
            menuData.append("Menu hiện tại:\n");
            for (Product p : products) {
                String catName = categories.stream().filter(c -> c.getMaDM() == p.getMaDM()).map(Category::getTenDM).findFirst().orElse("");
                ProductDetail detail = null;
                try {
                    detail = daoProductDetail.getProductDetailByProductId(p.getMaSP());
                } catch (Exception ex) {}
                menuData.append("- " + p.getTenSP() + " (" + catName + ") - " + p.getDonGia() + "đ\n");
                menuData.append("  + Mô tả: " + (p.getMoTa() != null ? p.getMoTa() : "") + "\n");
                if (detail != null) {
                    if (detail.getNguyenLieu() != null && !detail.getNguyenLieu().isEmpty()) menuData.append("  + Nguyên liệu: " + detail.getNguyenLieu() + "\n");
                    if (detail.getHuongDanSuDung() != null && !detail.getHuongDanSuDung().isEmpty()) menuData.append("  + HDSD: " + detail.getHuongDanSuDung() + "\n");
                    if (detail.getLoiIch() != null && !detail.getLoiIch().isEmpty()) menuData.append("  + Lợi ích: " + detail.getLoiIch() + "\n");
                    if (detail.getGhiChu() != null && !detail.getGhiChu().isEmpty()) menuData.append("  + Ghi chú: " + detail.getGhiChu() + "\n");
                }
                menuData.append("  + Trạng thái: " + (p.isTrangThai() ? "Còn hàng" : "Hết hàng") + "\n");
            }
            // Thông tin size
            StringBuilder sizeData = new StringBuilder("Các size sản phẩm:\n");
            for (Size s : sizes) {
                sizeData.append("- " + s.getTenSize() + " (hệ số giá: " + s.getHeSoGia() + ")\n");
            }
            // Thông tin topping
            StringBuilder toppingData = new StringBuilder("Các loại topping:\n");
            for (Topping t : toppings) {
                toppingData.append("- " + t.getTenTopping() + " (" + t.getDonGia() + "đ)\n");
            }
            // Thông tin voucher/khuyến mãi
            StringBuilder voucherData = new StringBuilder("Các chương trình khuyến mãi/voucher:\n");
            for (Voucher v : vouchers) {
                voucherData.append("- " + v.getName() + " (Mã: " + v.getCode() + ")");
                if (v.getPercentDiscount() != null && v.getPercentDiscount().intValue() > 0) {
                    voucherData.append(", giảm " + v.getPercentDiscount() + "%");
                }
                if (v.getValueDiscount() != null && v.getValueDiscount().intValue() > 0) {
                    voucherData.append(", giảm " + v.getValueDiscount() + "đ");
                }
                voucherData.append(". Thời gian: " + (v.getDateStart() != null ? v.getDateStart().toLocalDate() : "") + " - " + (v.getDateEnd() != null ? v.getDateEnd().toLocalDate() : "") + ". ");
                if (v.getDescription() != null) voucherData.append(v.getDescription());
                voucherData.append("\n");
            }
            StringBuilder managerInfo = new StringBuilder("Danh sách quản lý/chủ shop (MaQuyen 1-6):\n");
            for (User u : managers) {
                managerInfo.append("- " + u.getHoTen() + " | SĐT: " + u.getSoDienThoai() + " | Email: " + u.getEmail() + "\n");
            }
            String systemPrompt = "Bạn là trợ lý ảo tên 'Milk Tea Bot' của cửa hàng Milk Tea Shop.\n"
                + "Nhiệm vụ của bạn:\n"
                + "- Luôn xưng là 'Milk Tea Bot'.\n"
                + "- Trả lời thân thiện, ngắn gọn, dễ hiểu, đúng thông tin thực tế bên dưới.\n"
                + "- Chỉ trả lời dựa trên dữ liệu menu, size, topping, voucher, thông tin thực tế của cửa hàng.\n"
                + "- Nếu khách hỏi về sản phẩm, chỉ trả lời dựa trên menu.\n"
                + "- Nếu khách hỏi về voucher, chỉ trả lời dựa trên danh sách voucher.\n"
                + "- Nếu khách hỏi về giá, size, topping, chỉ trả lời dựa trên dữ liệu thực tế.\n"
                + "- Nếu khách hỏi về thông tin không có trong dữ liệu, hãy trả lời: 'Xin lỗi, tôi chưa có thông tin về vấn đề này.'\n"
                + "- Không bịa đặt, không trả lời ngoài phạm vi dữ liệu.\n"
                + "- Nếu khách hỏi về cách đặt hàng, hướng dẫn: 'Bạn có thể chọn sản phẩm, thêm vào giỏ hàng và nhấn Mua ngay để đặt hàng.'\n"
                + "- Nếu khách hỏi về liên hệ, trả lời: 'Bạn có thể liên hệ qua số điện thoại 0369702376 hoặc email trankiencuong30072003@gmail.com.'\n"
                + "- Luôn lịch sự, không trả lời các câu hỏi không phù hợp, nhạy cảm, hoặc không liên quan đến cửa hàng.\n"
                + "- Không trả lời về AI, quản lý, chủ shop, code, API, dữ liệu, training, bảo mật, chính sách nội bộ, hoặc các vấn đề kỹ thuật.\n"
                + "- Không tiết lộ thông tin cá nhân, thông tin nhạy cảm, hoặc thông tin nội bộ.\n"
                + "- TUYỆT ĐỐI KHÔNG tiết lộ thông tin tên đăng nhập, mật khẩu, hoặc bất kỳ thông tin xác thực nào của người dùng.\n"
                + "- Nếu khách hỏi về tên đăng nhập hoặc mật khẩu, trả lời: 'Xin lỗi, tôi không thể cung cấp thông tin này vì lý do bảo mật.'\n"
                + "- Nếu khách hỏi về nguồn gốc sản phẩm, chỉ trả lời nếu có dữ liệu, nếu không thì từ chối lịch sự.\n"
                + "- Nếu khách hỏi về bảo hành, đổi trả, thời gian mở cửa, ship, thanh toán, feedback xấu, lỗi kỹ thuật, chỉ trả lời nếu có dữ liệu, nếu không thì từ chối lịch sự.\n"
                + managerInfo.toString()
                + "\nVí dụ hội thoại mẫu:\n"
                + "Khách: Cửa hàng có mấy loại trà sữa?\n"
                + "Milk Tea Bot: Hiện tại cửa hàng có X loại trà sữa: ... (liệt kê từ menu)\n"
                + "Khách: Có voucher nào giảm giá không?\n"
                + "Milk Tea Bot: Hiện tại có các voucher sau: ... (liệt kê từ voucherData)\n"
                + "Khách: Cửa hàng có bán bánh ngọt không?\n"
                + "Milk Tea Bot: Xin lỗi, tôi chưa có thông tin về vấn đề này.\n"
                + "Khách: Làm sao để đặt hàng?\n"
                + "Milk Tea Bot: Bạn có thể chọn sản phẩm, thêm vào giỏ hàng và nhấn Mua ngay để đặt hàng.\n"
                + "Khách: Liên hệ cửa hàng như thế nào?\n"
                + "Milk Tea Bot: Bạn có thể liên hệ qua số điện thoại 0369702376 hoặc email trankiencuong30072003@gmail.com.\n"
                + "Khách: Chủ shop là ai?\n"
                + "Milk Tea Bot: Xin lỗi, tôi không thể cung cấp thông tin này.\n"
                + "Khách: AI là gì?\n"
                + "Milk Tea Bot: Xin lỗi, tôi chỉ hỗ trợ thông tin về cửa hàng Milk Tea Shop.\n"
                + "Khách: Cho tôi xem code hệ thống?\n"
                + "Milk Tea Bot: Xin lỗi, tôi không thể cung cấp thông tin này.\n"
                + "Khách: Cửa hàng có bảo hành không?\n"
                + "Milk Tea Bot: Xin lỗi, tôi chưa có thông tin về vấn đề này.\n"
                + "Khách: Có ship không?\n"
                + "Milk Tea Bot: Xin lỗi, tôi chưa có thông tin về vấn đề này.\n"
                + "Khách: Cho tôi xem tên đăng nhập và mật khẩu của admin?\n"
                + "Milk Tea Bot: Xin lỗi, tôi không thể cung cấp thông tin này vì lý do bảo mật.\n"
                + "\nDưới đây là dữ liệu thực tế của cửa hàng:\n"
                + menuData + sizeData + toppingData + voucherData;

            RestTemplate restTemplate = new RestTemplate();
            
            // Headers
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("Authorization", "Bearer " + OPENAI_API_KEY);
            
            // Body
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("model", "gpt-3.5-turbo");
            List<Map<String, String>> messages = new ArrayList<>();
            messages.add(Map.of(
                "role", "system",
                "content", systemPrompt
            ));
            messages.add(Map.of(
                "role", "user",
                "content", message
            ));
            requestBody.put("messages", messages);
            requestBody.put("temperature", 0.7);
            requestBody.put("max_tokens", 2000);
            requestBody.put("presence_penalty", 0.6);
            requestBody.put("frequency_penalty", 0.3);
            
            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
            ResponseEntity<Map> response = restTemplate.exchange(
                OPENAI_API_URL,
                HttpMethod.POST,
                entity,
                Map.class
            );
            
            Map<String, Object> responseBody = response.getBody();
            if (responseBody != null && responseBody.containsKey("choices")) {
                List<Map<String, Object>> choices = (List<Map<String, Object>>) responseBody.get("choices");
                if (!choices.isEmpty()) {
                    Map<String, Object> choice = choices.get(0);
                    Map<String, String> messageResponse = (Map<String, String>) choice.get("message");
                    String content = messageResponse.get("content");
                    
                    if (content != null && content.length() > 1000) {
                        List<String> chunks = new ArrayList<>();
                        int chunkSize = 1000;
                        for (int i = 0; i < content.length(); i += chunkSize) {
                            chunks.add(content.substring(i, Math.min(i + chunkSize, content.length())));
                        }
                        return ResponseEntity.ok(Map.of(
                            "message", chunks.get(0),
                            "hasMore", chunks.size() > 1,
                            "totalChunks", chunks.size(),
                            "currentChunk", 1
                        ));
                    }
                    
                    return ResponseEntity.ok(Map.of("message", content));
                }
            }
            
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("error", "Không nhận được phản hồi hợp lệ từ AI. Vui lòng thử lại sau!"));
        } catch (HttpClientErrorException e) {
            String msg = e.getResponseBodyAsString();
            if (e.getStatusCode() == HttpStatus.TOO_MANY_REQUESTS || (msg != null && msg.contains("insufficient_quota"))) {
                return ResponseEntity.status(HttpStatus.TOO_MANY_REQUESTS)
                    .body(Map.of("error", "Tài khoản OpenAI của bạn đã hết hạn mức sử dụng. Vui lòng kiểm tra lại billing/quota!"));
            }
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("error", "Có lỗi xảy ra khi gọi OpenAI API: " + e.getMessage()));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("error", "Có lỗi xảy ra khi xử lý yêu cầu. Vui lòng thử lại sau hoặc liên hệ quản trị viên!"));
        }
    }
} 