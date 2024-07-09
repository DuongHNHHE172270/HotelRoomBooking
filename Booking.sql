create database DemoHotel
use DemoHotel
CREATE TABLE "Type_customer"(
    "type_customer" INT IDENTITY(1,1) NOT NULL,
    "type_customer_name" NVARCHAR(255) NOT NULL,
    "money_level" FLOAT NOT NULL, 
    "discount" FLOAT NOT NULL,
    CONSTRAINT "type_customer_type_customer_primary" PRIMARY KEY("type_customer")
);

CREATE TABLE "Customer"(
    "customer_id" INT IDENTITY(1,1) NOT NULL,
    "type_customer" INT NOT NULL,
    "first_name" NVARCHAR(255),
    "last_name" NVARCHAR(255),
    "email" NVARCHAR(255) Unique NOT NULL,
    "password" NVARCHAR(255) NOT NULL,
    "phone" NVARCHAR(255),
    "address" NVARCHAR(255),
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "customer_customer_id_primary" PRIMARY KEY("customer_id"),
    CONSTRAINT "customer_type_customer_foreign" FOREIGN KEY("type_customer") REFERENCES "Type_customer"("type_customer")
);


CREATE TABLE "Role"(
    "staff_type_id" INT IDENTITY(1,1) NOT NULL,
    "type" NVARCHAR(255) NOT NULL,
    CONSTRAINT "role_staff_type_id_primary" PRIMARY KEY("staff_type_id")
);

CREATE TABLE "Staff"(
    "staff_id" INT IDENTITY(1,1) NOT NULL,
    "staff_type_id" INT NOT NULL,
    "email" NVARCHAR(255) NOT NULL,
    "password" NVARCHAR(255) NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "staff_staff_id_primary" PRIMARY KEY("staff_id"),
    CONSTRAINT "staff_staff_type_id_foreign" FOREIGN KEY("staff_type_id") REFERENCES "Role"("staff_type_id")
);

CREATE TABLE "Room_type"(
    "room_type_id" INT IDENTITY(1,1) NOT NULL,
    "type_name" NVARCHAR(255) NOT NULL,
    "status" NVARCHAR(255) NULL,
	"quantity" int not null,
	"roomtype_img"  NVARCHAR(255) NOT NULL,
	"title_descripsion" NVARCHAR(255) NOT NULL,
    "roomtype_descripsion" NVARCHAR(MAX) NOT NULL,
	"content_descripsion" NVARCHAR(MAX) NOT NULL,
	"room_type_price" FLOAT NOT NULL,
    CONSTRAINT "room_type_room_type_id_primary" PRIMARY KEY("room_type_id")
);

CREATE TABLE "Room"(
    "room_id" INT IDENTITY(1,1) NOT NULL,
    "room_type_id" INT NOT NULL,
    "room_name" NVARCHAR(255) NOT NULL,
	
    "room_status" NVARCHAR(255) NULL,
    CONSTRAINT "room_room_id_primary" PRIMARY KEY("room_id"),
    CONSTRAINT "room_room_type_id_foreign" FOREIGN KEY("room_type_id") REFERENCES "Room_type"("room_type_id")
);

CREATE TABLE "Room_Images"(
    "room_type_id" INT,
    "img" NVARCHAR(255),
    CONSTRAINT "room_images_room_type_id_foreign" FOREIGN KEY("room_type_id") REFERENCES "Room_type"("room_type_id")
);

CREATE TABLE "Service"(
    "service_id" INT IDENTITY(1,1) NOT NULL,
    "name_service" NVARCHAR(MAX) NOT NULL,
    "title_service" NVARCHAR(MAX) NULL,
    "description" NVARCHAR(MAX) NULL,
    "img" NVARCHAR(MAX) NULL,
    "status" NVARCHAR(MAX) NOT NULL,
	"service_price" FLOAT NOT NULL,
    CONSTRAINT "service_service_id_primary" PRIMARY KEY("service_id"),
);

CREATE TABLE "Event_id"(
    "event_id" INT IDENTITY(1,1) NOT NULL,
	"title_event" NVARCHAR(MAX) NULL,
	"img" NVARCHAR(MAX) NOT NULL,
    "start_date" DATETIME NOT NULL,
    "end_date" DATETIME NOT NULL,
    "detail" NVARCHAR(MAX) NOT NULL,
    "discount_percent" FLOAT NOT NULL,
    "description" NVARCHAR(MAX) NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "event_id_event_id_primary" PRIMARY KEY("event_id"),
);

CREATE TABLE "News"(
    "news_id" INT IDENTITY(1,1) NOT NULL,
    "staff_id" INT NOT NULL,
    "img" NVARCHAR(MAX) NOT NULL,
    "title" NVARCHAR(MAX) NOT NULL,
    "create_date" DATE NOT NULL,
    "desccription" NVARCHAR(MAX) NOT NULL,
    "status" NVARCHAR(MAX) NOT NULL,
    CONSTRAINT "news_news_id_primary" PRIMARY KEY("news_id"),
    CONSTRAINT "news_staff_id_foreign" FOREIGN KEY("staff_id") REFERENCES "Staff"("staff_id")
);

CREATE TABLE "Detail_news"(
    "detail_news_id" INT IDENTITY(1,1) NOT NULL,
    "news_id" INT NOT NULL,
    "content" NVARCHAR(MAX) NOT NULL,
    CONSTRAINT "detail_news_detail_news_id_primary" PRIMARY KEY("detail_news_id"),
    CONSTRAINT "detail_news_news_id_foreign" FOREIGN KEY("news_id") REFERENCES "News"("news_id")
);

CREATE TABLE "Reservation"(
    "reservation_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "discountpercent_level" FLOAT NOT NULL,
    "event_id" INT,
    "total_price" FLOAT NOT NULL,
	"quantity" int not null,
	"staff_id" INT,
    CONSTRAINT "reservation_reservation_id_primary" PRIMARY KEY("reservation_id"),
    CONSTRAINT "reservation_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id"),
    CONSTRAINT "reservation_event_id_foreign" FOREIGN KEY("event_id") REFERENCES "Event_id"("event_id"),
	CONSTRAINT "reservation_staff_id_foreign" FOREIGN KEY("staff_id") REFERENCES "Staff"("staff_id")
);

CREATE TABLE "Invoice_customer"(
    "invoice_customer_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
    "reservation_id" INT NOT NULL,
    "invoice_amount" FLOAT NOT NULL,
    "ts_paid" DATETIME NULL,
    CONSTRAINT "invoice_customer_invoice_customer_id_primary" PRIMARY KEY("invoice_customer_id"),
    CONSTRAINT "invoice_customer_reservation_id_foreign" FOREIGN KEY("reservation_id") REFERENCES "Reservation"("reservation_id"),
    CONSTRAINT "invoice_customer_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id")
);

CREATE TABLE "Level_customer"(
    "level_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
    "reservation_id" INT NOT NULL,
    "total" FLOAT NOT NULL,
    CONSTRAINT "level_customer_level_id_primary" PRIMARY KEY("level_id"),
    CONSTRAINT "level_customer_reservation_id_foreign" FOREIGN KEY("reservation_id") REFERENCES "Reservation"("reservation_id"),
    CONSTRAINT "level_customer_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id")
);

CREATE TABLE "Comment"(
    "comment_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
    "detai_new_id" INT NOT NULL,
    "content" NVARCHAR(MAX) NOT NULL,
    "comment_date" DATE NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "comment_comment_id_primary" PRIMARY KEY("comment_id"),
    CONSTRAINT "comment_detai_new_id_foreign" FOREIGN KEY("detai_new_id") REFERENCES "Detail_news"("detail_news_id"),
    CONSTRAINT "comment_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id")
);

CREATE TABLE "Reply"(
    "reply_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
    "comment_id" INT NOT NULL,
    "content" NVARCHAR(MAX) NOT NULL,
    "reply_date" DATE NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "reply_reply_id_primary" PRIMARY KEY("reply_id"),
    CONSTRAINT "reply_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id"),
    CONSTRAINT "reply_comment_id_foreign" FOREIGN KEY("comment_id") REFERENCES "Comment"("comment_id")
);

CREATE TABLE "Room_reserved"(
    "reservation_id" INT NOT NULL,
    "room_id" INT NOT NULL,
    "price" FLOAT NOT NULL,
    CONSTRAINT "room_reserved_reservation_id_foreign" FOREIGN KEY("reservation_id") REFERENCES "Reservation"("reservation_id"),
    CONSTRAINT "room_reserved_room_id_foreign" FOREIGN KEY("room_id") REFERENCES "Room"("room_id")
);

CREATE TABLE "Room_service"(
    "service_id" INT NOT NULL,
    "room_type_id" INT NOT NULL,
    CONSTRAINT "room_service_service_id_foreign" FOREIGN KEY("service_id") REFERENCES "Service"("service_id"),
    CONSTRAINT "room_service_room_type_id_foreign" FOREIGN KEY("room_type_id") REFERENCES "Room_type"("room_type_id")
);

CREATE TABLE "Review"(
    "review_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
	"room_type_id" INT NOT NULL,
    "description" NVARCHAR(MAX) NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "review_review_id_primary" PRIMARY KEY("review_id"),
    CONSTRAINT "review_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id"),
	CONSTRAINT "review_room_type_id_foreign" FOREIGN KEY("room_type_id") REFERENCES "Room_type"("room_type_id")
);

CREATE TABLE "Convenient" (
	"convenient_id" INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	"convenient_name" NVARCHAR(255) NOT NULL,
	"status" NVARCHAR(255) NOT NULL	
);

CREATE TABLE "Room_Convenient" (
    "room_id" INT NOT NULL,
    "convenient_id" INT NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    PRIMARY KEY ("room_id", "convenient_id"),
    CONSTRAINT "room_convenient_room_id_foreign" FOREIGN KEY ("room_id") REFERENCES "Room"("room_id"),
    CONSTRAINT "room_convenient_convenient_id_foreign" FOREIGN KEY ("convenient_id") REFERENCES "Convenient"("convenient_id")
);
CREATE TABLE "Service_reserved"(
	"reservation_id" INT NOT NULL,
    "service_id" INT NOT NULL,
    CONSTRAINT "service_reserved_reservation_id_foreign" FOREIGN KEY("reservation_id") REFERENCES "Reservation"("reservation_id"),
    CONSTRAINT "service_reserved_service_id_foreign" FOREIGN KEY("service_id") REFERENCES "Service"("service_id")
);
--------------------------------------------------------------------
INSERT INTO "Role" ( "type")
VALUES
( N'Admin'),
( N'Staff')








INSERT INTO "Customer"("type_customer", "first_name", "last_name", "email", "password", "phone", "address", "status") 
VALUES
(1, 'John', 'Doe', 'mahihoang0@gmail.com', '123456', '123456789', '123 Main St, City', 'Active'),
(1, 'John', 'Doe', 'mikizay175d@gmail.com', '123456', '123456789', '123 Main St, City', 'Active')

INSERT INTO "Type_customer" ("type_customer_name", "money_level",  "discount")
VALUES
('VIP', 2, 0.5)
select * from role
select * from staff
select * from "Customer"
select * from "Type_customer"

INSERT INTO "Staff" ( "staff_type_id", "email", "password", "status")
VALUES
( 1, 'admin', 'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', 'active'),
( 2, 'dinhtu@gmail.com', 'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', 'active')


--Insert DemoHotel
--------------------------------------------------------------------
use DemoHotel;
-----------------------------------------------------------------
-- Insert 5 rows into Type_customer
INSERT INTO Type_customer (type_customer_name, money_level, discount)
VALUES 
(N'New', 0.0, 0.0),
(N'Silver', 1000000.0, 5.0),
(N'Gold', 5000000.0, 10.0),
(N'Platinum', 10000000.0, 15.0),
(N'Diamond', 20000000.0, 20.0);

-- Insert 5 rows into Customer
INSERT INTO Customer (type_customer, first_name, last_name, email, password, phone, address, status)
VALUES 
(1, N'Vinh', N'Tiến', N'vinhtien@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456789', N'123 Main St, City', N'active'),
(1, N'Hà', N'Thành Công', N'mikizay175d@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456789', N'123 Main St, City', N'active'),
(2, N'Jim', N'Brown', N'abc@example.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456789', N'345 Pine St', N'active'),
(4, N'Jack', N'Jones', N'abc123@example.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456789', N'456 Maple St', N'active'),
(5, N'Jill', N'Taylor', N'a@example.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'123456789', N'567 Cedar St', N'active');

-- Insert 2 rows into Role
INSERT INTO Role (type)
VALUES 
( N'Quản trị viên'),
( N'Nhân viên')

-- Insert 5 rows into Staff
INSERT INTO Staff (staff_type_id, email, password, status)
VALUES 
( 1, N'admin@gmail.com', N'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', N'active'),   --pass: 111111
( 2, N'dinhtu@gmail.com', N'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', N'active'),   --pass: 111111
( 2, N'nhanvien1@gmail.com', N'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', N'active'),   --pass: 111111
( 2, N'nhanvien2@gmail.com', N'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', N'active'),   --pass: 111111
( 2, N'nhanvien3@gmail.com', N'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', N'inactive');

-- Bảng Room_type
INSERT INTO "Room_type" ("type_name", "status", "quantity", "roomtype_img", "title_descripsion", "roomtype_descripsion", "content_descripsion", "room_type_price")
VALUES
(N'Phòng đơn', N'active', 10, N'img1.jpg', N'Phòng đơn hiện đại', N'Phòng đơn với nội thất hiện đại', N'Tiện nghi và thoải mái', 500000),
(N'Phòng đôi', N'active', 8, N'img2.jpg', N'Phòng đôi sang trọng', N'Phòng đôi với trang thiết bị cao cấp', N'Rộng rãi và tiện nghi', 800000),
(N'Phòng gia đình', N'active', 5, N'img3.jpg', N'Phòng gia đình', N'Phòng rộng cho gia đình', N'Thoải mái và tiện lợi', 1200000),
(N'Phòng VIP', N'active', 2, N'img4.jpg', N'Phòng VIP đẳng cấp', N'Phòng VIP với dịch vụ cao cấp', N'Sang trọng và đẳng cấp', 2000000),
(N'Phòng suite', N'inactive', 3, N'img5.jpg', N'Phòng suite', N'Phòng suite với thiết kế đẹp', N'Không gian sống đẳng cấp', 1500000);

-- Bảng Room
INSERT INTO "Room" ("room_type_id", "room_name", "room_status")
VALUES
(1, N'Phòng 101', N'active'),
(2, N'Phòng 202', N'active'),
(3, N'Phòng 303', N'active'),
(4, N'Phòng 404', N'inactive'),
(5, N'Phòng 505', N'active'),
(1, N'Phòng 102', N'active'),
(1, N'Phòng 103', N'active'),
(1, N'Phòng 104', N'active'),
(1, N'Phòng 105', N'active'),
(1, N'Phòng 106', N'active'),
(1, N'Phòng 107', N'active'),
(1, N'Phòng 108', N'active'),
(1, N'Phòng 109', N'active'),
(1, N'Phòng 110', N'active'),
(1, N'Phòng 111', N'active'),
(2, N'Phòng 201', N'active'),
(2, N'Phòng 203', N'active'),
(2, N'Phòng 204', N'active'),
(2, N'Phòng 205', N'active'),
(2, N'Phòng 206', N'active'),
(2, N'Phòng 207', N'active'),
(2, N'Phòng 208', N'active'),
(3, N'Phòng 301', N'active'),
(3, N'Phòng 301', N'active'),
(3, N'Phòng 304', N'active'),
(3, N'Phòng 305', N'active'),
(4, N'Phòng 401', N'active'),
(4, N'Phòng 402', N'active'),
(5, N'Phòng 501', N'active'),
(5, N'Phòng 502', N'active'),
(5, N'Phòng 503', N'active');

-- Bảng Room_Images
INSERT INTO "Room_Images" ("room_type_id", "img")
VALUES
(1, N'img1_1.jpg'),
(1, N'img1_2.jpg'),
(1, N'img1_3.jpg'),
(2, N'img2_1.jpg'),
(2, N'img2_2.jpg'),
(2, N'img2_3.jpg'),
(3, N'img3_1.jpg'),
(3, N'img3_2.jpg'),
(3, N'img3_2.jpg');

-- Bảng Service
INSERT INTO "Service" ("name_service", "title_service", "description", "img", "status", "service_price")
VALUES
(N'Dịch vụ giặt là', N'Giặt là nhanh', N'Dịch vụ giặt là trong ngày', N'service1.jpg', N'active', 100000),
(N'Dịch vụ ăn uống', N'Ăn uống tại phòng', N'Phục vụ các món ăn tại phòng', N'service2.jpg', N'active', 300000),
(N'Dịch vụ massage', N'Massage thư giãn', N'Dịch vụ massage chuyên nghiệp', N'service3.jpg', N'active', 500000),
(N'Dịch vụ đưa đón sân bay', N'Đưa đón tận nơi', N'Dịch vụ đưa đón sân bay', N'service4.jpg', N'inactive', 700000),
(N'Dịch vụ spa', N'Chăm sóc sắc đẹp', N'Dịch vụ spa làm đẹp', N'service5.jpg', N'active', 800000);

-- Bảng Event_id
INSERT INTO "Event_id" ("title_event", "img", "start_date", "end_date", "detail", "discount_percent", "description", "status")
VALUES
(N'Khuyến mãi mùa hè', N'event1.jpg', '2024-06-01', '2024-06-30', N'Giảm giá đặc biệt cho mùa hè', 10, N'Khuyến mãi lớn cho tất cả các phòng', N'active'),
(N'Khuyến mãi cuối năm', N'event2.jpg', '2024-12-01', '2024-12-31', N'Ưu đãi cuối năm', 15, N'Giảm giá cho dịch vụ và phòng', N'active'),
(N'Giáng sinh an lành', N'event3.jpg', '2024-12-24', '2024-12-26', N'Sự kiện Giáng sinh đặc biệt', 20, N'Ưu đãi cho khách hàng đặt phòng trong dịp Giáng sinh', N'active'),
(N'Lễ hội mùa xuân', N'event4.jpg', '2024-01-01', '2024-01-07', N'Khuyến mãi đầu năm', 25, N'Giảm giá cho tất cả các dịch vụ', N'active'),
(N'Ưu đãi tháng 7', N'event5.jpg', '2024-07-01', '2024-07-31', N'Khuyến mãi cho tháng 7', 30, N'Giảm giá đặc biệt cho khách hàng thân thiết', N'inactive');

-- Bảng News
INSERT INTO "News" ("staff_id", "img", "title", "create_date", "desccription", "status")
VALUES
(1, N'news1.jpg', N'Tin tức khách sạn', '2024-07-01', N'Cập nhật tình hình khách sạn', N'active'),
(2, N'news2.jpg', N'Khuyến mãi mới', '2024-07-02', N'Thông tin khuyến mãi mới nhất', N'active'),
(3, N'news3.jpg', N'Sự kiện sắp tới', '2024-07-03', N'Thông báo về các sự kiện sắp tới', N'active'),
(4, N'news4.jpg', N'Cập nhật dịch vụ', '2024-07-04', N'Thông tin về các dịch vụ mới', N'inactive'),
(5, N'news5.jpg', N'Thành tựu đạt được', '2024-07-05', N'Khách sạn nhận giải thưởng quốc tế', N'active');

-- Bảng Detail_news
INSERT INTO "Detail_news" ("news_id", "content")
VALUES
(1, N'Chi tiết tin tức khách sạn 1'),
(2, N'Chi tiết tin tức khách sạn 2'),
(3, N'Chi tiết tin tức khách sạn 3'),
(4, N'Chi tiết tin tức khách sạn 4'),
(5, N'Chi tiết tin tức khách sạn 5');

-- Bảng Reservation
INSERT INTO "Reservation" ("customer_id", "start_date", "end_date", "discountpercent_level", "event_id", "total_price", "quantity", "staff_id")
VALUES
(1, '2024-07-01', '2024-07-05', 10, 1, 2000000, 2, 1),
(2, '2024-07-02', '2024-07-06', 15, 2, 3000000, 3, 2),
(3, '2024-07-03', '2024-07-07', 20, 3, 4000000, 4, 3),
(4, '2024-07-04', '2024-07-08', 25, 4, 5000000, 5, 4),
(5, '2024-07-05', '2024-07-09', 30, 5, 6000000, 6, 5);

-- Bảng Invoice_customer
INSERT INTO "Invoice_customer" ("customer_id", "reservation_id", "invoice_amount", "ts_paid")
VALUES
(1, 1, 2000000, '2024-07-06 10:00:00'),
(2, 2, 3000000, '2024-07-07 11:00:00'),
(3, 3, 4000000, '2024-07-08 12:00:00'),
(4, 4, 5000000, '2024-07-09 13:00:00'),
(5, 5, 6000000, '2024-07-10 14:00:00');

-- Bảng Level_customer
INSERT INTO "Level_customer" ("customer_id", "reservation_id", "total")
VALUES
(1, 1, 2000000),
(2, 2, 3000000),
(3, 3, 4000000),
(4, 4, 5000000),
(5, 5, 6000000);

-- Bảng Comment
INSERT INTO "Comment" ("customer_id", "detai_new_id", "content", "comment_date", "status")
VALUES
(1, 1, N'Bài viết rất hay', '2024-07-01', N'active'),
(2, 2, N'Thông tin hữu ích', '2024-07-02', N'active'),
(3, 3, N'Cập nhật nhanh chóng', '2024-07-03', N'active'),
(4, 4, N'Rất đáng đọc', '2024-07-04', N'active'),
(5, 5, N'Nội dung quá chán', '2024-07-05', N'inactive');

-- Bảng Reply
INSERT INTO "Reply" ("customer_id", "comment_id", "content", "reply_date", "status")
VALUES
(1, 1, N'Cảm ơn bạn', '2024-07-01', N'active'),
(2, 2, N'Rất vui vì bạn thích', '2024-07-02', N'active'),
(3, 3, N'Cảm ơn sự góp ý', '2024-07-03', N'active'),
(4, 4, N'Tôi sẽ cải thiện', '2024-07-04', N'active'),
(5, 5, N'Mong bạn tiếp tục ủng hộ', '2024-07-05', N'inactive');

-- Bảng Room_reserved
INSERT INTO "Room_reserved" ("reservation_id", "room_id", "price")
VALUES
(1, 1, 1000000),
(2, 2, 1500000),
(3, 3, 2000000),
(4, 4, 2500000),
(5, 5, 3000000);

-- Bảng Room_service
INSERT INTO "Room_service" ("service_id", "room_type_id")
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Bảng Review
INSERT INTO "Review" ("customer_id", "room_type_id", "description", "status")
VALUES
(1, 1, N'Phòng rất sạch sẽ', 'active'),
(2, 1, N'Dịch vụ tốt', 'active'),
(2, 1, N'Phòng VIP rất đẹp', 'active'),
(3, 2, N'Giá cả hợp lý', 'active'),
(4, 2, N'Nhân viên thân thiện', 'active'),
(4, 3, N'Vị trí thuận tiện', 'inactive'),
(3, 4, N'Phòng sáng, mát', 'inactive'),
(5, 4, N'Nhân viên nhiệt tình', 'inactive');

-- Bảng Convenient
INSERT INTO "Convenient" ("convenient_name", "status")
VALUES
(N'Wi-Fi miễn phí', N'active'),
(N'Điều hòa', N'active'),
(N'Truyền hình cáp', N'active'),
(N'Mini bar', N'active'),
(N'Dịch vụ phòng', N'inactive');

-- Bảng Room_Convenient
INSERT INTO "Room_Convenient" ("room_id", "convenient_id", "status")
VALUES
(1, 1, N'active'),
(1, 2, N'active'),
(1, 3, N'active'),
(2, 2, N'active'),
(2, 3, N'active'),
(2, 4, N'active'),
(3, 1, N'active'),
(3, 2, N'active'),
(3, 3, N'active'),
(3, 4, N'process'),
(4, 4, N'process');

-- Bảng Service_reserved
INSERT INTO "Service_reserved" ("reservation_id", "service_id")
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

