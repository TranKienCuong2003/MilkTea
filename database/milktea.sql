-- XÓA DATABASE NẾU ĐÃ TỒN TẠI
DROP DATABASE IF EXISTS TeaMilk;

-- TẠO MỚI DATABASE
CREATE DATABASE TeaMilk CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE TeaMilk;

SET SQL_SAFE_UPDATES = 0;

-- PHÂN QUYỀN
CREATE TABLE PHAN_QUYEN (
    MaQuyen INT PRIMARY KEY AUTO_INCREMENT,
    TenQuyen VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO PHAN_QUYEN (TenQuyen) VALUES
('Chủ quán'),
('Quản lý'),
('Nhân viên order'),
('Nhân viên thu ngân'),
('Nhân viên pha chế'),
('Nhân viên kho'),
('Khách hàng');

-- BẢNG NGƯỜI DÙNG
CREATE TABLE NGUOI_DUNG (
    MaND INT PRIMARY KEY AUTO_INCREMENT,
    HoTen VARCHAR(100) NOT NULL,
    TenDangNhap VARCHAR(50) NOT NULL UNIQUE,
    MatKhau VARCHAR(255) NOT NULL,
    Email VARCHAR(100),
    SoDienThoai VARCHAR(20),
    MaQuyen INT,
    DiaChi VARCHAR(255),
    AnhDaiDien VARCHAR(255),
    xacThucToken VARCHAR(255),
    otpCode VARCHAR(10),
    TrangThai BOOLEAN DEFAULT TRUE,
    NgayTao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (MaQuyen) REFERENCES PHAN_QUYEN(MaQuyen)
);

-- DỮ LIỆU TRONG BẢNG NGƯỜI DÙNG
INSERT INTO NGUOI_DUNG (HoTen, TenDangNhap, MatKhau, Email, SoDienThoai, MaQuyen, DiaChi, AnhDaiDien)
VALUES 
('Trần Kiên Cường', 'chuquan01', '123', 'trankiencuong30072003@gmail.com', '0369702376', 1, 'Hà Nội', 'https://png.pngtree.com/png-vector/20190321/ourmid/pngtree-vector-users-icon-png-image_856952.jpg'),
('Nguyễn Minh Dũng', 'quanly1', '123', 'nguyenminhdung@gmail.com', '0907654321', 2, 'Hà Nội', 'https://png.pngtree.com/png-vector/20190321/ourmid/pngtree-vector-users-icon-png-image_856952.jpg'),
('Nguyễn Thành Đạt', 'order01', '123', 'nguyenthanhdat@gmail.com', '0912834502', 3, 'Hà Nội', 'https://png.pngtree.com/png-vector/20190321/ourmid/pngtree-vector-users-icon-png-image_856952.jpg'),
('Nguyễn Quyền Linh', 'thungan01', '123', 'nguyenquyenlinh@gmail.com', '0928046281', 4, 'Hà Nội', 'https://png.pngtree.com/png-vector/20190321/ourmid/pngtree-vector-users-icon-png-image_856952.jpg'),
('Nguyễn Thị Dung', 'phache01', '123', 'nguyenthidung@gmail.com', '0396225584', 5, 'Hà Nội', 'https://png.pngtree.com/png-vector/20190321/ourmid/pngtree-vector-users-icon-png-image_856952.jpg'),
('Nguyễn Thị Như', 'kho01', '123', 'nguyenthinhu@gmail.com', '0942784793', 6, 'Hà Nội', 'https://png.pngtree.com/png-vector/20190321/ourmid/pngtree-vector-users-icon-png-image_856952.jpg'),
('Hoàng Thị Loan', 'khach01', '123', 'hoangthiloan@gmail.com', '0982654335', 7, 'Hà Nội', 'https://png.pngtree.com/png-vector/20190321/ourmid/pngtree-vector-users-icon-png-image_856952.jpg');
-- BẢNG DANH MỤC SẢN PHẨM
CREATE TABLE DANH_MUC (
    MaDM INT AUTO_INCREMENT PRIMARY KEY,
    TenDM VARCHAR(100) NOT NULL
);

-- DỮ LIỆU TRONG BẢNG DANH MỤC
INSERT INTO DANH_MUC (TenDM) VALUES
('Trà sữa'),
('Cà phê'),
('Nước trái cây'),
('Đồ uống đặc biệt');

-- BẢNG SẢN PHẨM
CREATE TABLE SAN_PHAM (
    MaSP INT AUTO_INCREMENT PRIMARY KEY,
    TenSP VARCHAR(100) NOT NULL,
    DonGia DECIMAL(10,2) NOT NULL,
    MaDM INT,
    MoTa TEXT,
    HinhAnh VARCHAR(255),
    SoLuong VARCHAR(255),
    TrangThai BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (MaDM) REFERENCES DANH_MUC(MaDM)
);

ALTER TABLE SAN_PHAM AUTO_INCREMENT = 1;

-- DỮ LIỆU TRONG BẢNG SẢN PHẨM
INSERT INTO SAN_PHAM (TenSP, DonGia, MaDM, MoTa, HinhAnh, SoLuong, TrangThai) VALUES
('Trà Sữa Thái Xanh', 30000, 1, 'Trà sữa đậm vị Thái, ngọt dịu và thơm mùi sữa', 'https://congthucphache.com/wp-content/uploads/2019/12/thai-xanh.jpg', 100,TRUE),
('Trà Sữa Hồng Kông', 32000, 1, 'Trà sữa vị Hồng Kông truyền thống, béo ngậy', 'https://hongkongbaleytea.com/upload/product/imgl8409-4091.jpg', 100,TRUE),
('Trà Xanh Nhật Bản', 35000, 1, 'Matcha Nhật Bản nguyên chất, thanh mát', 'https://naturefoods.com.vn/uploads/files/2017/02/14/bigstockGreenTeaMatcha.jpg', 100,TRUE),
('Trà Sữa Khoai Lang', 33000, 1, 'Trà sữa kết hợp vị khoai lang tím béo mịn', 'https://i.ytimg.com/vi/tVqXPk3KwCM/sddefault.jpg', 100,TRUE),
('Trà Sữa Socola', 34000, 1, 'Trà sữa đậm đà cùng socola nguyên chất, thơm ngon khó cưỡng', 'https://file.hstatic.net/200000868155/article/1926-post-cach-lam-tra-sua-socola-beo-thom-don-gian-tai-nha-1_71b1f57096264ee8899f692b1dfe798f.jpg', 100,TRUE),

('Cà Phê Sữa Đá', 25000, 2, 'Cà phê pha phin, sữa đặc, đậm đà và thơm lừng', 'https://www.cubes-asia.com/storage/blogs/2023/ca-phe-sua-da.jpg', 100,TRUE),
('Bạc Xỉu', 27000, 2, 'Sữa nhiều hơn cà phê, thích hợp cho người mê ngọt', 'https://cdn.tgdd.vn/2021/03/CookProduct/Bac-xiu-la-gi-nguon-goc-va-cach-lam-bac-xiu-thom-ngon-don-gian-tai-nha-0-1200x676.jpg', 100,TRUE),
('Cà Phê Đen Đá', 22000, 2, 'Cà phê nguyên chất, không đường, vị đắng mạnh mẽ', 'https://visty.vn/wp-content/uploads/2020/02/Ca-phe-%C4%91en-2.jpg', 100,TRUE),

('Nước Chanh Muối', 20000, 3, 'Chanh muối thanh mát, giải khát mùa hè', 'https://primer.vn/wp-content/uploads/2023/10/cach-lam-chanh-muoi-ngon.jpg', 100,TRUE),
('Nước Cam Ép', 24000, 3, 'Cam tươi nguyên chất, cung cấp vitamin C', 'https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2022/2/19/cach-lam-nuoc-cam-ep-ngon-va-thom-ket-hop-voi-le-va-gung-5-1645248090817401855254.jpg', 100,TRUE),
('Sinh Tố Dứa', 27000, 3, 'Sinh tố dứa tươi, chua nhẹ và mát lạnh', 'https://cdn.tgdd.vn/Files/2019/06/10/1172354/cach-lam-sinh-to-dua-ngon-ngat-ngay-uong-la-len-may-202201190929516504.jpg', 100,TRUE),
('Sinh Tố Bơ', 29000, 3, 'Sinh tố bơ béo ngậy, thơm ngon', 'https://cdn.tgdd.vn/2021/08/CookRecipe/GalleryStep/thanh-pham-1351.jpg', 100,TRUE),
('Sữa Tươi Trân Châu Đường Đen', 36000, 1, 'Sữa tươi kết hợp trân châu dẻo và sốt đường đen thơm lừng', 'https://bachaxanh.com/uploads/images/news/cach-lam-sua-tuoi-tran-chau-duong-den-1.png', 100,TRUE),
('Trà Sữa Phô Mai Tươi Nướng', 38000, 4, 'Trà sữa đậm vị kết hợp với topping phô mai tươi nướng thơm lừng, béo ngậy và độc đáo.', '', 100, TRUE),
('Trà Sữa Kem Trứng Cháy', 38000, 4, 'Trà sữa hòa quyện cùng lớp kem trứng cháy béo ngậy, thơm lừng, ngọt ngào khó cưỡng', 'https://lypham.vn/wp-content/uploads/2024/09/cach-lam-tra-sua-kem-trung-nuong.jpg', 100, TRUE);

-- BẢNG CHI TIẾT SẢN PHẨM
CREATE TABLE CHI_TIET_SAN_PHAM (
    MaCTSP INT AUTO_INCREMENT PRIMARY KEY,
    MaSP INT,
    NguyenLieu TEXT,
    HuongDanSuDung TEXT,
    LoiIch TEXT,
    GhiChu TEXT,
    FOREIGN KEY (MaSP) REFERENCES SAN_PHAM(MaSP)
);

-- DỮ LIỆU TRONG BẢNG CHI TIẾT SẢN PHẨM
INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP, 
       'Trà Thái xanh, sữa đặc, sữa tươi, nước cốt dừa, đường, đá viên',
       'Khuấy đều trước khi uống. Ngon hơn khi uống lạnh.',
       'Giúp tỉnh táo, thư giãn và bổ sung năng lượng tức thì.',
       'Thêm topping như trân châu đen, thạch rau câu hoặc pudding theo sở thích.'
FROM SAN_PHAM
WHERE TenSP = 'Trà Sữa Thái Xanh';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Trà đen nguyên chất, sữa đặc, bột kem béo, đường cát',
       'Ngon nhất khi uống lạnh. Không cần lắc.',
       'Vị trà mạnh mẽ kết hợp độ béo vừa phải, giúp tỉnh táo và tạo cảm giác no lâu.',
       'Phù hợp khi thưởng thức cùng bạn bè hoặc trong lúc làm việc.'
FROM SAN_PHAM WHERE TenSP = 'Trà Sữa Hồng Kông';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Bột Matcha Nhật Bản nguyên chất, sữa tươi không đường, bột kem béo, đường mía',
       'Khuấy đều trước khi uống. Thưởng thức ngon hơn khi dùng lạnh hoặc đá xay.',
       'Giàu chất chống oxy hóa, hỗ trợ tỉnh táo, giảm stress và làm đẹp da.',
       'Không nên dùng khi đói vì matcha có thể gây cồn cào nhẹ với người nhạy cảm.'
FROM SAN_PHAM WHERE TenSP = 'Trà Xanh Nhật Bản';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Sữa tươi thanh trùng, khoai lang tím nghiền nhuyễn, kem béo thực vật, đường nâu',
       'Uống lạnh. Khuấy đều trước khi dùng để cảm nhận trọn vẹn hương vị và độ mịn.',
       'Giàu năng lượng, chứa vitamin A, chất xơ và chất chống oxy hóa từ khoai lang tím.',
       'Hương vị độc đáo, màu sắc bắt mắt – xu hướng mới của giới trẻ yêu thích healthy drink.'
FROM SAN_PHAM WHERE TenSP = 'Trà Sữa Khoai Lang';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Trà đen đậm vị, bột cacao nguyên chất, sữa tươi, kem tươi, đường mía',
       'Uống lạnh để cảm nhận rõ vị cacao hoà quyện cùng trà. Dùng kèm topping sẽ ngon hơn.',
       'Tăng cường dopamine, kích thích vị giác và cải thiện tâm trạng hiệu quả.',
       'Hạn chế uống cùng đồ ăn mặn để tránh làm mất hương vị đặc trưng.'
FROM SAN_PHAM WHERE TenSP = 'Trà Sữa Socola';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Cà phê đen nguyên chất pha phin truyền thống, sữa đặc có đường, đá viên',
       'Thưởng thức ngay sau khi pha. Khuấy đều trước khi uống để hương vị hoà quyện.',
       'Giúp tỉnh táo, tăng khả năng tập trung và nâng cao hiệu suất làm việc.',
       'Không nên uống khi bụng đói hoặc vào buổi tối để tránh mất ngủ.'
FROM SAN_PHAM WHERE TenSP = 'Cà Phê Sữa Đá';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Sữa đặc có đường, một chút cà phê phin, sữa tươi, đá viên',
       'Uống lạnh. Khuấy đều trước khi dùng để vị cà phê và sữa hoà quyện.',
       'Giúp tỉnh nhẹ, tạo cảm giác thư giãn và dễ chịu.',
       'Phù hợp với người mới bắt đầu uống cà phê hoặc yêu thích vị ngọt dịu.'
FROM SAN_PHAM WHERE TenSP = 'Bạc Xỉu';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Cà phê đen nguyên chất pha phin, nước nóng, đá viên',
       'Uống lạnh. Có thể thêm ít đường nếu cần, nhưng không dùng sữa.',
       'Tỉnh táo tức thì, kích thích trí não và tăng khả năng tập trung cao độ.',
       'Phù hợp với người yêu thích vị đắng mạnh mẽ và thuần khiết của cà phê.'
FROM SAN_PHAM WHERE TenSP = 'Cà Phê Đen Đá';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Chanh muối lâu năm, nước lọc tinh khiết, đá viên',
       'Dùng lạnh để đạt hiệu quả giải nhiệt tối đa. Khuấy nhẹ trước khi uống.',
       'Bổ sung điện giải tự nhiên, hỗ trợ thanh lọc cơ thể và hồi phục năng lượng nhanh chóng.',
       'Không khuyến khích dùng khi đau dạ dày hoặc đang viêm họng do có vị mặn và chua.'
FROM SAN_PHAM WHERE TenSP = 'Nước Chanh Muối';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Cam tươi nguyên chất, đường (nếu cần)',
       'Lắc đều hoặc khuấy nhẹ trước khi uống để vị cam được hoà quyện.',
       'Bổ sung vitamin C tự nhiên, tăng cường sức đề kháng và hỗ trợ làm đẹp da.',
       'Ngon nhất khi uống lạnh với đá viên, thích hợp cho bữa sáng hoặc giải khát mùa hè.'
FROM SAN_PHAM WHERE TenSP = 'Nước Cam Ép';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Dứa tươi, sữa đặc có đường, đá viên, một ít đường (tùy khẩu vị)',
       'Xay nhuyễn rồi thưởng thức lạnh, có thể thêm đá nếu thích.',
       'Giàu vitamin C, enzyme tự nhiên giúp tăng cường hệ tiêu hoá và làm đẹp da.',
       'Tránh uống khi đói vì tính axit có thể gây kích ứng dạ dày.'
FROM SAN_PHAM WHERE TenSP = 'Sinh Tố Dứa';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Bơ chín, sữa đặc, sữa tươi, đá viên',
       'Xay nhuyễn và thưởng thức ngay khi còn lạnh để giữ được độ mượt mà của bơ.',
       'Cung cấp chất béo tốt, vitamin E và các dưỡng chất thiết yếu cho cơ thể.',
       'Lý tưởng cho bữa sáng nhẹ, cung cấp năng lượng dài lâu mà không gây no quá mức.'
FROM SAN_PHAM WHERE TenSP = 'Sinh Tố Bơ';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Sữa tươi không đường, trân châu đen, sốt đường đen, đá viên',
       'Lắc đều để sốt đường đen hòa quyện với sữa, thưởng thức ngay khi còn lạnh.',
       'Vị ngọt thơm mát, giúp giải khát và tạo cảm giác no lâu.',
       'Không nên dùng quá nhiều topping để tránh ảnh hưởng đến cân nặng.'
FROM SAN_PHAM WHERE TenSP = 'Sữa Tươi Trân Châu Đường Đen';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Trà đen, sữa tươi không đường, kem phô mai tươi nướng, đường, đá viên',
       'Dùng lạnh, khuấy nhẹ để lớp phô mai hòa quyện cùng trà sữa.',
       'Bổ sung canxi và protein, vị béo mặn nhẹ giúp cân bằng vị giác.',
       'Nên thưởng thức ngay sau khi rót ra để giữ độ thơm béo của phô mai nướng.'
FROM SAN_PHAM WHERE TenSP = 'Trà Sữa Phô Mai Tươi Nướng';

INSERT INTO CHI_TIET_SAN_PHAM (MaSP, NguyenLieu, HuongDanSuDung, LoiIch, GhiChu)
SELECT MaSP,
       'Trà đen, sữa đặc, sữa tươi, kem trứng đánh bông, lớp caramel cháy',
       'Khuấy đều phần kem trứng trước khi uống để hoà quyện hương vị. Uống lạnh là ngon nhất.',
       'Giàu năng lượng, béo thơm đậm đà, tạo cảm giác "nâng mood" liền tay.',
       'Không nên để lâu vì lớp caramel sẽ tan mất chất lượng ban đầu.'
FROM SAN_PHAM WHERE TenSP = 'Trà Sữa Kem Trứng Cháy';

-- BẢNG SIZE SẢN PHẨM
CREATE TABLE SIZE_SAN_PHAM (
    MaSize INT AUTO_INCREMENT PRIMARY KEY,
    TenSize VARCHAR(10) NOT NULL, -- M, L, XL
    HeSoGia DECIMAL(3,2) DEFAULT 1.0
);

-- DỮ LIỆU TRONG BẢNG SIZE SẢN PHẨM
INSERT INTO SIZE_SAN_PHAM (TenSize, HeSoGia) VALUES
('M', 1.0),
('L', 1.2),
('XL', 1.5);

-- BẢNG TOPPING
CREATE TABLE TOPPING (
    MaTopping INT AUTO_INCREMENT PRIMARY KEY,
    TenTopping VARCHAR(100) NOT NULL,
    DonGia DECIMAL(10,2) NOT NULL,
    TrangThai BOOLEAN DEFAULT TRUE
);

-- DỮ LIỆU TRONG BẢNG TOPPING
INSERT INTO TOPPING (TenTopping, DonGia, TrangThai) VALUES
('Trân Châu Trắng', 5000, TRUE),
('Trân Châu Đường Đen', 6000, TRUE),
('Pudding Trứng', 7000, TRUE),
('Thạch Cà Phê', 5000, TRUE),
('Thạch Dừa', 4000, TRUE),
('Kem Cheese', 8000, TRUE),
('Đậu Xanh', 5000, TRUE),
('Marshmallow', 6000, TRUE);

-- UPDATE HÌNH ẢNH SẢN PHẨM
UPDATE SAN_PHAM SET HinhAnh = 'thai-xanh.jpg' WHERE TenSP = 'Trà Sữa Thái Xanh';
UPDATE SAN_PHAM SET HinhAnh = 'hong-kong.jpg' WHERE TenSP = 'Trà Sữa Hồng Kông';
UPDATE SAN_PHAM SET HinhAnh = 'matcha.jpg' WHERE TenSP = 'Trà Xanh Nhật Bản';
UPDATE SAN_PHAM SET HinhAnh = 'khoai-lang.jpg' WHERE TenSP = 'Trà Sữa Khoai Lang';
UPDATE SAN_PHAM SET HinhAnh = 'socola.jpg' WHERE TenSP = 'Trà Sữa Socola';

UPDATE SAN_PHAM SET HinhAnh = 'cafe-sua.jpg' WHERE TenSP = 'Cà Phê Sữa Đá';
UPDATE SAN_PHAM SET HinhAnh = 'bac-xiu.jpg' WHERE TenSP = 'Bạc Xỉu';
UPDATE SAN_PHAM SET HinhAnh = 'cafe-den.jpg' WHERE TenSP = 'Cà Phê Đen Đá';

UPDATE SAN_PHAM SET HinhAnh = 'chanh-muoi.jpg' WHERE TenSP = 'Nước Chanh Muối';
UPDATE SAN_PHAM SET HinhAnh = 'cam-ep.jpg' WHERE TenSP = 'Nước Cam Ép';
UPDATE SAN_PHAM SET HinhAnh = 'sinh-to-dua.jpg' WHERE TenSP = 'Sinh Tố Dứa';
UPDATE SAN_PHAM SET HinhAnh = 'sinh-to-bo.jpg' WHERE TenSP = 'Sinh Tố Bơ';
UPDATE SAN_PHAM SET HinhAnh = 'sua-tuoi-tran-chau-duong-den.jpg' WHERE TenSP = 'Sữa Tươi Trân Châu Đường Đen';
UPDATE SAN_PHAM SET HinhAnh = 'tra-sua-pho-mai-tuoi-nuong.jpg' WHERE TenSP = 'Trà Sữa Phô Mai Tươi Nướng';
UPDATE SAN_PHAM SET HinhAnh = 'tra-sua-kem-trung-chay.jpg' WHERE TenSP = 'Trà Sữa Kem Trứng Cháy';

UPDATE NGUOI_DUNG SET AnhDaiDien = '/resources/images/avatars/users-icon.jpg' WHERE TenDangNhap = 'chuquan01';
UPDATE NGUOI_DUNG SET AnhDaiDien = '/resources/images/avatars/users-icon.jpg' WHERE TenDangNhap = 'quanly1';
UPDATE NGUOI_DUNG SET AnhDaiDien = '/resources/images/avatars/users-icon.jpg' WHERE TenDangNhap = 'order01';
UPDATE NGUOI_DUNG SET AnhDaiDien = '/resources/images/avatars/users-icon.jpg' WHERE TenDangNhap = 'thungan01';
UPDATE NGUOI_DUNG SET AnhDaiDien = '/resources/images/avatars/users-icon.jpg' WHERE TenDangNhap = 'phache01';
UPDATE NGUOI_DUNG SET AnhDaiDien = '/resources/images/avatars/users-icon.jpg' WHERE TenDangNhap = 'kho01';
UPDATE NGUOI_DUNG SET AnhDaiDien = '/resources/images/avatars/users-icon.jpg' WHERE TenDangNhap = 'khach01';

SET SQL_SAFE_UPDATES = 1;

-- BẢNG VOUCHER
CREATE TABLE VOUCHER
(
    id int AUTO_INCREMENT PRIMARY KEY,
    ma varchar(500),
    ten varchar(500),
    mota text,
    ngaybatdau datetime,
    ngayketthuc datetime,
    phantramgiamgia decimal,
    giatrigiamgia decimal
);

-- DỮ LIỆU TRONG BẢNG VOUCHER
INSERT INTO VOUCHER (ma, ten, mota, ngaybatdau, ngayketthuc, phantramgiamgia, giatrigiamgia) VALUES
('NEWCUST10', 'Giảm 10% cho khách mới', 'Chương trình khuyến mãi dành cho khách hàng đăng ký lần đầu', '2025-05-01 00:00:00', '2025-06-01 23:59:59', 10.0, NULL),
('SUMMER15', 'Ưu đãi hè 15%', 'Giảm giá toàn bộ đơn hàng vào tháng 6', '2025-06-01 00:00:00', '2025-06-30 23:59:59', 15.0, NULL),
('VIP30', 'Voucher VIP giảm 30%', 'Chỉ áp dụng cho khách hàng VIP hạng Vàng trở lên', '2025-05-10 00:00:00', '2025-07-10 23:59:59', 30.0, NULL),
('FLASH100K', 'Flash Sale giảm 100K', 'Giảm ngay 100.000đ cho 100 đơn đầu tiên mỗi ngày', '2025-05-14 00:00:00', '2025-05-20 23:59:59', NULL, 100000),
('TETSALE', 'Tết Rộn Ràng – Giảm 20%', 'Áp dụng cho tất cả đơn hàng từ 20/01 đến 30/01', '2025-01-20 00:00:00', '2025-01-30 23:59:59', 20.0, NULL);

-- BẢNG NHÀ CUNG CẤP
CREATE TABLE NHACUNGCAP (
    maNhaCungCap INT AUTO_INCREMENT PRIMARY KEY,
    TenNhaCungCap VARCHAR(255) NOT NULL,
    diaChi VARCHAR(255),
    soDienThoai VARCHAR(15)
);

-- DỮ LIỆU TRONG BẢNG NHÀ CUNG CẤP
INSERT INTO NHACUNGCAP (TenNhaCungCap, diaChi, soDienThoai) VALUES
('Công ty TNHH Trà Xanh Việt', '12 Lê Văn Sỹ, Quận 3, TP.HCM', '0909123456'),
('Sữa Tươi Thanh Long', '88 Nguyễn Trãi, Hà Nội', '0911223344'),
('Thực Phẩm Đại Hưng', '23 Nguyễn Đình Chiểu, Đà Nẵng', '0909112233'),
('Nguyên Liệu Hòa Phát', '56 Trường Chinh, Hà Nội', '0977888999'),
('Trân Châu QueenPearl', '71 Hoàng Văn Thụ, TP.HCM', '0933445566'),
('Công ty Hương Liệu Hương Việt', '109 Phan Xích Long, TP.HCM', '0988997788'),
('Đường Mía An Giang', 'Thị trấn Chợ Mới, An Giang', '0966554433'),
('Syrup & Topping Phúc Lộc', '5A Lý Tự Trọng, Cần Thơ', '0944332211'),
('Chai Nhựa Bình Minh', '123 CMT8, Quận 10, TP.HCM', '0911002200'),
('Bao Bì Việt Long', '15B Trần Quang Khải, Hà Nội', '0933221144');

-- BẢNG KHO
CREATE TABLE KHO (
    maNguyenLieu INT AUTO_INCREMENT PRIMARY KEY,
    tenNguyenLieu VARCHAR(255) NOT NULL,
    soLuong DECIMAL(10,2) NOT NULL DEFAULT 0,
    donViTinh VARCHAR(50) NOT NULL,
    ngayNhap DATE NOT NULL,
    hanSuDung DATE,
    maNhaCungCap INT,
    ghiChu TEXT,

    FOREIGN KEY (maNhaCungCap) REFERENCES NHACUNGCAP(maNhaCungCap)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- DỮ LIỆU TRONG BẢNG KHO
INSERT INTO KHO (tenNguyenLieu, soLuong, donViTinh, ngayNhap, hanSuDung, maNhaCungCap, ghiChu) VALUES
('Trà Ô Long', 50.00, 'gram', '2025-05-10', '2025-12-10', 1, 'Dùng pha trà sữa Ô Long'),
('Sữa tươi không đường', 100.00, 'lít', '2025-05-12', '2025-06-12', 2, 'Sữa tươi Vinamilk'),
('Bột kem béo Indo', 75.00, 'kg', '2025-05-09', '2026-01-01', 3, 'Tạo độ béo cho sữa'),
('Trà đen Bá Tước', 40.00, 'gram', '2025-05-05', '2025-10-01', 1, 'Thích hợp cho milk tea truyền thống'),
('Trân châu đen', 20.00, 'kg', '2025-05-11', '2025-06-11', 5, 'Luộc trước khi dùng'),
('Đường trắng tinh luyện', 60.00, 'kg', '2025-05-01', '2025-08-20', 7, 'Đường mía An Giang'),
('Syrup Dâu', 25.00, 'lít', '2025-05-08', '2025-09-08', 8, 'Dùng cho trà sữa dâu'),
('Syrup Bạc Hà', 15.00, 'lít', '2025-05-10', '2025-10-10', 8, 'Tạo hương bạc hà mát lạnh'),
('Chai nhựa 500ml', 200.00, 'chai', '2025-05-03', '2025-06-12', 9, 'Đựng trà mang đi'),
('Ly nhựa 700ml', 500.00, 'ly', '2025-05-06', '2025-08-12', 10, 'Ly dùng cho trà sữa size lớn');

-- BẢNG ĐƠN HÀNG
CREATE TABLE DON_HANG
(
    id int AUTO_INCREMENT PRIMARY KEY,
    ten varchar(500),
    diachi text,
    sdt varchar(10),
    ngaydat datetime,
    voucher varchar(100),
    tongTien decimal,
    status int
);

ALTER TABLE don_hang
ADD COLUMN discount_amount DECIMAL(10,2),
ADD COLUMN discount_type VARCHAR(10),
ADD COLUMN discount_value DECIMAL(10,2);

-- DỮ LIỆU TRONG BẢNG ĐƠN HÀNG
INSERT INTO DON_HANG (ten, diachi, sdt, ngaydat, voucher, tongTien, status)
VALUES
('Nguyễn Thị Mai', '123 Đường Láng, Đống Đa, Hà Nội', '0987654321', '2025-05-14 09:15:00', 'NEWCUST10', 459000, 1),
('Trần Văn An', '456 Minh Khai, Hai Bà Trưng, Hà Nội', '0912345678', '2025-05-14 10:20:00', NULL, 115000, 0),
('Lê Hoàng', '12A Nguyễn Trãi, Thanh Xuân, Hà Nội', '0901122334', '2025-05-13 18:40:00', NULL, 49000, 2),
('Phạm Quỳnh Trang', '89 Phố Huế, Hoàn Kiếm, Hà Nội', '0977888999', '2025-05-14 14:05:00', 'VIP30', 476000, 1),
('Đỗ Minh Đức', '27 Kim Mã, Ba Đình, Hà Nội', '0988997766', '2025-05-14 11:10:00', NULL, 54000, 0),
('Hoàng Anh', 'Số 9, Trần Duy Hưng, Cầu Giấy, Hà Nội', '0966668888', '2025-05-14 11:58:00', NULL, 34000, 0);

-- Thêm 20 đơn hàng mẫu ở Hà Nội
INSERT INTO DON_HANG (ten, diachi, sdt, ngaydat, voucher, tongTien, status, discount_amount, discount_type, discount_value) VALUES
-- Đơn hàng có voucher giảm %
('Nguyễn Văn An', '123 Đường Láng, Đống Đa, Hà Nội', '0987654321', '2025-05-15 08:30:00', 'NEWCUST10', 135000, 2, 15000, 'PERCENT', 10),
('Trần Thị Bình', '456 Minh Khai, Hai Bà Trưng, Hà Nội', '0912345678', '2025-05-15 09:15:00', 'SUMMER15', 204000, 2, 36000, 'PERCENT', 15),
('Lê Văn Cường', '789 Nguyễn Trãi, Thanh Xuân, Hà Nội', '0901122334', '2025-05-15 10:00:00', 'VIP30', 245000, 2, 105000, 'PERCENT', 30),

-- Đơn hàng có voucher giảm giá cố định
('Phạm Thị Dung', '321 Kim Mã, Ba Đình, Hà Nội', '0977888999', '2025-05-15 11:30:00', 'FLASH100K', 180000, 2, 100000, 'VALUE', 100000),
('Hoàng Văn Em', '654 Trần Duy Hưng, Cầu Giấy, Hà Nội', '0988997766', '2025-05-15 12:45:00', 'FLASH100K', 150000, 2, 100000, 'VALUE', 100000),

-- Đơn hàng không có voucher
('Đỗ Thị Phương', '987 Phố Huế, Hoàn Kiếm, Hà Nội', '0966668888', '2025-05-15 13:20:00', NULL, 115000, 2, NULL, NULL, NULL),
('Nguyễn Văn Giang', '147 Lê Văn Lương, Thanh Xuân, Hà Nội', '0955557777', '2025-05-15 14:10:00', NULL, 95000, 2, NULL, NULL, NULL),
('Trần Thị Hương', '258 Đội Cấn, Ba Đình, Hà Nội', '0944446666', '2025-05-15 15:00:00', NULL, 145000, 2, NULL, NULL, NULL),
('Lê Văn Hùng', '369 Nguyễn Khang, Cầu Giấy, Hà Nội', '0933335555', '2025-05-15 16:30:00', NULL, 125000, 2, NULL, NULL, NULL),
('Phạm Thị Khanh', '741 Láng Hạ, Đống Đa, Hà Nội', '0922224444', '2025-05-15 17:15:00', NULL, 165000, 2, NULL, NULL, NULL),
('Hoàng Văn Long', '852 Nguyễn Chí Thanh, Đống Đa, Hà Nội', '0911113333', '2025-05-15 18:00:00', NULL, 135000, 2, NULL, NULL, NULL),
('Đỗ Thị Mai', '963 Đại Cồ Việt, Hai Bà Trưng, Hà Nội', '0900002222', '2025-05-15 19:30:00', NULL, 155000, 2, NULL, NULL, NULL),
('Nguyễn Văn Nam', '159 Tây Sơn, Đống Đa, Hà Nội', '0899991111', '2025-05-15 20:15:00', NULL, 175000, 2, NULL, NULL, NULL),
('Trần Thị Oanh', '357 Nguyễn Văn Cừ, Long Biên, Hà Nội', '0888880000', '2025-05-15 21:00:00', NULL, 195000, 2, NULL, NULL, NULL),
('Lê Văn Phúc', '753 Nguyễn Văn Linh, Long Biên, Hà Nội', '0877779999', '2025-05-15 22:30:00', NULL, 185000, 2, NULL, NULL, NULL),
('Phạm Thị Quỳnh', '951 Nguyễn Văn Huyên, Cầu Giấy, Hà Nội', '0866668888', '2025-05-15 23:15:00', NULL, 205000, 2, NULL, NULL, NULL),
('Hoàng Văn Rạng', '852 Nguyễn Văn Huyên, Cầu Giấy, Hà Nội', '0855557777', '2025-05-16 00:00:00', NULL, 215000, 2, NULL, NULL, NULL),
('Đỗ Thị Sương', '741 Nguyễn Văn Huyên, Cầu Giấy, Hà Nội', '0844446666', '2025-05-16 01:30:00', NULL, 225000, 2, NULL, NULL, NULL),
('Nguyễn Văn Tú', '963 Nguyễn Văn Huyên, Cầu Giấy, Hà Nội', '0833335555', '2025-05-16 02:15:00', NULL, 235000, 2, NULL, NULL, NULL);

-- BẢNG CHI TIẾT ĐƠN HÀNG
CREATE TABLE CHI_TIET_DON_HANG
(
    id int AUTO_INCREMENT PRIMARY KEY,
    don_hang int,
    san_pham int,
    size int
);

-- BẢNG CHI TIẾT ĐƠN HÀNG TOPPING
CREATE TABLE CHI_TIET_DON_HANG_TOPPING (
    id INT AUTO_INCREMENT PRIMARY KEY,
    chi_tiet_don_hang INT,
    topping INT,
    FOREIGN KEY (chi_tiet_don_hang) REFERENCES CHI_TIET_DON_HANG(id),
    FOREIGN KEY (topping) REFERENCES TOPPING(MaTopping)
);

-- DỮ LIỆU TRONG BẢNG CHI TIẾT ĐƠN HÀNG
-- CHI_TIET_DON_HANG: mỗi dòng là 1 sản phẩm trong đơn
INSERT INTO CHI_TIET_DON_HANG (don_hang, san_pham, size) VALUES
-- Đơn 1 (id = 1): Trà Sữa Thái Xanh size L
(1, 1, 2),
-- Đơn 2 (id = 2): Trà Xanh Nhật Bản size M, Trà Sữa Socola size XL
(2, 3, 1),
(2, 5, 3),
-- Đơn 3 (id = 3): Trà Sữa Khoai Lang size M
(3, 4, 1),
-- Đơn 4 (id = 4): Trà Sữa Phô Mai Tươi Nướng size XL
(4, 14, 3),
-- Đơn 5 (id = 5): Sữa Tươi Trân Châu Đường Đen size L
(5, 13, 2),
-- Đơn 6 (id = 6): Nước Cam Ép size M
(6, 10, 1);

-- Thêm chi tiết đơn hàng
INSERT INTO CHI_TIET_DON_HANG (don_hang, san_pham, size) VALUES
-- Đơn 7: Trà Sữa Thái Xanh (L) + Trà Sữa Hồng Kông (M)
(7, 1, 2), (7, 2, 1),

-- Đơn 8: Trà Xanh Nhật Bản (XL) + Cà Phê Sữa Đá (M)
(8, 3, 3), (8, 6, 1),

-- Đơn 9: Trà Sữa Khoai Lang (L) + Trà Sữa Socola (XL)
(9, 4, 2), (9, 5, 3),

-- Đơn 10: Trà Sữa Phô Mai Tươi Nướng (M) + Sữa Tươi Trân Châu Đường Đen (L)
(10, 14, 1), (10, 13, 2),

-- Đơn 11: Trà Sữa Kem Trứng Cháy (XL) + Nước Cam Ép (M)
(11, 15, 3), (11, 10, 1),

-- Đơn 12: Trà Sữa Thái Xanh (L) + Trà Sữa Hồng Kông (XL)
(12, 1, 2), (12, 2, 3),

-- Đơn 13: Trà Xanh Nhật Bản (M) + Cà Phê Sữa Đá (L)
(13, 3, 1), (13, 6, 2),

-- Đơn 14: Trà Sữa Khoai Lang (XL) + Trà Sữa Socola (M)
(14, 4, 3), (14, 5, 1),

-- Đơn 15: Trà Sữa Phô Mai Tươi Nướng (L) + Sữa Tươi Trân Châu Đường Đen (XL)
(15, 14, 2), (15, 13, 3),

-- Đơn 16: Trà Sữa Kem Trứng Cháy (M) + Nước Cam Ép (L)
(16, 15, 1), (16, 10, 2),

-- Đơn 17: Trà Sữa Thái Xanh (XL) + Trà Sữa Hồng Kông (M)
(17, 1, 3), (17, 2, 1),

-- Đơn 18: Trà Xanh Nhật Bản (L) + Cà Phê Sữa Đá (XL)
(18, 3, 2), (18, 6, 3),

-- Đơn 19: Trà Sữa Khoai Lang (M) + Trà Sữa Socola (L)
(19, 4, 1), (19, 5, 2),

-- Đơn 20: Trà Sữa Phô Mai Tươi Nướng (XL) + Sữa Tươi Trân Châu Đường Đen (M)
(20, 14, 3), (20, 13, 1),

-- Đơn 21: Trà Sữa Kem Trứng Cháy (L) + Nước Cam Ép (XL)
(21, 15, 2), (21, 10, 3),

-- Đơn 22: Trà Sữa Thái Xanh (M) + Trà Sữa Hồng Kông (L)
(22, 1, 1), (22, 2, 2),

-- Đơn 23: Trà Xanh Nhật Bản (XL) + Cà Phê Sữa Đá (M)
(23, 3, 3), (23, 6, 1),

-- Đơn 24: Trà Sữa Khoai Lang (L) + Trà Sữa Socola (XL)
(24, 4, 2), (24, 5, 3),

-- Đơn 25: Trà Sữa Phô Mai Tươi Nướng (M) + Sữa Tươi Trân Châu Đường Đen (L)
(25, 14, 1), (25, 13, 2),

-- Đơn 26: Trà Sữa Kem Trứng Cháy (XL) + Nước Cam Ép (M)
(26, 15, 3), (26, 10, 1);

-- Thêm chi tiết topping cho các đơn hàng
INSERT INTO CHI_TIET_DON_HANG_TOPPING (chi_tiet_don_hang, topping) VALUES
-- Đơn 7
(7, 1), (7, 5), -- Trà Sữa Thái Xanh: Trân châu trắng, Thạch dừa
(8, 2), (8, 6), -- Trà Sữa Hồng Kông: Trân châu đen, Kem cheese

-- Đơn 8
(9, 6), -- Trà Xanh Nhật Bản: Kem cheese
(10, NULL), -- Cà Phê Sữa Đá: Không topping

-- Đơn 9
(11, 2), (11, 5), -- Trà Sữa Khoai Lang: Trân châu đen, Thạch dừa
(12, 3), (12, 8), -- Trà Sữa Socola: Pudding trứng, Marshmallow

-- Đơn 10
(13, 6), (13, 3), -- Trà Sữa Phô Mai Tươi Nướng: Kem cheese, Pudding trứng
(14, 2), -- Sữa Tươi Trân Châu Đường Đen: Trân châu đen

-- Đơn 11
(15, 6), (15, 3), -- Trà Sữa Kem Trứng Cháy: Kem cheese, Pudding trứng
(16, NULL), -- Nước Cam Ép: Không topping

-- Đơn 12
(17, 1), (17, 5), -- Trà Sữa Thái Xanh: Trân châu trắng, Thạch dừa
(18, 2), (18, 6), -- Trà Sữa Hồng Kông: Trân châu đen, Kem cheese

-- Đơn 13
(19, 6), -- Trà Xanh Nhật Bản: Kem cheese
(20, NULL), -- Cà Phê Sữa Đá: Không topping

-- Đơn 14
(21, 2), (21, 5), -- Trà Sữa Khoai Lang: Trân châu đen, Thạch dừa
(22, 3), (22, 8), -- Trà Sữa Socola: Pudding trứng, Marshmallow

-- Đơn 15
(23, 6), (23, 3), -- Trà Sữa Phô Mai Tươi Nướng: Kem cheese, Pudding trứng
(24, 2), -- Sữa Tươi Trân Châu Đường Đen: Trân châu đen

-- Đơn 16
(25, 6), (25, 3), -- Trà Sữa Kem Trứng Cháy: Kem cheese, Pudding trứng
(26, NULL), -- Nước Cam Ép: Không topping

-- Đơn 17
(27, 1), (27, 5), -- Trà Sữa Thái Xanh: Trân châu trắng, Thạch dừa
(28, 2), (28, 6), -- Trà Sữa Hồng Kông: Trân châu đen, Kem cheese

-- Đơn 18
(29, 6), -- Trà Xanh Nhật Bản: Kem cheese
(30, NULL), -- Cà Phê Sữa Đá: Không topping

-- Đơn 19
(31, 2), (31, 5), -- Trà Sữa Khoai Lang: Trân châu đen, Thạch dừa
(32, 3), (32, 8), -- Trà Sữa Socola: Pudding trứng, Marshmallow

-- Đơn 20
(33, 6), (33, 3), -- Trà Sữa Phô Mai Tươi Nướng: Kem cheese, Pudding trứng
(34, 2), -- Sữa Tươi Trân Châu Đường Đen: Trân châu đen

-- Đơn 21
(35, 6), (35, 3), -- Trà Sữa Kem Trứng Cháy: Kem cheese, Pudding trứng
(36, NULL), -- Nước Cam Ép: Không topping

-- Đơn 22
(37, 1), (37, 5), -- Trà Sữa Thái Xanh: Trân châu trắng, Thạch dừa
(38, 2), (38, 6), -- Trà Sữa Hồng Kông: Trân châu đen, Kem cheese

-- Đơn 23
(39, 6), -- Trà Xanh Nhật Bản: Kem cheese
(40, NULL), -- Cà Phê Sữa Đá: Không topping

-- Đơn 24
(41, 2), (41, 5), -- Trà Sữa Khoai Lang: Trân châu đen, Thạch dừa
(42, 3), (42, 8), -- Trà Sữa Socola: Pudding trứng, Marshmallow

-- Đơn 25
(43, 6), (43, 3), -- Trà Sữa Phô Mai Tươi Nướng: Kem cheese, Pudding trứng
(44, 2), -- Sữa Tươi Trân Châu Đường Đen: Trân châu đen

-- Đơn 26
(45, 6), (45, 3), -- Trà Sữa Kem Trứng Cháy: Kem cheese, Pudding trứng
(46, NULL); -- Nước Cam Ép: Không topping

SELECT DATE(ngaydat) AS Ngay, SUM(tongTien) AS DoanhThu, COUNT(*) AS SoDon
FROM DON_HANG
WHERE status = 2 -- Đã pha chế xong (hoặc trạng thái hoàn thành)
GROUP BY DATE(ngaydat)
ORDER BY Ngay DESC;

SELECT YEAR(ngaydat) AS Nam, MONTH(ngaydat) AS Thang, SUM(tongTien) AS DoanhThu, COUNT(*) AS SoDon
FROM DON_HANG
WHERE status = 2
GROUP BY YEAR(ngaydat), MONTH(ngaydat)
ORDER BY Nam DESC, Thang DESC;

SELECT YEAR(ngaydat) AS Nam, QUARTER(ngaydat) AS Quy, SUM(tongTien) AS DoanhThu, COUNT(*) AS SoDon
FROM DON_HANG
WHERE status = 2
GROUP BY YEAR(ngaydat), QUARTER(ngaydat)
ORDER BY Nam DESC, Quy DESC;

SELECT YEAR(ngaydat) AS Nam, SUM(tongTien) AS DoanhThu, COUNT(*) AS SoDon
FROM DON_HANG
WHERE status = 2
GROUP BY YEAR(ngaydat)
ORDER BY Nam DESC;

SELECT * FROM TeaMilk.NGUOI_DUNG;

-- BẢNG COMMENTS (Bình luận sản phẩm)
CREATE TABLE COMMENTS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES SAN_PHAM(MaSP),
    FOREIGN KEY (user_id) REFERENCES NGUOI_DUNG(MaND)
);

-- DỮ LIỆU MẪU: Khách hàng 01 bình luận
INSERT INTO COMMENTS (product_id, user_id, content, created_at) VALUES
(1, 7, 'Trà sữa Thái rất ngon, vị ngọt vừa phải, sẽ ủng hộ tiếp!', '2025-05-17 10:15:00'),
(4, 7, 'Trà sữa khoai lang thơm, màu đẹp, ship nhanh.', '2025-05-17 11:20:00'),
(1, 7, 'Mình thích thêm topping trân châu, uống rất đã!', '2025-05-17 12:05:00');
