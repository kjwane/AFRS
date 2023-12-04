> DB 모델링 주소 : 

URL : https://aquerytool.com/aquerymain/index/?rurl=051d0f56-9e8b-40dd-99e5-58b3a78521f0&
Password : p2ta06



> 데이터베이스 설계순서 ?
 요구사항분석 > 개념설계 > 논리설계 > 물리설계 > 데이터베이스 구현(개.눈.물)


 > 고객 코드 자동 증가 처리 : 1, 2, 3, ... 

 int, int unsigned 차이 

 int         ... 32 bit 정수(-2147483648~-1, 0~2147483647)  * 대충 -21억~+21억 
 int unsigned... 32 bit 정수(0~2147483647 + 2147483648)     * 대충     0~+42억 

 > 위도, 경도의 처리 

 위도(latitude,  lat) : 북위  36.23459 82134 8521  ... DECIMAL(17,14) = NUMERIC(17,14) , 오라클  NUMBER(17, 14)
 경도(longitude, lng) : 동경 127.12459 51823 4910  ... DECIMAL(17,14) = NUMERIC(17,14)

> 엔터티 간의 관계를 따져보다.

옷 제조사(tb_company) -------------판매상품(tb_product)

      1                   :         0 ,  1,  N(Numerous, 여러개의)

ERD
ER-Diagram 
Entity Relationship Diagram

Relation     : 일반적인 관계
Relations    : 국가간의 관계   (relations) between the two countries.
Relationship : 개인적인 관계    

> 엔터티 설계의 기본 원칙 

S(고객) + V(구매) + O(상품)
S(고객) + V(예약) + O(호텔)
-----------------------------------------------------------
(최종 프로젝트 MySQL SQL문)

-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- tb_company Table Create SQL
-- 테이블 생성 SQL - tb_company

use Insa4_IOTA_final_5;
CREATE TABLE tb_company
(
    `company_code`   INT UNSIGNED      NOT NULL    AUTO_INCREMENT COMMENT '회사 코드', 
    `company_name`   VARCHAR(50)       NOT NULL    COMMENT '회사 이름', 
    `company_owner`  VARCHAR(30)       NOT NULL    COMMENT '회사 대표자', 
    `company_tel`    VARCHAR(20)       NOT NULL    COMMENT '회사 전화', 
    `company_addr1`  VARCHAR(500)      NOT NULL    COMMENT '회사 주소1', 
    `company_addr2`  VARCHAR(500)      NOT NULL    COMMENT '회사 주소2', 
    `company_lat`    NUMERIC(17,14)    NULL        COMMENT '회사 위도', 
    `company_lng`    NUMERIC(17,14)    NULL        COMMENT '회사 경도', 
     PRIMARY KEY (company_code)
);

-- 테이블 Comment 설정 SQL - tb_company
ALTER TABLE tb_company COMMENT '옷 제조사';

-- Index 설정 SQL - tb_company(company_name)
CREATE INDEX IX_tb_company_1
    ON tb_company(company_name);


-- tb_customer Table Create SQL
-- 테이블 생성 SQL - tb_customer
CREATE TABLE tb_customer
(
    `cust_id`      VARCHAR(50)    NOT NULL    COMMENT '고객 아이디', 
    `cust_pw`      VARCHAR(30)    NOT NULL    COMMENT '고객 비밀번호', 
    `cust_name`    VARCHAR(50)    NOT NULL    COMMENT '고객 이름', 
    `joined_at`    DATETIME       NOT NULL    DEFAULT now() COMMENT '고객 가입일', 
    `cust_score`   INT            NOT NULL    COMMENT '고객 구매점수', 
    `cust_region`  VARCHAR(40)    NOT NULL    COMMENT '고객 지역명', 
     PRIMARY KEY (cust_id)
);

-- 테이블 Comment 설정 SQL - tb_customer
ALTER TABLE tb_customer COMMENT '고객';

-- Index 설정 SQL - tb_customer(cust_name)
CREATE INDEX IX_tb_customer_1
    ON tb_customer(cust_name);


-- tb_product Table Create SQL
-- 테이블 생성 SQL - tb_product
CREATE TABLE tb_product
(
    `product_code`   INT UNSIGNED    NOT NULL    AUTO_INCREMENT COMMENT '상품 코드', 
    `product_name`   VARCHAR(50)     NOT NULL    COMMENT '상품 명', 
    `product_price`  INT             NOT NULL    COMMENT '상품 가격', 
    `product_yn`     CHAR(1)         NOT NULL    COMMENT '상품 보유여부', 
    `product_cnt`    INT             NOT NULL    COMMENT '상품 재고수량', 
    `product_at`     DATETIME        NOT NULL    DEFAULT now() COMMENT '상품 등록일자', 
    `company_cd`     INT UNSIGNED    NOT NULL    COMMENT '회사 코드', 
     PRIMARY KEY (product_code)
);

-- 테이블 Comment 설정 SQL - tb_product
ALTER TABLE tb_product COMMENT '판매상품';

-- Index 설정 SQL - tb_product(product_name)
CREATE INDEX IX_tb_product_1
    ON tb_product(product_name);

-- Foreign Key 설정 SQL - tb_product(company_cd) -> tb_company(company_code)
ALTER TABLE tb_product
    ADD CONSTRAINT FK_tb_product_company_cd_tb_company_company_code FOREIGN KEY (company_cd)
        REFERENCES tb_company (company_code) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - tb_product(company_cd)
-- ALTER TABLE tb_product
-- DROP FOREIGN KEY FK_tb_product_company_cd_tb_company_company_code;


-- tb_staff Table Create SQL
-- 테이블 생성 SQL - tb_staff
CREATE TABLE tb_staff
(
    `staff_code`    INT UNSIGNED    NOT NULL    AUTO_INCREMENT COMMENT '스탭 코드', 
    `staff_name`    VARCHAR(50)     NOT NULL    COMMENT '스탭 이름', 
    `staff_region`  VARCHAR(50)     NOT NULL    COMMENT '스탭 담당지역', 
    `company_code`  INT UNSIGNED    NOT NULL    COMMENT '회사 코드', 
     PRIMARY KEY (staff_code)
);

-- 테이블 Comment 설정 SQL - tb_staff
ALTER TABLE tb_staff COMMENT '스텝';

-- Foreign Key 설정 SQL - tb_staff(company_code) -> tb_company(company_code)
ALTER TABLE tb_staff
    ADD CONSTRAINT FK_tb_staff_company_code_tb_company_company_code FOREIGN KEY (company_code)
        REFERENCES tb_company (company_code) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - tb_staff(company_code)
-- ALTER TABLE tb_staff
-- DROP FOREIGN KEY FK_tb_staff_company_code_tb_company_company_code;


-- tb_purchase Table Create SQL
-- 테이블 생성 SQL - tb_purchase
CREATE TABLE tb_purchase
(
    `purchase_code`  INT UNSIGNED    NOT NULL    AUTO_INCREMENT COMMENT '구매 코드', 
    `cust_id`        VARCHAR(50)     NOT NULL    COMMENT '고객 아이디', 
    `product_code`   INT UNSIGNED    NOT NULL    COMMENT '상품 코드', 
    `purchase_cnt`   INT             NOT NULL    COMMENT '구매 수량', 
    `purchased_at`   DATETIME        NOT NULL    DEFAULT now() COMMENT '구매 날짜', 
     PRIMARY KEY (purchase_code)
);

-- 테이블 Comment 설정 SQL - tb_purchase
ALTER TABLE tb_purchase COMMENT '구매';

-- Foreign Key 설정 SQL - tb_purchase(product_code) -> tb_product(product_code)
ALTER TABLE tb_purchase
    ADD CONSTRAINT FK_tb_purchase_product_code_tb_product_product_code FOREIGN KEY (product_code)
        REFERENCES tb_product (product_code) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - tb_purchase(product_code)
-- ALTER TABLE tb_purchase
-- DROP FOREIGN KEY FK_tb_purchase_product_code_tb_product_product_code;

-- Foreign Key 설정 SQL - tb_purchase(cust_id) -> tb_customer(cust_id)
ALTER TABLE tb_purchase
    ADD CONSTRAINT FK_tb_purchase_cust_id_tb_customer_cust_id FOREIGN KEY (cust_id)
        REFERENCES tb_customer (cust_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - tb_purchase(cust_id)
-- ALTER TABLE tb_purchase
-- DROP FOREIGN KEY FK_tb_purchase_cust_id_tb_customer_cust_id;


-- tb_images Table Create SQL
-- 테이블 생성 SQL - tb_images
CREATE TABLE tb_images
(
    `image_code`    INT UNSIGNED     NOT NULL    AUTO_INCREMENT COMMENT '이미지 코드', 
    `product_code`  INT UNSIGNED     NOT NULL    COMMENT '상품 코드', 
    `image_path1`   VARCHAR(1000)    NOT NULL    COMMENT '이미지 경로1', 
    `image_path2`   VARCHAR(1000)    NULL        COMMENT '이미지 경로2', 
    `image_path3`   VARCHAR(1000)    NULL        COMMENT '이미지 경로3', 
    `image_path4`   VARCHAR(1000)    NULL        COMMENT '이미지 경로4', 
    `image_path5`   VARCHAR(1000)    NULL        COMMENT '이미지 경로5', 
    `image_path6`   VARCHAR(1000)    NULL        COMMENT '이미지 경로6', 
    `image_path7`   VARCHAR(1000)    NULL        COMMENT '이미지 경로7', 
    `image_path8`   VARCHAR(1000)    NULL        COMMENT '이미지 경로8', 
    `image_path9`   VARCHAR(1000)    NULL        COMMENT '이미지 경로9', 
    `image_path10`  VARCHAR(1000)    NULL        COMMENT '이미지 경로10', 
     PRIMARY KEY (image_code)
);

-- 테이블 Comment 설정 SQL - tb_images
ALTER TABLE tb_images COMMENT '상품 이미지';

-- Foreign Key 설정 SQL - tb_images(product_code) -> tb_product(product_code)
ALTER TABLE tb_images
    ADD CONSTRAINT FK_tb_images_product_code_tb_product_product_code FOREIGN KEY (product_code)
        REFERENCES tb_product (product_code) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - tb_images(product_code)
-- ALTER TABLE tb_images
-- DROP FOREIGN KEY FK_tb_images_product_code_tb_product_product_code;


