import streamlit as st
import mysql.connector
import pandas as pd
from sqlalchemy import create_engine

st.set_page_config(page_title="Product", page_icon="📋", layout="wide")

# MySQL 연결 설정
db_config = {
    "host": "project-db-stu3.smhrd.com",
    "port": 3307,
    "user": "Insa4_IOTA_final_5",
    "password": "aischool5",
    "database": "Insa4_IOTA_final_5",
}

# Streamlit 애플리케이션 시작
st.title("📑 재고관리 페이지")

# 사용자로부터 입력 받기
user_input_product_code = st.text_input("상품코드:")
user_input_product_name = st.text_input("상품명:")
user_input_product_price = st.text_input("상품가격:")
user_input_product_cnt = st.text_input("상품재고:")
user_input_company_cd = st.text_input("회사코드:")

# 'Submit' 버튼 클릭 시 동작
if st.button("제출"):
    # 입력값이 비어 있는지 확인
    if not all([user_input_product_code, user_input_product_price, user_input_product_cnt, user_input_company_cd]):
        st.warning("입력값이 누락되었습니다. 다시 입력해주세요.")
    else:
        # MySQL에 데이터 삽입 또는 업데이트
        try:
            connection = mysql.connector.connect(**db_config)
            cursor = connection.cursor()

            # 상품코드가 이미 존재하는지 확인
            check_query = "SELECT * FROM tb_product WHERE product_code = %s"
            cursor.execute(check_query, (int(user_input_product_code),))
            existing_record = cursor.fetchone()

            if existing_record:
                # 이미 존재하면 업데이트
                update_query = "UPDATE tb_product SET product_price = %s, product_cnt = %s, company_cd = %s WHERE product_code = %s"
                update_data = (
                    float(user_input_product_price),
                    int(user_input_product_cnt),
                    int(user_input_company_cd),
                    int(user_input_product_code),
                )
                if user_input_product_name:  # 상품명이 비어있지 않으면 업데이트
                    update_query = "UPDATE tb_product SET product_name = %s, " + update_query[22:]
                    update_data = (user_input_product_name,) + update_data

                cursor.execute(update_query, update_data)
                st.success("SQL에 데이터가 업데이트되었습니다!")

            else:
                # 존재하지 않으면 삽입
                insert_query = "INSERT INTO tb_product (product_code, product_name, product_price, product_cnt, company_cd) VALUES (%s, %s, %s, %s, %s)"
                insert_data = (
                    int(user_input_product_code),
                    user_input_product_name,
                    float(user_input_product_price),
                    int(user_input_product_cnt),
                    int(user_input_company_cd),
                )
                cursor.execute(insert_query, insert_data)
                st.success("SQL에 데이터가 저장되었습니다!")

            # 변경 사항 커밋
            connection.commit()

        except Exception as e:
            st.error(f"Error: {e}")

        finally:
            # 연결 닫기
            if connection.is_connected():
                cursor.close()
                connection.close()

# MySQL에서 데이터를 읽어와 DataFrame으로 변환
engine = create_engine(f"mysql+mysqlconnector://{db_config['user']}:{db_config['password']}@{db_config['host']}:{db_config['port']}/{db_config['database']}")
select_query = "SELECT * FROM tb_product"
df = pd.read_sql(select_query, engine)

# DataFrame 출력 (크기 조절 및 왼쪽 정렬)
st.title("")
st.write("재고 현황")
st.dataframe(df.style.set_properties(**{'text-align': 'left'}, subset=pd.IndexSlice[:, :]), height=250, width=1100)



